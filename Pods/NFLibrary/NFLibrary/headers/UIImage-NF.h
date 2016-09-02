//
//  UIImage-NF.h
//  MakeUp
//
//  Created by William Locke on 1/14/13.
//
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface UIImage (NF)


#pragma mark Masking
+(UIImage *)blankImageOfSize:(CGSize)size color:(UIColor *)color;
+ (UIImage *) createMask;
+ (UIImage *) createMaskOfSize:(CGSize)size;
+ (UIImage *) createBlackMask;
+ (UIImage *)createBlackMaskOfSize:(CGSize)size;
+ (UIImage *)maskImage:(UIImage *)image withMask:(UIImage *)maskImage;
-(UIImage *)continuePathToPoint:(CGPoint)point withLineWidth:(CGFloat)lineWidth lastPoint:(CGPoint)lastPoint;
-(UIImage *)continuePathToPoint:(CGPoint)point withLineWidth:(CGFloat)lineWidth lastPoint:(CGPoint)lastPoint isMasking:(BOOL)isMasking;
-(UIImage *)continuePathToPoint:(CGPoint)point withLineWidth:(CGFloat)lineWidth lastPoint:(CGPoint)lastPoint isMasking:(BOOL)isMasking color:(UIColor *)color;

-(UIImage *)drawSpotAtPoint:(CGPoint)point withWidth:(CGFloat)width;
-(UIImage *)erasePathToPoint:(CGPoint)point withLineWidth:(CGFloat)lineWidth lastPoint:(CGPoint)lastPoint;
-(UIImage *)erasePathToPoint:(CGPoint)point withLineWidth:(CGFloat)lineWidth lastPoint:(CGPoint)lastPoint hardness:(CGFloat)hardness;


-(UIImage *)eraseSpotAtPoint:(CGPoint)point withWidth:(CGFloat)width;
-(UIImage *)eraseSpotsAtPoints:(NSArray *)points withWidth:(CGFloat)width;



#pragma mark Transform
- (void)resizeToMaxWidth:(CGFloat)maxWidth maxHeight:(CGFloat)maxHeight;
-(void)resizeToMaxWidth:(int)maxWidth;
+(UIImage *)crop:(UIImage *)image toFrame:(CGRect)frame;
+(UIImage *)layerImage:(UIImage *)backgroundImage overImage:(UIImage *)overlayImage;



#pragma mark Resize
-(UIImage *)resizeImageWithMaxWidth:(int)maxWidth;
-(UIImage *)proportionallyResizeToBounds:(CGSize)size;





@end
