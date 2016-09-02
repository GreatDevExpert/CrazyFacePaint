//
//  NFWebApiResponseDataError.h
//  
//
//  Created by ___FULLUSERNAME___ on 6/3/13.
//  Copyright (c) 2013. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NFWebApiResponseDataError : NSObject <NSCoding> {
    NSNumber *code;
    NSMutableArray *errors;
    NSString *message;
}

@property (nonatomic, copy) NSNumber *code;
@property (nonatomic, copy) NSMutableArray *errors;
@property (nonatomic, copy) NSString *message;

+ (NFWebApiResponseDataError *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
