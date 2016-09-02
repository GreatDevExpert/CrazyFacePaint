//
//  DraggableImageView.h
//
//
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


typedef enum  {
    NFDraggingImplementationTypeDefault,
    NFDraggingImplementationTypeFrameBased,
    NFDraggingImplementationTypeAffineTransformationBased
}NFDraggingImplementationType;

@class NFDraggableView;
@protocol NFDraggableViewDelegate <NSObject>
@required
-(void)draggableViewDidBeginDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;
@required
-(void)draggableViewDidContinueDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;
@required
-(void)draggableViewDidEndDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;
@required
-(void)draggableViewDidCancelDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;

@end

/**
 Creates a view that can be dragged.
 
 Usually view contains an image, so currently common ways to initialize an object of this class is to call:
 [NFDraggableView makeDraggable:myImageView];
 
 This type of view can also be set up in interface builder by creating a UIView then setting its class to NFDraggableView. After creating this, add a UIImageView subview (if you want the draggable view to be a draggable image), then set this images outlet to the imageView property of this class.
 
 // Shows both ways of creating an object of this class described above.
 Example: https://github.com/ninjafishstudios/Milkshake/blob/develop/App/Classes/ViewControllers/BlenderViewController.m
 
 */
@interface NFDraggableView : UIView

@property (nonatomic, unsafe_unretained) IBOutlet id <NFDraggableViewDelegate> delegate;

/**
 *  Essentially contains item that is draggable. The image contained in this
 *  image view is an image representing a draggable UI element.
 */
@property (nonatomic, strong) IBOutlet UIImageView *imageView;

/**
 *  Option to set whether view is currently draggable.
 */
@property BOOL draggable;

/**
 *  This property defaults to YES. However dragging in the horizontal
 *  direction can be disabled.
 */
@property BOOL horizontalDragEnabled;

/**
 *  This property defaults to YES. However dragging in the vertical
 *  direction can be disabled.
 */
@property BOOL verticalDragEnabled;

/**
 *  A CGPoint representing last position that this view received touch events.
 */
// TODO: clean this up. Perhaps use a private ivar.
@property CGPoint lastTouch;

/**
 *  A CGPoint representing first touch in the current drag event (e.g. the point
 *  where dragging began).
 */
// TODO: clean this up. Perhaps use a private ivar.
@property CGPoint firstTouch;

/**
 *  This is set upon instantiation. Useful when a draggable element needs to
 *  return to its original position when draging ends.
 */
@property CGRect originalFrame;

/**
 *  This view offers an option for shrinking on drag. This view will shrink
 *  proportionately as it gets closer to the 'shrinkFrame'.
 *  If the 'shrinkable' property is not set to YES, then this behavior is not enabled.
 */
@property CGRect shrinkFrame;

/**
 *  Determines whether the draggable view is shrinkable.
 */
@property BOOL shrinkable;

/**
 *  Indicates whether a minimum origin property is set.
 *  If a minimum origin is set, then this views draggable space on screen will be
 *  restricted so that its origin does not go lower than the minimumOrigin point.
 */
@property BOOL minimumOriginSet;

/**
 *  Indicates whether a maximum origin property is set.
 *  If a maximum origin is set, then this views draggable space on screen will be
 *  restricted so that its origin does not go higher than the maximumOrigin point.
 */
@property BOOL maximumOriginSet;

// TODO: determine need for this property. Possibly make private.
@property CGPoint touchPoint;

/**
 *  If this is set to YES, then when the view is being dragged, it will always
 *  center itself at the drag point.
 */
@property BOOL centerAtTouchPoint;

// TODO: determine need for this property. Possibly make private.
@property CGPoint frameOriginWhenTouchesBegan;

/**
 *  Indicates an angle (in radians) that the draggable should be rotated while
 *  it is in a draggable state.
 */
@property CGFloat rotateOnDragAngle;

/**
 *  Returns draggable view to its origin position upon drag end.
 */
@property BOOL shouldFloatBackToOriginalFrameUponTouchedEnded;

/**
 *  If the draggable object should take a different appearance while being dragged,
 *  a draggingImage can be set and the image contained in the imageView property
 *  will be changed accordingly when dragging is in progress.
 */
// TODO: Deprecate this and replace with draggingImageName
@property (nonatomic, strong) UIImage *draggingImage;


@property (nonatomic, copy) NSString *draggingImageName;

/**
 *  Used as a pointer to origin image when a dragging image is used.
 */
// TODO: clean this up. Maybe change property name.
@property (nonatomic, strong) UIImage *stationaryImage;

@property NFDraggingImplementationType draggingImplementationType;

/**
 *  If this is set to YES, then when the view is being dragged, it will always
 *  grow (or shrink) to the size of the image upon dragging (image = self.imageView.image).
 */
@property BOOL shouldResizeToImageSizeUponDrag;


@property (nonatomic) CGPoint minimumOrigin;
@property (nonatomic) CGPoint maximumOrigin;

@property (nonatomic, strong) NSString *identifier;
@property  int originalLayerIndex;

/**
 *  If this draggable view has an associated product, i.e. it can be unlocked 
 * by purchase (or incent video) then productId can be set.
 */
@property (nonatomic, copy) NSString *productId;


+(id)makeDraggable:(UIView *)view;


#pragma mark Animations
-(void)floatBackToOriginalFrame;
-(void)floatBackToOriginalFrameWithCompletionHandler:(void (^ )())completionHandler;

#pragma mark Getter/Setters
-(void)setMinimumOrigin:(CGPoint)minimumOrigin;
-(CGPoint)getMinimumOrigin;

-(void)setMaximumOrigin:(CGPoint)minimumOrigin;
-(CGPoint)getMaximumOrigin;


-(void)handleDragToPoint:(CGPoint)touchPoint;
-(void)centerAtTouchPoint:(CGPoint)touchPoint;
-(void)centerAtTouchPoint:(CGPoint)touchPoint percentagePointOffset:(CGPoint)percentagePointOffset;



// TODO: decide on better way of achieveing this.
#pragma mark NFDraggableView specific touch handling.
-(void)draggableViewTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)draggableViewTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)draggableViewTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)draggableViewTouchesCanceled:(NSSet *)touches withEvent:(UIEvent *)event;


#pragma mark Touch Handling
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;




@end
