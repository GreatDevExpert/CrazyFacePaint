//
//  NSString-validation.m
//  Slots Party
//
//  Created by William Locke on 2/28/12.
//  Copyright 2012 William Locke. All rights reserved.
//

#import "NSString-DVExplode.h"


@implementation NSString (DVExplode)

// PHP function equivalents

// - explode ( string $delimiter , string $string [, int $limit ] )
+(NSArray *)explode:(NSString *)delimiter string:(NSString *)string
{
    NSArray *_splitItems = [string componentsSeparatedByString:delimiter];
    NSMutableArray *_mutableSplitItems = [NSMutableArray arrayWithCapacity:[_splitItems count]]; 
    [_mutableSplitItems addObjectsFromArray:_splitItems];
    return (NSArray *)_mutableSplitItems;
}


@end
