//
//  NFSharedDressUpViewController.h
//  KidschristmasMania
//
//  Created by William Locke on 4/9/14.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import "NFGameViewController.h"
#import "NFButton.h"
@interface NFSharedDressUpViewController : NFGameViewController


@property (nonatomic, strong) IBOutlet NFScrollViewSelector *thumbsScrollViewSelector;
@property (nonatomic, strong) IBOutlet NFScrollViewSelector *mainScrollViewSelector;
@property (nonatomic, strong) NSMutableDictionary *clothingIndexesDictionary;
@property (nonatomic, strong) id retainedBlock;
@property (nonatomic, strong) NSArray *incompatiblePairs;   //#DOCUMENT
@property (nonatomic, strong) NFButton *centerButton;
@property (nonatomic, strong) IBOutlet NFImageView *backgroundImageView;

@property (nonatomic, copy) NSString *currentTheme;

-(void)layout;
-(void)layoutBottomScrollViewSelector;
-(NSString *)bottomBarButtonsIdentifier;
-(NSString *)bottomBarButtonsKeyPathForIdentifier:(NSString *)identifier;
-(NFScrollViewSelector *)bottomScrollViewSelectorWithIdentifier:(NSString *)identifier bottomBarButtonsKeyPath:(NSString *)keyPath;
-(void)layoutSideScrollViewSelector;



#pragma mark Show / Hide
-(void)showScrollViewSelector;
-(void)hideScrollViewSelector;

-(void)updateIncompatiblePairs;
-(void)updateIncompatiblePairsForSelectedImageViewIdentifier:(NSString *)imageViewIdentifier;


#pragma mark Purchases
-(void)didCompletePurchase:(NFProduct *)productPurchased;

@end
