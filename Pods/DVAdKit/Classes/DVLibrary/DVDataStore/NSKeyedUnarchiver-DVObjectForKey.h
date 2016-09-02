//
//  NSKeyedArchiver-objectForKey.h
//  Yog
//
//  Created by William Locke on 2/28/12.
//  Copyright 2012 William Locke. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSKeyedUnarchiver (DVObjectForKey)

/// Returns the dictionary or array represented in the receiver, or nil on error.
+(id)objectForKey:(NSString *)key;

@end
