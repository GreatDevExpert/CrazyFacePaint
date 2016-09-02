//
//  NSKeyedArchiver-archiveObjectForKey.m
//  Yog
//
//  Created by William Locke on 2/28/12.
//  Copyright 2012 William Locke. All rights reserved.
//

#import "NSKeyedArchiver-DVArchiveObjectForKey.h"


@implementation NSKeyedArchiver (DVArchiveObjectForKey)

+(BOOL)archiveObject:(id)object forKey:(NSString *)key{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex: 0];
	NSString *docFile = [docDir stringByAppendingPathComponent:key];
	NSString *dataCacheFile = docFile;
	BOOL written = [NSKeyedArchiver archiveRootObject:object toFile:dataCacheFile];
	return written;
}

@end
