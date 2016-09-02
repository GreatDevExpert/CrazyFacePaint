//
//  Reachability.h
//  Reachability
//

#import <UIKit/UIKit.h>

@interface ReachableNetwork : NSObject

+(BOOL)reachable;
+(BOOL)isReachable:(BOOL)reachable set:(BOOL)set;

@end
