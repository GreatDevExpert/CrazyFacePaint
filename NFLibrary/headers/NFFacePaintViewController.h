//
//  NFFacePaintViewController.h
//
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NFGameViewController.h"

//! Subclasses ViewController - for faster setup of common UI elements
//  such as loading indicators, background image view, controls layer.
@interface NFFacePaintViewController : NFGameViewController

@property (nonatomic, strong) IBOutlet NFDraggableView *draggablePaintBrush;
@property (nonatomic, strong) IBOutlet NFDraggableView *draggableFacePaintRemover;
@property (nonatomic, strong) IBOutlet NFScrollableBenchView *scrollableBenchView;
@property (nonatomic, strong) IBOutlet UIImageView *benchImageView;
@property (nonatomic, strong) IBOutlet UIImageView *paintBrushImageView;
@property (nonatomic, strong) IBOutlet UIImageView *guideImageViewForFacePaint;

@property (nonatomic, strong) IBOutlet NFScrollViewSelector *sideScrollViewSelector;
@property (nonatomic, strong) id retainedBlock;

@property CGRect percentageFrameForFacePaintArea;

@property (nonatomic, strong) NFScratchToRevealView *currentScratchableView;
@property CGPoint currentTouchPointOffset;


-(void)layout;
-(void)layoutScrollableBenchView;
-(void)layoutCharacter;

#pragma mark Show / Hide
-(void)showSideScrollViewSelector;
-(void)hideSideScrollViewSelector;
-(void)previewFacePaintDesign;

#pragma mark Delegates
#pragma mark --NFScrollableBenchView
-(void)benchView:(NFBenchView *)benchView didSelectBenchItemView:(NFBenchItemView *)benchItemView;

#pragma mark --NFDraggableView
-(void)draggableViewDidBeginDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)draggableViewDidContinueDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)draggableViewDidEndDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;


@end
