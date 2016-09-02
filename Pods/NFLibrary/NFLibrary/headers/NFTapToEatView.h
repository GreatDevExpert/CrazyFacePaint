//
//  NFTapToEatView.h
//  Pods
//
//  Created by William Locke on 2/4/13.
//
//

#import <UIKit/UIKit.h>
#import "NFAnimation.h"
#import "NFSounds.h"

@interface NFTapToEatView : UIView


@property (nonatomic, strong) UIImage *consumableImage;
@property (nonatomic, strong) UIImage *backgroundImage;
@property (nonatomic, strong) UIImage *nonConsumableImage;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *consumableLayerImageView;
@property (nonatomic, strong) UIImageView *nonConsumableLayerImageView;

@property (nonatomic, strong) NFEmitterLayer *touchEmitter;

@property (nonatomic, strong)  NFSounds *sounds;
@property (nonatomic, strong)  NSString *biteSoundName;
@property (nonatomic, strong)  NSArray *biteSoundsArray;

@property int biteWidth;


-(void)layout;
-(void)reset;
-(UIImage *)captureScreen;

@end
