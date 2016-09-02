//
//  NFWebApiResponseDataError.h
//  
//
//  Created by ___FULLUSERNAME___ on 6/3/13.
//  Copyright (c) 2013. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DVWebApiResponseDataError : NSObject <NSCoding> {
    NSNumber *code;
    NSMutableArray *errors;
    NSString *message;
}

@property (nonatomic, copy) NSNumber *code;
@property (nonatomic, copy) NSMutableArray *errors;
@property (nonatomic, copy) NSString *message;

+ (DVWebApiResponseDataError *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
