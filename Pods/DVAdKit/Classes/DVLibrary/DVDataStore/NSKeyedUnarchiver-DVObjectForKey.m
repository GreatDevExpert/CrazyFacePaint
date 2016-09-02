//
//  NSKeyedArchiver-objectForKey.m
//  Yog
//
//  Created by William Locke on 2/28/12.
//  Copyright 2012 William Locke. All rights reserved.
//

#import "NSKeyedUnarchiver-DVObjectForKey.h"


@implementation NSKeyedUnarchiver (DVObjectForKey)

+(id)objectForKey:(NSString *)key{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex: 0];
	NSString *docFile = [docDir stringByAppendingPathComponent:key];
	NSString *dataCacheFile = docFile;
	
	return [NSKeyedUnarchiver unarchiveObjectWithFile:dataCacheFile];
}



@end
