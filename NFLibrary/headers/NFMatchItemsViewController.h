//
//  MatchItemsViewController.h
//  PreschoolGames
//
//  Created by William Locke on 6/11/13.
//  Copyright (c) 2013 Ninjafish Studios. All rights reserved.
//

#import "NFGameViewController.h"
#import "NFMatchItemView.h"
#import "NFTimerView.h"


// TODO: shuffle items even if shuffle effect is off
@interface NFMatchItemsViewController : NFGameViewController

@property (nonatomic, strong) IBOutlet UIImageView *textImageView;
@property (nonatomic, strong) IBOutletCollection(NFMatchItemView) NSMutableArray *matchItems1;
@property (nonatomic, strong) IBOutletCollection(NFMatchItemView) NSMutableArray *matchItems2;
@property (nonatomic, strong) NSArray *row1Items;
@property (nonatomic, strong) NSArray *row2Items;
@property int numberOfItemsMatched;
@property int indexOfSelectedMatchItem;
@property BOOL flipMatch;
@property (nonatomic, strong) NSString *upsideDownImageName;
@property (nonatomic, strong) NFMatchItemView *selectedMatchItemView;

// Option to have timer
@property (nonatomic, strong) IBOutlet NFTimerView *timerView;
@property BOOL shuffleOnStart;


-(void)layout;
-(void)layoutItems;

-(IBAction)matchItemViewPressed:(id)sender;
-(void)didMatchWrongItems;
-(void)didCompleteLevel;

-(void)didMatchCorrectItems:(NSArray *)itemsCorrectlyMatched;

#pragma mark Animation
-(void)animateViews:(NSArray *)views toScreenCenter:(void (^ )(BOOL finished))completionHandler;

-(void)spinViewsOffScreen:(NSArray *)views completionHandler:(void (^ )(BOOL finished))completionHandler;

-(void)didMatchItem:(NFMatchItemView *)matchItemView1 withItem:(NFMatchItemView *)matchItemView2;
-(void)didMatchItems;


@end
