//
//  TapToEatViewController.h
//  LollipopMaker
//
//  Created by William Locke on 2/13/13.
//  Copyright (c) 2013 Ninjafish Studios. All rights reserved.
//

#import "NFGameViewController.h"

@protocol NFTapToEatControllerSession <NFGameSession>

-(NSMutableDictionary *)indexesOfChooseItems;
-(UIImage *)tapToEatBackgroundImage;
-(UIImage *)tapToEatConsumableImage;
-(UIImage *)tapToEatNonConsumableImage;

@end

@interface NFTapToEatViewController : NFGameViewController


@property (nonatomic, strong) id<NFTapToEatControllerSession> sharedSession;
@property (nonatomic, strong) NFTapToEatView *tapToEatView;
@property (nonatomic, strong) UIView *candlesView;

@property (nonatomic, strong) IBOutlet UIImageView *cupImageView;
@property (nonatomic, strong) UIImage *cupFillImage;

-(void)layout;
-(IBAction)saveButtonPressed:(id)sender;
-(IBAction)sellButtonPressed:(id)sender;

@end