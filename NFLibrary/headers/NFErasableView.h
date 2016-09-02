//
//  NFErasableView.h
//
//

#import <UIKit/UIKit.h>

@class NFErasableView;
@protocol NFErasableViewDelegate <NSObject>
@required
-(void)erasableViewDidBeginDragging:(NFErasableView *)erasableView;
@optional
-(void)erasableViewDidContinueDragging:(NFErasableView *)NFDraggableView;
@optional
-(void)erasableViewDidEndDragging:(NFErasableView *)NFDraggableView;

@optional
-(void)erasableViewDidChangeDraggingDirection:(NFErasableView *)NFDraggableView;

@end


/**
 *  Creates a view containing an imageView that can be erased by dragging finger.
 *
 */
@interface NFErasableView : UIView

@property (nonatomic, unsafe_unretained) id <NFErasableViewDelegate> delegate;
@property BOOL draggable;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *originalImage;
@property (nonatomic, strong) UIImage *maskImage;

/**
 *  The level of alpha that will be removed upon swipe, this is a value between 0-1 where 1 
 *  removes touched parts of image completely, and 0 removes none. 
 */
@property CGFloat hardness;

/**
 *  The diameter of the removed line (corresponding to dragged line). 
 */
@property CGFloat scratchDiameter;


- (id)initWithFrame:(CGRect)frame image:(UIImage *)image;

+(id)makeErasable:(UIImageView *)imageView;


-(CGPoint)correctTouchPoint:(CGPoint)touchPoint;

-(void)handleDragToPoint:(CGPoint)touchPoint updateMask:(BOOL)updateMask updateDisplayedImage:(BOOL)updateDisplayedImage;

-(void)handleTouchesBeganAtPoint:(CGPoint)touchPoint;


#pragma mark Touch handling
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;

@end
