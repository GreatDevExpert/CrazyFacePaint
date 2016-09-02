//
//  DressUpFashionWebApi.m
//  DressUpFashion
//
//  Created by William Locke on 4/9/12.
//  Copyright (c) 2012 Ninjafish Studios LLC. All rights reserved.
//

#import "DVWebApiClient.h"
#import "DVHttpRequest.h"


static DVWebApiClient *_sharedWebApi;


@implementation DVWebApiClient

@synthesize baseUrl = _baseUrl;
@synthesize httpRequest = _httpRequest;
@synthesize queue = _queue;
@synthesize httpAuthenticationKey = _httpAuthenticationKey;
@synthesize serializationFormat = _serializationFormat;



+ (id)sharedInstance
{
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    
    // returns the same object each time
    return _sharedObject;
}


- (id)init
{
    self = [self initWithBaseUrl:@""];
    if (self) {
        
    }
    return self;
}

- (id)initWithBaseUrl:(NSString *)baseUrl
{
    self = [super init];
    if (self) {
        _webApiResponseClass = [DVWebApiResponse class];
        
        _baseUrl = baseUrl;
        _queue = [[NSOperationQueue alloc] init];
        [_queue setMaxConcurrentOperationCount:10];
        _httpRequest = [[DVHttpRequest alloc] init];
        if(!_serializationFormat){
            _serializationFormat = @"";
        }
    }
    return self;
}


#pragma mark Api Functions
-(void)webApiCall:(NSString *)url
           params:(NSMutableDictionary *)params
       httpMethod:(NSString *)httpMethod
          options:(NSMutableDictionary *)options NFWebApiResponseHandler:(NFWebApiResponseHandler)NFWebApiResponseHandler{
    
    
    [self webApiCall:url params:params files:nil httpMethod:httpMethod options:options NFWebApiResponseHandler:^(id<DVWebApiResponse> webApiResponse){
        NFWebApiResponseHandler(webApiResponse);
    }];
}
-(void)webApiCall:(NSString *)url
           params:(NSMutableDictionary *)params
            files:(NSMutableArray *)files    
       httpMethod:(NSString *)httpMethod
          options:(NSMutableDictionary *)options NFWebApiResponseHandler:(NFWebApiResponseHandler)NFWebApiResponseHandler
{
    if(_baseUrl){
        url = [_baseUrl stringByAppendingFormat:@"%@%@", url, self.serializationFormat];
    }
    
    NSLog(@"%@ url: %@", httpMethod ? httpMethod : @"GET", url);
    NSLog(@"%@ params: %@", httpMethod ? httpMethod : @"GET", params);
    DVHttpRequest *httpRequest = [[DVHttpRequest alloc] init];
    if (!_httpRequests) {
        _httpRequests = [[NSMutableArray alloc] init];
    }
    [_httpRequests addObject:httpRequest];
    
    
    [httpRequest sendRequestWithUrl:url
                         httpMethod:httpMethod
                             params:params
                              files:files
              httpAuthenticationKey:_httpAuthenticationKey
              headerFields:_headerFields
                  completionHandler:^(NSURLResponse *response, NSData *data, NSError *error){
                      
                      NSLog(@"%@ %@ Response Data: %@", httpMethod ? httpMethod : @"GET", url, [[NSString alloc] initWithData:data encoding:NSStringEncodingConversionAllowLossy]);
                      
                      id<DVWebApiResponse> webApiResponse = [[self.webApiResponseClass alloc] initWithUrlResponse:response data:data error:error];
                      
                      NSLog(@"webApiResponse: %@", [[webApiResponse data] items]);
                      NFWebApiResponseHandler(webApiResponse);
                      
                      [_httpRequests removeObject:httpRequest];
                  }];
}







@end
