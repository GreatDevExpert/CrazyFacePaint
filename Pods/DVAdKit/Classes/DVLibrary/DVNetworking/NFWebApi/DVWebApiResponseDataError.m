//
//  NFWebApiResponseDataError.m
//  
//
//  Created by ___FULLUSERNAME___ on 6/3/13.
//  Copyright (c) 2013. All rights reserved.
//

#import "DVWebApiResponseDataError.h"

@implementation DVWebApiResponseDataError

@synthesize code;
@synthesize errors;
@synthesize message;

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.code forKey:@"code"];
    [encoder encodeObject:self.errors forKey:@"errors"];
    [encoder encodeObject:self.message forKey:@"message"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super init])) {
        self.code = [decoder decodeObjectForKey:@"code"];
        self.errors = [decoder decodeObjectForKey:@"errors"];
        self.message = [decoder decodeObjectForKey:@"message"];
    }
    return self;
}

+ (DVWebApiResponseDataError *)instanceFromDictionary:(NSDictionary *)aDictionary
{

    DVWebApiResponseDataError *instance = [[DVWebApiResponseDataError alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary
{

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    [self setValuesForKeysWithDictionary:aDictionary];

}

- (void)setValue:(id)value forKey:(NSString *)key
{

    if ([key isEqualToString:@"errors"]) {

        if ([value isKindOfClass:[NSArray class]])
{

            NSMutableArray *myMembers = [NSMutableArray arrayWithCapacity:[value count]];
            for (id valueMember in value) {
                [myMembers addObject:valueMember];
            }

            self.errors = myMembers;

        }

    } else {
        [super setValue:value forKey:key];
    }

}


- (NSDictionary *)dictionaryRepresentation
{

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    if (self.code) {
        [dictionary setObject:self.code forKey:@"code"];
    }

    if (self.errors) {
        [dictionary setObject:self.errors forKey:@"errors"];
    }

    if (self.message) {
        [dictionary setObject:self.message forKey:@"message"];
    }

    return dictionary;

}

@end
