//
//  NFNapTimeViewController.h
//  Pods
//
//  Created by Jeff Patternstein on 8/21/14.
//
//

#import "NFDragActionsViewController.h"
#import "NFViewController+tappableHandlers.h"
#import "NFEmitterLayer.h"

@interface NFNapTimeViewController : NFDragActionsViewController

@property(strong,nonatomic) NFImageView* backgroundImageView;
@property (nonatomic, strong) IBOutletCollection(NFImageView) NSArray *tappableImageViews;
@property(strong,nonatomic) NSMutableArray *tappableImageViewButtons;
@property(strong,nonatomic) NFEmitterLayer *musicNotesEmitterLayer;
@property bool blanketPlaced;
@property bool areAllLampsOff;
@property (nonatomic, strong) NFEmitterLayer *sleepingEmitterLayer;
-(IBAction)tappableButtonPressed:(id)sender;

@end
