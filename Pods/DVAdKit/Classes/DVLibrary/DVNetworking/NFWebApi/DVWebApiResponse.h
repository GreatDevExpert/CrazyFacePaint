//
//  NFWebApiResponse.h
//  Pods
//
//  Created by William Locke on 3/21/13.
//
//

#import <Foundation/Foundation.h>
#import "DVWebApiResponseData.h"

@protocol DVWebApiResponse <NSObject>

@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) NSDictionary *errorDictionary;
@property (nonatomic, strong) id<DVWebApiResponseData> data;

// Possibly remove
@property (nonatomic, strong) NSURLResponse *response;

-(id)initWithUrlResponse:(NSURLResponse *)response
                     data:(NSData *)data
                    error:(NSError *)error;


@end


@interface DVWebApiResponse : NSObject<DVWebApiResponse>

@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) NSDictionary *errorDictionary;
@property (nonatomic, strong) id<DVWebApiResponseData> data;

// Possibly remove
@property (nonatomic, strong) NSURLResponse *response;

@property Class webApiResponseDataClass;

-(id)initWithUrlResponse:(NSURLResponse *)response
                    data:(NSData *)data
                   error:(NSError *)error;

@end
