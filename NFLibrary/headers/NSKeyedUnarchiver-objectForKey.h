//
//  NSKeyedArchiver-objectForKey.h
//
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NSKeyedUnarchiver (objectForKey)

/// Returns the dictionary or array represented in the receiver, or nil on error.
+(id)objectForKey:(NSString *)key;

@end
