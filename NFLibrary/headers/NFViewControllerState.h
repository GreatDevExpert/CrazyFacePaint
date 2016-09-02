//
//  NFViewControllerState.h
//  Pods
//
//  Created by Jeff Patternstein on 8/25/14.
//
//

#import <UIKit/UIKit.h>

@interface NFViewControllerState : NSObject

@property NFViewControllerState *nextState;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) NSArray *visibleViews;
@property (nonatomic, strong) NSArray *viewsToBeRemovedWhenDone;
@property (nonatomic, strong) NSArray *viewsWithUserInteractionDisabled;
@property int type;


+(NFViewControllerState *)addStateToArray:(NSMutableArray *)states withIdentifier:(NSString *)identifier text:(NSString *)text visibleViews:(NSArray *)visibleViews viewsToBeRemovedWhenDone:(NSArray *)viewsToBeRemovedWhenDone;
+(NFViewControllerState *)addStateToArray:(NSMutableArray *)states withIdentifier:(NSString *)identifier text:(NSString *)text visibleViews:(NSArray *)visibleViews viewsToBeRemovedWhenDone:(NSArray *)viewsToBeRemovedWhenDone viewsWithUserInteractionDisabled:(NSArray *)viewsWithUserInteractionDisabled;

@end
