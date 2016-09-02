//
//  NFFoodViewController.h
//  Pods
//
//  Created by William Locke on 8/14/14.
//
//

#import "NFGameViewController.h"

@interface NFFoodViewController : NFGameViewController

@property (nonatomic, strong) IBOutletCollection(NFDraggableView) NSArray *draggableFoods;
@property (nonatomic, strong) IBOutletCollection(NFDraggableView) NSArray *draggableTowels;
@property (nonatomic, strong) IBOutletCollection(NFDraggableView) NSArray *draggableClothes;
@property (nonatomic, strong) IBOutletCollection(NFDraggableView) NSArray *draggableBottles;
@property (nonatomic, strong) IBOutletCollection(NFImageView) NSArray *foodContainers;
@property (nonatomic, strong) IBOutletCollection(NFDraggableView) NSArray *placedDraggableClothes;
@property (nonatomic, strong) IBOutletCollection(NFDraggableView) NSArray *placedDraggableBottles;

@property (nonatomic, strong) IBOutlet NFDraggableView *draggableSpoon;

@property (nonatomic, strong) IBOutlet UIView *guideViewForMouth;

@property(nonatomic) float draggableFoodMinDistance;

-(void)layout;

-(void)didPlaceDraggableBottle:(NFDraggableView *)draggableView;
-(void)didPlaceDraggableClothing:(NFDraggableView *)draggableView;
-(NSString *)restingImageNameForDraggableView:(NFDraggableView *)draggableView;

#pragma mark <NFDraggableViewDelegate>
-(void)draggableViewDidBeginDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)draggableViewDidContinueDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)draggableViewDidEndDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)draggableViewDidCancelDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;

@end
