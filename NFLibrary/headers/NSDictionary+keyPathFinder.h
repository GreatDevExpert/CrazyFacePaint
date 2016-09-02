//
//  NSDictionary+keyPathFinder.h
//  Pods
//
//  Created by William Locke on 7/2/14.
//
//

#import <UIKit/UIKit.h>

@interface NSDictionary (keyPathFinder)

-(NSString *)findKeyPathForKey:(NSString *)key;
-(NSArray *)alphabeticallySortedKeysForKeyPath:(NSString *)keyPath;

-(NSString *)firstExistingKeyPathInKeyPaths:(NSArray *)keyPaths;

-(NSArray *)findKeyPathsForKey:(NSString *)key;


@end
