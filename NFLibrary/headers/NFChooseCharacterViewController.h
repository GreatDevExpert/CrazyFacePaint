//
//  ChooseCharacterViewController.h
//  HighSchoolMakeover
//
//  Created by William Locke on 9/23/13.
//  Copyright (c) 2013 Ninjafish Studios. All rights reserved.
//

#import "NFViewController.h"
#import "NFPopupViewController.h"

@protocol NFChooseCharacterSession <NSObject>

-(NSNumber *)characterIndex;
-(void)setCharacterIndex:(NSNumber *)characterIndex;

@end

@interface NFChooseCharacterViewController : NFViewController

@property int lockedIndex;
@property (nonatomic, strong, setter = productId:) NSString *productId;
@property (setter = setDownloadedIndex:, getter = downloadedIndex) int downloadedIndex;
@property BOOL downloadingIndex;
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *characterButtons;
@property (nonatomic, strong) IBOutletCollection(UIImageView) NSArray *lockImageViews;
@property (nonatomic, strong) NFPopupViewController *popupViewController;
@property (nonatomic, strong) id<NFChooseCharacterSession> sharedSession;  // Static object that holds a bunch of shared data that persists across all game view controllers
@property (nonatomic, strong) NFProduct *unlockCharactersProduct;
@property BOOL showLoadingScreenWhenPresentingNextViewController;

-(void)layout;
-(void)layoutCharacters;
-(void)didUnlockAllCharacters;

#pragma mark IBActions / Events
-(IBAction)characterButtonPressed:(id)sender;

#pragma mark Purchases
-(void)showPopupViewController;

#pragma mark iPhone5
-(void)adjustLayoutForIPhone5;
@end
