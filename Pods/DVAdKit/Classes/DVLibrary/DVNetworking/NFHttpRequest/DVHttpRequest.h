//
//  HttpRequest.h
//  Slots Party
//
//  Created by William Locke on 4/6/12.
//  Copyright (c) 2012 Ninjafish Studios LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVHttpRequest : NSObject

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

