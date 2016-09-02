//
//  NFClothesLineViewController.h
//
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NFGameViewController.h"

//! Subclasses ViewController - for faster setup of common UI elements
//  such as loading indicators, background image view, controls layer.
@interface NFClothesLineViewController : NFGameViewController

@property (nonatomic, strong) IBOutletCollection(NFDraggableView) NSArray *draggableClothes;
@property (nonatomic, strong) IBOutletCollection(NFImageView) NSArray *blackSpotsImageViews;
@property (nonatomic, strong) IBOutletCollection(NFImageView) NSArray *clothesPinsImageViews;
@property (nonatomic, strong) IBOutlet UIImageView *clothesLineImageView;


-(void)layout;

#pragma mark Place clothes
-(void)placeDraggableClothingItem:(NFDraggableView *)draggableView forBlackSpotImageView:(NFImageView *)blackSpotImageView;
-(void)selectNewRandomImageForDraggableView:(NFDraggableView *)draggableView andBlackSpotImageView:(NFImageView *)blackSpotImageView;
#pragma mark Delegates
-(void)draggableViewDidBeginDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)draggableViewDidContinueDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)draggableViewDidEndDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)draggableViewDidCancelDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;

#pragma mark Banner Ads
-(void)makeSpaceForBannerAd:(UIView *)bannerAdView animated:(BOOL)animated;

#pragma mark iPhone5
-(void)adjustLayoutForIPhone5;


@end
