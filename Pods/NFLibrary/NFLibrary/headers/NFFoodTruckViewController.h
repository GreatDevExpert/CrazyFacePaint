//
//  NFFoodTruckViewController.h
//  Pods
//
//  Created by Jeff Patternstein on 9/15/14.
//
//

#import "NFGameViewController.h"
#import "NFMeterView.h"
#import "NFViewController+draggableViewHandlers.h"
#import "NSDictionary+keyPathFinder.h"

@interface NFFoodTruckViewController : NFGameViewController<NFDraggableViewDelegate>


@property (nonatomic, strong) IBOutlet UIImageView *guideViewForBurgerItem;
@property (nonatomic, strong) IBOutlet UIImageView *trashCanImageView;

@property (nonatomic, strong) IBOutlet NFImageView *customerImageView;
@property (nonatomic, strong) IBOutlet UIImageView *cookingAreaImageView;
@property (nonatomic, strong) IBOutlet NFImageView *burgerBubbleImageView;

@property (nonatomic, strong) IBOutlet NFMeterView *meterView;

@property (nonatomic, strong) IBOutlet NFDraggableView *draggableBurgerBunTop;
@property (nonatomic, strong) IBOutletCollection(NFDraggableView) NSArray *draggableCheeses;
@property (nonatomic, strong) IBOutletCollection(NFDraggableView) NSArray *draggableRawMeats;
@property (nonatomic, strong) IBOutletCollection(NFDraggableView) NSArray *draggablePickles;
@property (nonatomic, strong) IBOutletCollection(NFDraggableView) NSArray *draggableSauces;
@property (nonatomic, strong) IBOutletCollection(NFDraggableView) NSArray *foodContainers;
@property (nonatomic, strong) IBOutlet NFDraggableView *draggableBurgerPan;
@property (nonatomic, strong) IBOutlet NFDraggableView *draggableSpoon;
@property (nonatomic, strong) IBOutlet NFImageView *burgerBunBottomImageView;

@property (nonatomic, strong) NFDraggableView *draggableBurgerView;
@property (nonatomic, strong) NSMutableArray *burgerItemDraggableViews;
@property (nonatomic, strong) NSMutableArray *sauceImageViews;
@property BOOL burgerPlaced;

-(void)startBurgerFlippingAnimationForDraggableView:(NFDraggableView *)draggableView;

-(void)didFinishMakingBurger;

-(void)addBurgerItem:(NSString *)burgerItem;
-(void)addDraggableView:(NFDraggableView *)draggableView toDraggableBurgerView:(NFDraggableView *)draggableBurgerView;

-(void)placeSauceForDraggableView:(NFDraggableView *)draggableView withImageView:(NFImageView *)imageView;
-(void)placeSauceForDraggableView:(NFDraggableView *)draggableView;

-(void)placeBurgerItem:(NFDraggableView *)draggableView completionHandler:(void (^ )(void))completionHandler;
-(void)placeBurgerInTrash:(void (^ )(BOOL finished))completionHandler;
-(void)resetBurgerItems;

-(void)originaFrameFix;

-(void)slideBurgerTowardsCustomer;

@end