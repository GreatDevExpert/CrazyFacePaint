//
//  ViewController+frozen.h
//  BabyMommyStory
//
//  Created by William Locke on 6/6/14.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NFViewController.h"
#import "NFCharacterView.h"

@interface NFViewController (scratchableViewHandlers)

-(NFScratchToRevealView *)scratchToRevealViewForImageName:(NSString *)imageName cropPercentageFrame:(CGRect)percentageFrame addToView:(UIView *)addToView;

-(NFScratchToRevealView *)makeCharacterView:(NFCharacterView *)characterView withImageViewIdentifier:(NSString *)imageViewIdentifier scratchableWithMode:(NFScratchToRevealViewMode)scratchableMode;

-(NFScratchToRevealView *)flattenAndMakeImageViewScratchable:(NFImageView *)imageView scratchableWithMode:(NFScratchToRevealViewMode)scratchableMode;

@end
