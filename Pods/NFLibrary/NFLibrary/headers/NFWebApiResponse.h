//
//  NFWebApiResponse.h
//  Pods
//
//  Created by William Locke on 3/21/13.
//
//

#import <UIKit/UIKit.h>
#import "NFWebApiResponseData.h"

@protocol NFWebApiResponse <NSObject>

@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) NSDictionary *errorDictionary;
@property (nonatomic, strong) id<NFWebApiResponseData> data;

-(id)initWithUrlResponse:(NSURLResponse *)response
                     data:(NSData *)data
                    error:(NSError *)error;


@end


@interface NFWebApiResponse : NSObject<NFWebApiResponse>

@property (nonatomic, strong) NSError *error;
@property (nonatomic, strong) NSDictionary *errorDictionary;
@property (nonatomic, strong) id<NFWebApiResponseData> data;
@property Class webApiResponseDataClass;

-(id)initWithUrlResponse:(NSURLResponse *)response
                    data:(NSData *)data
                   error:(NSError *)error;

@end
