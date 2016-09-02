//
//  NFAccelerometer.h
//  Cupcake
//
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NFAccelerometer;


#define NFAccelerometerShakeThresholdStrong 0.7
#define NFAccelerometerShakeThresholdWeak 0.55


@protocol NFAccelerometerDelegate <UIAccelerometerDelegate>
@optional
-(void)accelerometer:(NFAccelerometer *)accelerometer didDetectShake:(UIAcceleration *)acceleration;

@end



@interface NFAccelerometer : NSObject

@property(nonatomic,assign) id<NFAccelerometerDelegate> delegate;
@property BOOL histeresisExcited;
@property (nonatomic, strong) UIAcceleration* lastAcceleration;

@property int shakeThreshold;

+(NFAccelerometer *)sharedInstance;

@end
