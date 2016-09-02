//
//  NSKeyedArchiver-archiveObjectForKey.h
//
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NSKeyedArchiver (archiveObjectForKey)

+(BOOL)archiveObject:(id)object forKey:(NSString *)key;


@end
