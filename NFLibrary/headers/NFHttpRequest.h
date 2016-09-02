//
//  HttpRequest.h
//  Slots Party
//
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NFHttpRequest : NSObject

typedef void (^ completionHandler)(NSURLResponse *response, NSData *data, NSError *error);
-(BOOL)sendRequestWithUrl:(NSString *)url
               httpMethod:(NSString *)httpMethod
                   params:(NSMutableDictionary *)params
                    files:(NSMutableArray *)files
        completionHandler:(completionHandler)completionHandler;

-(BOOL)sendRequestWithUrl:(NSString *)url
               httpMethod:(NSString *)httpMethod
                   params:(NSMutableDictionary *)params
                    files:(NSMutableArray *)files
    httpAuthenticationKey:(NSString *)httpAuthenticationKey
        completionHandler:(completionHandler)completionHandler;

-(BOOL)sendRequestWithUrl:(NSString *)url
               httpMethod:(NSString *)httpMethod
                   params:(NSMutableDictionary *)params
                    files:(NSMutableArray *)files
    httpAuthenticationKey:(NSString *)httpAuthenticationKey
             headerFields:(NSMutableDictionary *)headerFields
        completionHandler:(completionHandler)completionHandler;

-(NSCachedURLResponse *)cachedResponseForRequest:(NSURLRequest *)__request;

@end

