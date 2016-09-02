//
//  CountTheFlowersViewController.h
//  PrincessFashionResort
//
//  Created by William Locke on 6/15/14.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

// TODO: Add steps to subclass. 

#import "NFGameViewController.h"

typedef enum  {
    NFCountTheItemsItemViewCountTypeCumulative,
    NFCountTheItemsItemViewCountTypeNumberedImages,
    }NFCountTheItemsCountType;

@interface NFCountTheItemsViewController : NFGameViewController

@property (nonatomic, strong) NFCharacterView *itemView;
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *numberButtons;
@property (nonatomic, strong) NSMutableArray *imageViewIdentifiersOfItemsToCount;
@property int numberOfHiddenItems;
@property int numberOfVisibleItems;
@property NFCountTheItemsCountType countType;


-(void)layout;
-(void)layoutItem;
-(void)resetGame;
-(void)refreshItemsCount;

#pragma mark IBActions
-(IBAction)numberButtonPressed:(id)sender;

-(void)didSelectIncorrectNumber;
-(void)didCompleteChallenge;

@end
