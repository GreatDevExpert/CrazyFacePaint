//
//  HttpRequest.m
//
//  Created by William Locke on 4/6/12.
//  Copyright (c) 2012 Ninjafish Studios LLC. All rights reserved.
//

#import "DVHttpRequest.h"
#import "NSString-DVEncoding.h"
#import "NSString-DVExplode.h"
#import "DVDate.h"
#import "NSString-DVExplode.h"
#import "DVDataStore.h"


@interface DVHttpRequest(){
    NSOperationQueue *_queue;
	NSMutableURLRequest *_request;
}
@end

@implementation DVHttpRequest

- (id)init
{
    self = [super init];
    if (self) {
        _queue = [[NSOperationQueue alloc] init];
        [_queue setMaxConcurrentOperationCount:20];
        
        _request = [[NSMutableURLRequest alloc] init];
    }
    return self;
}

-(NSDictionary *)parseCacheControl:(NSString *)cacheControlString{
    NSMutableDictionary *cacheControl = [[NSMutableDictionary alloc] init];
    NSArray *fields = [NSString explode:@"," string:cacheControlString];
    NSString *field;
    for (field in fields) {
        NSArray *keyVal = [NSString explode:@"=" string:field];        
        if ([keyVal count] == 2) {
            [cacheControl setObject:[keyVal objectAtIndex:1] forKey:[keyVal objectAtIndex:0]];
        }else{
            [cacheControl setObject:[NSNumber numberWithBool:YES] forKey:field];            
        }
    }
    return cacheControl;
}

-(NSDate *)expirationDateFromHttpResponse:(NSHTTPURLResponse *)urlResponse{
    NSString *expirationDateString = [[urlResponse allHeaderFields] objectForKey:@"Expires"];
    NSDate *expirationDate = nil;
    if (expirationDateString) {
        expirationDate = [DVDate dateFromString:expirationDateString];
    }else{
        NSString *dateString = [[urlResponse allHeaderFields] objectForKey:@"Date"];
        NSString *cacheControlString = [[urlResponse allHeaderFields] objectForKey:@"Cache-Control"];
        
        NSDate *date = [DVDate dateFromString:dateString];
        if (date && cacheControlString) {
            NSDictionary *cacheControl = [self parseCacheControl:cacheControlString];
            if (cacheControl && [cacheControl objectForKey:@"max-age"]) {
                int maxAge = [[cacheControl objectForKey:@"max-age"] intValue];
                expirationDate = [date dateByAddingTimeInterval:maxAge];
            }
        }
    }
    
    
    return expirationDate;
}

-(NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)request{
    NSLog(@"cachedResponseForRequest.1.");
    NSCachedURLResponse *cachedURLResponse = [[NSURLCache sharedURLCache] cachedResponseForRequest:request];
    
    NSLog(@"cachedResponseForRequest.2.");
    
    if (cachedURLResponse) {
        
        NSDate *expirationDate = [self expirationDateFromHttpResponse:(NSHTTPURLResponse *)[cachedURLResponse response]];
        NSLog(@"cachedResponseForRequest.3.");
        
        if(expirationDate && ![DVDate isDatePast:expirationDate]){
            NSLog(@"cachedResponseForRequest.4a.");
            return cachedURLResponse;
        }else{
            NSLog(@"cachedResponseForRequest.4b.");
            [[NSURLCache sharedURLCache] removeCachedResponseForRequest:request];
        }
    }
    return nil;
}


-(NSString *)serializeParams:(NSDictionary *)params {
    /*
     
     Convert an NSDictionary to a query string
     
     */
    
    NSMutableArray* pairs = [NSMutableArray array];
    for (NSString* key in [params keyEnumerator]) {
        id value = [params objectForKey:key];
        if ([value isKindOfClass:[NSDictionary class]]) {
            for (NSString *subKey in value) {
                NSString* escaped_value = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                                                (CFStringRef)[@"" stringByAppendingFormat:@"%@", [value objectForKey:subKey]],
                                                                                              NULL,
                                                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                              kCFStringEncodingUTF8));
                [pairs addObject:[NSString stringWithFormat:@"%@%@%@%@=%@", key, @"%5B", subKey, @"%5D", escaped_value]];
            }
        } else if ([value isKindOfClass:[NSArray class]]) {
            for (NSString *subValue in value) {
                NSString* escaped_value = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                              (CFStringRef)subValue,
                                                                                              NULL,
                                                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                              kCFStringEncodingUTF8));
                [pairs addObject:[NSString stringWithFormat:@"%@%@%@=%@", key, @"%5B", @"%5D", escaped_value]];
            }
        } else {
            NSString* escaped_value = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                          (CFStringRef)[@"" stringByAppendingFormat:@"%@", [params objectForKey:key]],
                                                                                          NULL,
                                                                                          (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                                                          kCFStringEncodingUTF8));
            [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, escaped_value]];
        }
    }
    return [pairs componentsJoinedByString:@"&"];
}


-(BOOL)sendRequestWithUrl:(NSString *)url
               httpMethod:(NSString *)httpMethod
                   params:(NSMutableDictionary *)params
                    files:(NSMutableArray *)files
        completionHandler:(completionHandler)completionHandler{
    return [self sendRequestWithUrl:url httpMethod:httpMethod params:params files:files httpAuthenticationKey:nil completionHandler:completionHandler];
}

-(BOOL)sendRequestWithUrl:(NSString *)url
               httpMethod:(NSString *)httpMethod
                   params:(NSMutableDictionary *)params
                    files:(NSMutableArray *)files
    httpAuthenticationKey:(NSString *)httpAuthenticationKey
        completionHandler:(completionHandler)completionHandler{
    return [self sendRequestWithUrl:url httpMethod:httpMethod params:params files:files httpAuthenticationKey:httpAuthenticationKey headerFields:nil completionHandler:completionHandler];
}

-(BOOL)sendRequestWithUrl:(NSString *)url
               httpMethod:(NSString *)httpMethod
                   params:(NSMutableDictionary *)params
                    files:(NSMutableArray *)files
                      httpAuthenticationKey:(NSString *)httpAuthenticationKey
                   headerFields:(NSMutableDictionary *)headerFields
        completionHandler:(completionHandler)completionHandler{
    
    
    _request = [[NSMutableURLRequest alloc] init];
    
    if(!params){
        params = [[NSMutableDictionary alloc] init];
    }else{
        params = [[NSMutableDictionary alloc] initWithDictionary:params];
    }
    if(!files){
        files = [[NSMutableArray alloc] init];
    }else{
        files = [[NSMutableArray alloc] initWithArray:files];
    }
    
    if([httpMethod isEqualToString:@"POST"] || 
       [httpMethod isEqualToString:@"PUT"] || 
       [httpMethod isEqualToString:@"DELETE"]){
        
#ifdef ANDROID
        _request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
#else
        [_request setURL:[NSURL URLWithString:url]];
#endif
        
        [params setValue:[httpMethod lowercaseString] forKey:@"_method"];
        [_request addValue:httpMethod forHTTPHeaderField: @"X-HTTP-Method-Override"];
        [_request setHTTPMethod:httpMethod];
        
        
        NSString *boundary = @"-----------------------------1137522503144128232716531729";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        
        
        if([headerFields objectForKey:@"Content-Type"]){
            contentType = [headerFields objectForKey:@"Content-Type"];
        }

        if([contentType isEqualToString:@"application/json"]){
            [_request addValue:contentType forHTTPHeaderField: @"Content-Type"];
            
            
            NSData* jsonData = [NSJSONSerialization dataWithJSONObject:params options:kNilOptions error:nil];
            [_request setHTTPBody:jsonData];
            
            NSString *str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSLog(@"!jsonData as string: %@", str);
            
            [_request addValue:[@"" stringByAppendingFormat:@"%d", [jsonData length]]  forHTTPHeaderField: @"Content-Length"];
            [_request addValue:@"application/json" forHTTPHeaderField: @"Accept"];
            [_request addValue:@"application/json" forHTTPHeaderField: @"Content-Type"];
            
            
        }else{
            [_request addValue:contentType forHTTPHeaderField: @"Content-Type"];
            
            NSMutableData *body = [NSMutableData data];        
            for (NSString *key in params) {
                
                [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];					
                [body appendData:[[NSString stringWithString:[@""
                                                              stringByAppendingFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n%@\r\n", 
                                                              key,[@"" stringByAppendingFormat:@"%@", [params objectForKey:key]]]] 
                                  dataUsingEncoding:NSUTF8StringEncoding]];
            }
            
            for (int i=0; i < [files count]; i++) {
                NSDictionary *file = [files objectAtIndex:i];
                
                [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[[NSString stringWithString:[@"" 
                                                              stringByAppendingFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", [file objectForKey:@"name"], [file objectForKey:@"filename"]]] 
                                  dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" 
                                  dataUsingEncoding:NSUTF8StringEncoding]];
                [body appendData:[file objectForKey:@"data"]];
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            }
            
            // @todo Fix this stab in the dark hack.
            if ([files count] == 0) {
                [body appendData:[[NSString stringWithFormat:@"--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];				
            }else{
                [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];				
            }
            
            
            [_request setHTTPBody:body];
            [_request addValue:[@"" stringByAppendingFormat:@"%d", [body length]]  forHTTPHeaderField: @"Content-Length"];
            [_request addValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField: @"Accept"];
            
        }
        
    }else{  // USES 'GET' METHOD BY DEFAULT

        url = [url stringByAppendingString:@"?"];
        
        NSString *serializedParams = [self serializeParams:params];
        url = [url stringByAppendingFormat:@"%@", serializedParams];
    
        
        if([headerFields objectForKey:@"Content-Type"]){
            headerFields = [[NSMutableDictionary alloc] initWithDictionary:headerFields];            
            [headerFields removeObjectForKey:@"Content-Type"];
        }
        
//        for (NSString *key in params) {
//            url = [url stringByAppendingFormat:@"&%@=%@", key,
//                     [NSString urlEncode:[params objectForKey:key]]];
//        }
        
        
#ifdef ANDROID
        _request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
#else
        [_request setURL:[NSURL URLWithString:url]];
#endif
        
        [_request setHTTPMethod:@"GET"];

        [_request setCachePolicy:NSURLRequestUseProtocolCachePolicy];

        
        NSCachedURLResponse *cachedURLResponse;
#ifndef ANDROID
        if ((cachedURLResponse = [self cachedResponseForRequest:_request])) {
            completionHandler([cachedURLResponse response], [cachedURLResponse data], nil);
            return YES;
        }
#endif
        
    }
    
    
    NSString *userAgent = [@"" stringByAppendingFormat:@"%@ %@ (%@; %@ %@; %@)", 
						   [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"],
						   [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"],
						   [[UIDevice currentDevice] model],
						   [[UIDevice currentDevice] systemName],
						   [[UIDevice currentDevice] systemVersion],
						   [[NSLocale currentLocale] localeIdentifier]];	
	[_request addValue:userAgent forHTTPHeaderField:@"User-Agent"];
    
    if(httpAuthenticationKey){
        NSString *authValue = [NSString stringWithFormat:@"Basic %@", httpAuthenticationKey];
        [_request addValue:authValue forHTTPHeaderField:@"Authorization"];
    }
    if(headerFields && ([headerFields isKindOfClass:[NSMutableDictionary class]] || [headerFields isKindOfClass:[NSDictionary class]])){
        for(NSString *key in headerFields){
            NSString *value = [headerFields valueForKey:key];
            [_request addValue:value forHTTPHeaderField:key];
        }
    }

    [NSURLConnection sendAsynchronousRequest:_request queue:_queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
        
        completionHandler(response, data, error);
    }];
    
    return YES;
}


@end
