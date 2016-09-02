//
//  NFProgressView
//
//
//

#import <UIKit/UIKit.h>

@interface NFProgressView : UIView

- (id)initWithParentViewFrame:(CGRect)frame;

-(void)setProgress:(float)progress animated:(BOOL)animated;

@property (nonatomic, strong) UIProgressView *progressBar;
@property (nonatomic, strong) UILabel *progressLabel;


-(void)centerProgressBar;

@end
