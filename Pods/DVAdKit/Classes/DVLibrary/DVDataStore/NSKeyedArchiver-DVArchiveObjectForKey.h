//
//  NSKeyedArchiver-archiveObjectForKey.h
//  Yog
//
//  Created by William Locke on 2/28/12.
//  Copyright 2012 William Locke. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSKeyedArchiver (DVArchiveObjectForKey)

+(BOOL)archiveObject:(id)object forKey:(NSString *)key;


@end
