//
//  NSSring-extras.m
//  Slots Party
//
//  Created by William Locke on 2/28/12.
//  Copyright 2012 William Locke. All rights reserved.
//

#import "NSString-DVExtras.h"


@implementation NSString (extras)

-(BOOL)contains:(NSString *)needle
{
	return [self rangeOfString:needle].location != NSNotFound;
}

@end
