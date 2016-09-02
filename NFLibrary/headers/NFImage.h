//
//  NFImage.h
//
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface NFImage : NSObject

typedef void (^ nf_image_lib_callback)(BOOL finished);

@property BOOL shouldUseFolderPath;
@property NSString *imagesFolder;

@property BOOL useLowResImages;

#pragma mark Shared Instance
+(NFImage *)sharedInstance;


#pragma mark Cropping
+(UIImage *)crop:(UIImage *)image toFrame:(CGRect)frame;
+(UIImage *)crop:(UIImage *)image toPercentageFrame:(CGRect)frame;

#pragma mark Masking Functions
+(UIImage *)maskImage:(UIImage *)image verticallyWithEdgeMask:(UIImage *)edgeMask percentFilled:(CGFloat)percentFilled;
+ (UIImage *)maskImage:(UIImage *)image withMask:(UIImage *)maskImage;


+(UIImage *)blankImageOfSize:(CGSize)size color:(UIColor *)color;
+ (UIImage *)createMask;
+ (UIImage *)createMaskOfSize:(CGSize)size;

+(UIImage *)maskImage:(UIImage *)image continuePathToPoint:(CGPoint)point withLineWidth:(float)lineWidth lastPoint:(CGPoint)lastPoint;
+(UIImage *)maskImage:(UIImage *)image continuePathToPoint:(CGPoint)point withLineWidth:(float)lineWidth lastPoint:(CGPoint)lastPoint isMasking:(BOOL)isMasking;

+(UIImage *)maskImage:(UIImage *)image continuePathToPoint:(CGPoint)point withLineWidth:(float)lineWidth lastPoint:(CGPoint)lastPoint isMasking:(BOOL)isMasking color:(UIColor *)color;

+ (UIImage *)createBlackMaskOfSize:(CGSize)size;

+(UIImage *)maskImage:(UIImage *)image drawSpotAtPoint:(CGPoint)point withWidth:(float)width;


#pragma mark Erasing.
+(UIImage *)eraseImage:(UIImage *)image continuePathToPoint:(CGPoint)point withLineWidth:(float)lineWidth lastPoint:(CGPoint)lastPoint;
+(UIImage *)eraseImage:(UIImage *)image continuePathToPoint:(CGPoint)point withLineWidth:(float)lineWidth lastPoint:(CGPoint)lastPoint hardness:(CGFloat)hardness;


+(UIImage *)eraseImage:(UIImage *)image withSpotAtPoint:(CGPoint)point withWidth:(float)width;

+(UIImage *)eraseImage:(UIImage *)image withSpotsAtPoints:(NSArray *)points withWidth:(float)width;



#pragma mark Rotation
+(void)rotateView:(UIView *)view radians:(CGFloat)radians;

+ (UIImage *)scaleAndRotateImage:(UIImage *)image;
+(UIImage*)rotate:(UIImage*)src orientation:(UIImageOrientation)orientation;

#pragma mark Layering Functions
+(UIImage *)layerImage:(UIImage *)backgroundImage overImage:(UIImage *)overlayImage;


#pragma mark Retrieving images from file name
+ (NSData *)applicationDataFromFile:(NSString *)fileName;
+(UIImage *)imageForName:(NSString *)imageName allowHighRes:(BOOL)allowHighRes addFolderPath:(BOOL)addFolderPath;
+(UIImage *)imageForName:(NSString *)imageName allowHighRes:(BOOL)allowHighRes;
+(UIImage *)imageForName:(NSString *)imageName;
+(BOOL)lowResImageExists:(NSString *)imageName;
+(NSString *)deviceSpecificImageName:(NSString *)imageName;

+(NSArray *)imageArrayFromImageNames:(NSArray *)imageNames;

+(BOOL)isRetina;

#pragma mark Average Color
+ (UIColor *)averageColor:(UIImage *)image __attribute__((deprecated));
+ (UIColor *)colorFromImage:(UIImage *)image;
+ (NSArray*)getRGBAsFromImage:(UIImage*)image atX:(int)xx andY:(int)yy count:(int)count;

#pragma mark Image from view
+(UIImage*)imageFromView:(UIView *)view;
+(UIImage*)imageFromLayer:(CALayer *)layer;

#pragma mark Image color
+(UIImage *) changeColor: (UIImage *)image colorSelected:(UIColor *)colorSelected;

+(BOOL)image:(UIImage *)image isTransparentAtPoint:(CGPoint)point;

// TODO: move to category
+(void)scaleFrameToImageSizeForImageView:(UIImageView *)imageView;


#pragma mark Drawing
+(UIImage *)drawToImage:(UIImage *)image continuePathToPoint:(CGPoint)point withLineWidth:(float)lineWidth lastPoint:(CGPoint)lastPoint;
+(UIImage *)drawToImage:(UIImage *)image continuePathToPoint:(CGPoint)point lastPoint:(CGPoint )lastPoint withLineWidth:(float)lineWidth color:(UIColor *)color imageSize:(CGSize)imageSize;

+(UIImage *)drawToImage:(UIImage *)image drawSpotAtPoint:(CGPoint)point withWidth:(float)width;


#pragma mark Resize Functions
+(UIImage *)proportionallyResizeImage:(UIImage *)image toBounds:(CGSize)size;
+(UIImage *)proportionallyResizeImage:(UIImage *)image toBounds:(CGSize)size scale:(float)scale;
+(UIImage *)resize:(UIImage *)image toBounds:(CGSize)size;
+(UIImage *)resize:(UIImage *)image toBounds:(CGSize)size withScale:(float)scale;


@end
