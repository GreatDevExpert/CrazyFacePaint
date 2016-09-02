//
//  NFScratchToRevealView.h
//
//
//

#import <UIKit/UIKit.h>

extern float const kNFScratchToRevealViewDefaultScratchDiameter;

typedef enum{
    NFScratchToRevealViewModeDefault,
    NFScratchToRevealViewModeMasking,
    NFScratchToRevealViewModePatternColor,
    NFScratchToRevealViewModeScratchToReveal,
    NFScratchToRevealViewModeErase
}NFScratchToRevealViewMode;


@class NFScratchToRevealView;
@protocol NFScratchToRevealViewDelegate <NSObject>
@optional
-(void)scratchToRevealViewDidBeginScratching:(NFScratchToRevealView *)scratchToRevealView touches:(NSSet *)touches withEvent:(UIEvent *)event;
@optional
-(void)scratchToRevealViewDidContinueScratching:(NFScratchToRevealView *)scratchToRevealView touches:(NSSet *)touches withEvent:(UIEvent *)event;
@optional
-(void)scratchToRevealViewDidEndScratching:(NFScratchToRevealView *)scratchToRevealView touches:(NSSet *)touches withEvent:(UIEvent *)event;
@end


/**
 Creates a view containing an image that can be revealed by the user dragging their finger across the areas they want to reveal. There is also an erase mode where the user can remove parts of an image by dragging their finger.
 There are a number of modes available such as NFScratchToRevealViewModeMasking, NFScratchToRevealViewModePatternColor, NFScratchToRevealViewModeScratchToReveal that use different underlying methods to reveal the designated image. 
 The masking mode for instance uses a grayscale mask image that the user draws onto (and which is subsequently used to mask original designated image). This method is the slowest in terms of performance, but offers the option of setting a brush hardness type property.
 The PatternColor mode has good performance but can't be used effectively if the designated image contains areas with slight opacity (outright transparent areas are fine). 
 The ScratchToReveal mode uses a snapshot of the current view and lays that on top of the image to reveal. When this top layer is scratched off (by erasing), the designated image is revealed. 
 @warning *Important:* The erase mode uses masking in order that it work for situations where erasing and then re-revealing an image is necessary. Thus, when using it this way you must toggle between NFScratchToRevealViewModeErase and NFScratchToRevealViewModeMasking modes. 
 */
@interface NFScratchToRevealView : UIView

// TODO: update naming of bottom, middle, top image view.
// Call the view that holds current image: imageView. 
@property (strong, nonatomic) UIImageView *bottomImageView;

/**
 *  Contains the image to reveal
 */
@property (strong, nonatomic) UIImageView *middleImageView;

/**
 *  Contains a snapshot of the background surroundings of the image to reveal. 
 */
@property (strong, nonatomic) UIImageView *topImageView;
@property (strong, nonatomic) UIImage *currentImage;
@property (strong, nonatomic) UIImage *imageToReveal;
@property (strong, nonatomic) UIImage *maskImage;

/**
 *  Used when in NFScratchToRevealViewModePatternColor mode. Basically a UIColor representation of image to reveal, created by calling [UIColor colorWithPatternImage:]
 */
@property (strong, nonatomic) UIColor *patternColor;

/**
 *  The diameter of the removed line (corresponding to dragged line).
 */
@property int scratchDiameter;
@property NFScratchToRevealViewMode mode;
@property CGPoint touchOffset;

/**
 *  The level of alpha that will be removed upon swipe, this is a value between 0-1 where 1
 *  removes touched parts of image completely, and 0 removes none.
 */
@property CGFloat eraserHardness;
@property (strong, nonatomic) NSString *identifier;


@property int updateFrequency;

+(NFScratchToRevealView *)makeScratchable:(UIView *)view;
+(NFScratchToRevealView *)makeScratchable:(UIView *)view mode:(NFScratchToRevealViewMode)mode;


-(void)layout;
-(void)reset;

-(void)cropToRect:(CGRect)rect;
-(void)changeImage:(UIImage *)image;

-(void)handleTouchesBeganAtPoint:(CGPoint)touchPoint;
-(void)handleDragToPoint:(CGPoint)touchPoint updateMask:(BOOL)updateMask updateDisplayedImage:(BOOL)updateDisplayedImage;

#pragma mark Touch handling
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;


@end
