//
//  NFLayout.h
//
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>



#define kDeviceWidthIPhone 320.0
#define kDeviceHeightIPhone 480.0
#define kDeviceWidthIPad 768.0
#define kDeviceHeightIPad 1024.0
#define kIPadWidthMultiplier (kDeviceWidthIPad/kDeviceWidthIPhone)
#define kIPadHeightMultiplier (kDeviceHeightIPad/kDeviceHeightIPhone)
#define kScreenFrame CGRectMake(0.0f,0.0f,320.0f,480.0f)
#define kIPadFontSizeMultiplier 2.0


DEPRECATED_ATTRIBUTE
@interface NFLayout : NSObject

+(float)deviceFloat:(float)number;
+(CGRect)percentageFrame:(CGRect)percentageFrame;

+(UIImage *)imageForName:(NSString *)imageName allowHighRes:(BOOL)allowHighRes;
+(UIImage *)imageForName:(NSString *)imageName;
+(BOOL)lowResImageExists:(NSString *)imageName;
+(CGRect)deviceFrame:(CGRect)rect;
+(CGSize)deviceSize:(CGSize)size;
+(UIView *)activityIndicatorView;
+(UIView *)activityIndicatorViewForViewController:(UIViewController *)viewController;
+(int)deviceFontSize:(int)size;
+(void)printRect:(CGRect)rect name:(NSString *)name;
+(CGRect)multiplyRect:(CGRect)frame by:(float)scale;
+(float)scale;

// Doesn't handle orientation, assumes portrait orientation
// @todo: Handle multiple orientations.
+(CGRect)screenFrame;
+(float)universalLayoutDistance:(float)distance;
+(CGRect)centeredRectForSize:(CGSize)size inView:(UIView *)view;


+(CGFloat)horizontalDistanceBetweenPoint:(CGPoint)point1 andPoint:(CGPoint)point2;
+(CGFloat)distanceBetweenPoint:(CGPoint)point1 andPoint:(CGPoint)point2;
+(CGPoint)viewCenterPoint:(UIView *)view;
+(CGFloat)distanceBetweenView:(UIView *)view1 andView:(UIView *)view2;


@end
