//
//  NFTimerView.h
//  LittleCarWash
//
//  Created by William Locke on 9/18/13.
//  Copyright (c) 2013 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@class NFTimerView;

typedef void (^NFTimerViewCompletionHandler)();

@protocol NFTimerViewDelegate <NSObject>

@optional;
-(void)timerViewDidRunOutOfTime:(NFTimerView *)timerView;

@optional;
-(void)timerViewPressed:(NFTimerView *)timerView;

@end

@interface NFTimerView : UIView

@property (nonatomic, unsafe_unretained) id<NFTimerViewDelegate> delegate;
@property int seconds;
@property (nonatomic, strong) IBOutlet UILabel *label;
@property (nonatomic, strong) IBOutlet UIImageView *backgroundImageView;
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) NFTimerViewCompletionHandler completionHandler;

-(void)start;
-(void)pause;
-(void)stop;


-(void)updateLabel;

+(NFTimerView *)createTimerViewWithBackgroundImageName:(NSString *)imageName countdownLengthInSeconds:(int)seconds viewToAddTo:(UIView *)view fontName:(NSString *)fontName completionHandler:(void (^ )())completionHandler;

@end
