//
//  NFData.h
//  NinjafishStudiosApp
//
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSData-applicationData.h"
#import "NSKeyedArchiver-archiveObjectForKey.h"
#import "NSKeyedUnarchiver-objectForKey.h"
#import "NFJsonPath.h"
#import "NFSettings.h"   // TODO: remove this class
#import "SBJsonParser.h"

/**
 * Handles things related to persistent storage, object serialization (JSON).
 *
 * Dependencies:
 *  - JSONKit
 */
@interface NFData : NSObject

+(BOOL)archiveObject:(id)object forKey:(NSString *)key;
+(id)objectForKey:(NSString *)key;
+(id)objectFromFile:(NSString *)resource;
+(id)jsonObjectFromData:(NSData *)data;

+(NSMutableArray *)itemsForKeyPaths:(NSMutableArray *)keyPaths dictionary:(NSMutableDictionary *)dictionary;

// TODO: find a better place for this function. 
+(NSMutableArray *)flattenArray:(id)object;

@end
