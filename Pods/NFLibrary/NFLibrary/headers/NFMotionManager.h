//
//  NFMotionManager.h
//
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreMotion/CoreMotion.h>

@class NFMotionManager;
@protocol NFMotionManagerDelegate <NSObject>
@optional
-(void)motionManagerDidDetectPouringBegan:(NFMotionManager *)motionManager;
-(void)motionManagerDidDetectPouringEnded:(NFMotionManager *)motionManager;

-(void)motionManagerDidDetectAttitudeChange:(NFMotionManager *)motionManager;

@end

@interface NFMotionManager : NSObject

@property (nonatomic, unsafe_unretained) id <NFMotionManagerDelegate> delegate;
@property (nonatomic, strong) CMMotionManager *motionManager;
@property float updateInterval;
@property (nonatomic, strong) NSTimer *timer;
@property BOOL pouring;
@property float pourAngle;

@property CMAttitude *attitude;

+(NFMotionManager *)sharedInstance;

-(void)updateMotionManager;

@end
