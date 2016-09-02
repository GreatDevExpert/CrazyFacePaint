//
//  NFData.h
//  NinjafishStudiosApp
//
//  Created by William Locke on 9/17/12.
//  Copyright (c) 2012 William Locke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSKeyedArchiver-DVArchiveObjectForKey.h"
#import "NSKeyedUnarchiver-DVObjectForKey.h"
//#import "JSONKit.h"
#import "SBJsonParser.h"

/**
 * Handles things related to persistent storage, object serialization (JSON).
 *
 * Dependencies:
 *  - JSONKit
 */
@interface DVDataStore : NSObject

+(BOOL)archiveObject:(id)object forKey:(NSString *)key;
+(id)objectForKey:(NSString *)key;
+(id)objectFromFile:(NSString *)resource;
+(id)jsonObjectFromData:(NSData *)data;



@end
