//
//  ChooseActivityViewController.h
//
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NFViewController.h"
#import "NFPopupViewController.h"

//! Subclasses ViewController - for faster setup of common UI elements
//  such as loading indicators, background image view, controls layer.
@interface NFChooseActivityViewController : NFViewController

@property (nonatomic, strong) IBOutletCollection(NFAnimatedImageView) NSArray *animatedImageViews;
@property (nonatomic, strong) IBOutletCollection(UIButton) NSArray *activityButtons;
@property (nonatomic, strong) IBOutlet UIImageView *textImageView;
@property (nonatomic, strong) NSMutableArray *greyButtons;

@property (nonatomic, strong) IBOutlet UIButton *storeButton;
@property (nonatomic, strong) NFPopupViewController *popupViewController;


#pragma mark Layout Functions
-(void)layout;
-(void)layoutAnimatedImageViews;
-(void)layoutActivityButtons;


-(NSArray *)activityIdentifiers;
-(NSString *)identifierForActivityButtonOrAnimatedImageView:(id)activityObject;

#pragma mark IBActions / Events
-(IBAction)activityButtonPressed:(id)sender;
-(IBAction)backButtonPressed:(id)sender;
-(IBAction)storeButtonPressed:(id)sender;

#pragma mark iPhone5
-(void)adjustLayoutForIPhone5;


@end

