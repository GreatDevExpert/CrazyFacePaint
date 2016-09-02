//
//  NFEmitterLayer.h
//  Dazzle
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CoreAnimation.h>
// TODO: decide whether to make NFSounds dependent or to use a callback.
// Or delegate
#import "NFSounds.h"
@class NFEmitterLayer;

@protocol NFEmitterLayerDelegate <NSObject>
@optional
-(void)emitterLayerDidPulse:(NFEmitterLayer *)emitterLayer;

@end

@interface NFEmitterLayer : CAEmitterLayer

@property (nonatomic, strong) CABasicAnimation *basicAnimation;

@property CGPoint pulsePosition;
@property (nonatomic, copy) NSString *pulseSoundName;
@property SEL pulseCallback;
@property (nonatomic, unsafe_unretained) id<NFEmitterLayerDelegate> delegate;
@property CGFloat pulsePeriod;


//#ifndef ANDROID

+(NFEmitterLayer *)blendingEmitterWithColor:(UIColor *)color;

+(NFEmitterLayer *)circularStarExplosionEmitter;

#pragma mark Spraying emitters
+(NFEmitterLayer *)sprayingEmitterWithColor:(UIColor *)color;
+(NFEmitterLayer *)waterSprayingEmitterWithColor:(UIColor *)color;
+(NFEmitterLayer *)waterShowerEmitterWithColor:(UIColor *)color;

+(NFEmitterLayer *)mouthSprayEmitterWithColor:(UIColor *)color;
+(NFEmitterLayer *)waterJetEmitterWithColor:(UIColor *)color;
+(NFEmitterLayer *)waterGunEmitterWithColor:(UIColor *)color;
+(NFEmitterLayer *)bubbleBlasterEmitterWithImageName:(NSString *)imageName;


#pragma mark Pouring Emitters
+(NFEmitterLayer *)pouringEmitterWithColor:(UIColor *)color;
+(NFEmitterLayer *)waterPouringEmitter;

+(NFEmitterLayer *)powderTouchEmitter;
+(NFEmitterLayer *)foundationStreakTouchEmitter;

+(NFEmitterLayer *)halloweeningIceEmitter;
+(NFEmitterLayer *)steamTouchEmitter;


+(NFEmitterLayer *)candleFlameEmitter;

#pragma mark Musical Note Emitter
+(NFEmitterLayer *)musicalNoteEmitterLayer;
+(NFEmitterLayer *)musicalNoteEmitterLayerWithMusicalNoteImageNames:(NSArray *)musicalNoteImageNames;


+(NFEmitterLayer *)tapToEatExplosionEmitter;

+(NFEmitterLayer *)starLineEmitter;
+(NFEmitterLayer *)starsCrossingScreenEmitter;
+(NFEmitterLayer *)twinklingStarsEmitter;

#pragma mark Falling Ice Emitter
+(NFEmitterLayer *)fallingIceEmitter;

#pragma mark Bubble emitters
+(NFEmitterLayer *)bubbleScrubTouchEmitterWithImageNames:(NSArray *)imageNames;
+(NFEmitterLayer *)bubbleBurstTouchEmitter;
+(CAEmitterLayer *)floatingUpBubblesEmitterLayerWithBubbleImageName:(NSString *)bubbleImageName;


/**
 * Spurts a small blast of bubbles when calling [NFEmitterLayer touchAnimationForPoint:]
 * self.bubbleSpurtOnTouchEmitterLayer = [NFEmitterLayer bubbleSpurtOnTouchEmitterLayerWithBubbleImageName:@"shared-particle_textures-bubble"];
 * [self.view.layer addSublayer:self.bubbleSpurtOnTouchEmitterLayer];
 * . . . .
 * [self.bubbleSpurtOnTouchEmitterLayer touchAnimationForPoint:<some point>]
 */
+(NFEmitterLayer *)bubbleSpurtOnTouchEmitterLayerWithBubbleImageName:(NSString *)bubbleImageName;

+(CAEmitterLayer *)floatingAcrossFishEmitterLayerWithFishImageNames:(NSArray *)fishImageNames;

+(NFEmitterLayer *)sparklingTouchEmitter;

+(NFEmitterLayer *)fireworksEmitter;
+(NFEmitterLayer *)explosionEmitterWithParticleImageName:(NSString *)particleImageName;

-(void)touchAnimationForPoint:(CGPoint)position;
-(void)startPulseAnimating;
-(void)stopPulseAnimating;


//#endif


@end
