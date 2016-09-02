//
//  NSString-validation.h
//  Slots Party
//
//  Created by William Locke on 2/28/12.
//  Copyright 2012 William Locke. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (DVExplode)

+(NSArray *)explode:(NSString *)delimiter string:(NSString *)string;

@end