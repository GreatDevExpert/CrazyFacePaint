//
//  CharacterView.h
//  MonsterDentist
//
//  Created by William Locke on 6/12/13.
//  Copyright (c) 2013 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NFAnimatedImageView.h"
#import "NFImageViewObject.h"
@class NFCharacterView;

typedef struct {
    int normal;
    int open;
    int frown;
    int smile;
    int showingTeeth;
    int s;
    int shocked;
}NFCharacterViewMouth;

CG_INLINE NFCharacterViewMouth
NFCharacterViewMouthMake(int normal, int open, int frown, int smile, int showingTeeth)
{
    NFCharacterViewMouth c; c.normal = normal; c.open = open; c.frown = frown; c.smile = smile; c.showingTeeth = showingTeeth; return c;
}

@protocol NFCharacterViewDelegate <NSObject>

@optional
-(void)characterViewFadeOutCompleteForImageViewWithIdentifier:(NSString *)identifier;

@optional
-(void)characterViewFadeInCompleteForImageViewWithIdentifier:(NSString *)identifier;

@optional
-(void)characterViewDidFallAsleep:(NFCharacterView *)characterView;

@end


@interface NFCharacterView : UIView

@property (nonatomic, unsafe_unretained) id<NFCharacterViewDelegate> delegate;

// TODO: remove
@property (nonatomic, strong) UIImageView *bodyImageView;
@property (nonatomic, strong) NFAnimatedImageView *eyesAnimatedImageView;

@property (nonatomic, strong) NSMutableDictionary *info;
@property (nonatomic, strong) NSArray *imageViewObjects;
@property (nonatomic, strong) NSMutableArray *imageViews;
@property CGFloat fadeOutDuration;
@property NFCharacterViewMouth characterViewMouth;
@property BOOL isAsleep;

// TODO: decide whether these properties are worth having here or
// better somewhere else
@property (nonatomic, copy) NSString *characterImagesBaseFolderKeyPath;
@property (nonatomic, copy) NSString *clothingImagesBaseFolderKeyPath;
@property (nonatomic, strong) NSMutableDictionary *clothingIndexesDictionary;
@property (nonatomic, strong) NSNumber *characterIndex;

-(void)layout;
-(void)layoutImageViews;

-(NFImageView *)imageViewWithIdentifier:(NSString *)identifier;
-(NSArray *)imageViewsWithIdentifierPrefix:(NSString *)identifier;
-(void)updateCharacterImageViewOrder:(NSArray *)characterImageViewOrderings;

#pragma mark Animations
#pragma mark --Eyes
-(void)closeEyes;
-(void)startBlinking;
-(void)stopBlinking;

-(BOOL)isFadeInProgressForImageViewWithIdentifier:(NSString *)identifier;

-(void)startFadingOutImageViewWithIdentifier:(NSString *)identifier;
-(void)stopFadingOutImageViewWithIdentifier:(NSString *)identifier;


-(void)startFadingInImageViewWithIdentifier:(NSString *)identifier;
-(void)stopFadingInImageViewWithIdentifier:(NSString *)identifier;


-(void)changeImageViewIndex:(int)index forImageViewIdentifier:(NSString *)identifier;
-(void)hideImageViewWithIdentifier:(NSString *)identifier;
-(void)hideImageViewWithIdentifierPrefix:(NSString *)identifier;
-(void)showImageViewWithIdentifier:(NSString *)identifier;
-(void)makeImageViewWithIdentifier:(NSString *)identifier hidden:(BOOL)hidden;
-(void)makeImageViewsWithIdentifiers:(NSArray *)identifiers hidden:(BOOL)hidden;
-(void)hideAllImageViews;
-(void)showAllImageViews;

-(void)fallAsleep;


#pragma mark Mouths
-(void)openMouth;
-(void)closeMouth;
-(void)showTeeth;

-(void)smile;
-(void)smileTemporarily;

-(void)giggle;

@end
