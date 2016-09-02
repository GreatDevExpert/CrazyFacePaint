//
//  NFPaginatedSelectorViewController.h
//  Pods
//
//  Created by Jeff Patternstein on 9/12/14.
//
//

#import "NFGameViewController.h"
@protocol NFPaginatedSelectorSession <NSObject>

-(NSMutableDictionary *)indexesOfChooseItems;

@end

@interface NFPaginatedSelectorViewController : NFGameViewController

@property (nonatomic, strong) id<NFPaginatedSelectorSession> sharedSession;  // Static object that holds a bunch of shared data that persists across all game view controllers

@property (nonatomic, strong) IBOutlet NFPaginatedScrollViewSelector *paginatedScrollViewController;

-(void)layout;

-(NSArray *)imageNamesForPaginatedSelectorView;

@end
