//
//  NFViewController+tappableHandlers.h
//  PrincessFashionResort
//
//  Created by William Locke on 6/19/14.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import "NFGameViewController.h"

@interface NFGameViewController (tappableHandlers)

-(void)makeTappableImageViewTappable:(UIImageView *)tappableImageView tappableButtons:(NSMutableArray *)tappableButtons targetSelectorForTappableButtonPressed:(SEL)targetSelectorForTappableButtonPressed;

-(NSMutableArray *)layoutTappableViewsForTappableImageViews:(NSArray *)tappableImageViews tappableButtons:(NSMutableArray *)tappableButtons targetSelectorForTappableButtonPressed:(SEL)targetSelectorForTappableButtonPressed;

-(NFAnimatedImageView *)tappableImageViewForTappableButton:(id)sender inTappableButtons:(NSArray *)tappableButtons withTappableImageViews:(NSArray *)tappableImageViews;


// TODO: move these to another category
-(void)assignIdentifiersToOutletCollection:(NSArray *)collection usingImageDictionaryKeysAtKeyPath:(NSString *)keyPath;
-(id)objectInOutletCollection:(NSArray *)collection withIdentifier:(NSString *)identifier;

@end
