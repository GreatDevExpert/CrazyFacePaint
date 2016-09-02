//
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NFWebApiResponse.h"
#import "NFWebApiResponseData.h"
@class NFHttpRequest;


@interface NFWebApiClient : NSObject


@property (strong, nonatomic) NSString *baseUrl;
@property (strong, nonatomic) NSObject *delegate;
@property (strong, nonatomic) NSOperationQueue *queue;
@property (strong, nonatomic) NFHttpRequest *httpRequest;
@property (strong, nonatomic) NSString *httpAuthenticationKey;
@property (strong, nonatomic) NSMutableDictionary *headerFields;
@property (strong, nonatomic) NSString *serializationFormat;
@property Class webApiResponseClass;


+(id)sharedInstance;

typedef void (^ NFWebApiResponseHandler)(id<NFWebApiResponse> webApiResponse);
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
