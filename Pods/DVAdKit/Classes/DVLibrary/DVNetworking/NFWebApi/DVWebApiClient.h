//
//  DressUpFashionWebApi.h
//  DressUpFashion
//
//  Created by William Locke on 4/9/12.
//  Copyright (c) 2012 Ninjafish Studios LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DVWebApiResponse.h"
#import "DVWebApiResponseData.h"
@class DVHttpRequest;


@interface DVWebApiClient : NSObject


@property (strong, nonatomic) NSString *baseUrl;
@property (strong, nonatomic) NSObject *delegate;
@property (strong, nonatomic) NSOperationQueue *queue;
@property (strong, nonatomic) DVHttpRequest *httpRequest;
@property (strong, nonatomic) NSString *httpAuthenticationKey;
@property (strong, nonatomic) NSMutableDictionary *headerFields;
@property (strong, nonatomic) NSString *serializationFormat;
@property Class webApiResponseClass;

@property (strong, nonatomic) NSMutableArray *httpRequests;


+(id)sharedInstance;

typedef void (^ NFWebApiResponseHandler)(id<DVWebApiResponse> webApiResponse);
-(void)webApiCall:(NSString *)url
           params:(NSDictionary *)params
       httpMethod:(NSString *)httpMethod
          options:(NSDictionary *)options NFWebApiResponseHandler:(NFWebApiResponseHandler)NFWebApiResponseHandler;

-(void)webApiCall:(NSString *)url
           params:(NSDictionary *)params
            files:(NSMutableArray *)files
       httpMethod:(NSString *)httpMethod
          options:(NSDictionary *)options NFWebApiResponseHandler:(NFWebApiResponseHandler)NFWebApiResponseHandler;



- (id)initWithBaseUrl:(NSString *)baseUrl;


@end
