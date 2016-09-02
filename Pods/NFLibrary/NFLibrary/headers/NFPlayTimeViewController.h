//
//  NFPlayTimeViewController.h
//  Pods
//
//  Created by Jeff Patternstein on 8/22/14.
//
//

#import "NFDragActionsViewController.h"
#import "NFViewController+tappableHandlers.h"

@interface NFPlayTimeViewController : NFDragActionsViewController

@property (nonatomic, strong) IBOutletCollection(NFImageView) NSArray *tappableImageViews;
@property (nonatomic, strong) IBOutlet NFImageView *rugImage;

@property(strong,nonatomic) NSMutableArray *tappableImageViewButtons;

- (IBAction)changeRugImage:(id)sender;

@end
