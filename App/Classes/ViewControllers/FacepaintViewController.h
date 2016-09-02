//
//  MakeupViewController.h
//  KidsFacePaint
//
//  Created by William Locke on 10/28/13.
//  Copyright (c) 2013 Ninjafish Studios. All rights reserved.
//

#import "ViewController.h"
#import "NFGameViewController.h"
#import "ViewControllerComponent.h"
@class ScrollableBenchView;
@class NFCharacterView;

@interface FacepaintViewController : NFGameViewController

@property (nonatomic, strong) id retainedBlock;
@property (nonatomic, strong) NFCharacterView *characterView;
@property (nonatomic, strong) IBOutlet NFScrollableBenchView *scrollableBenchView;
@property (nonatomic, strong) IBOutlet NFScrollViewSelector *scrollViewSelector;
@property (nonatomic, strong) NFScratchToRevealView *scratchableFacepaintView;
@property (nonatomic, copy) NSString *currentTheme;
@property (nonatomic, copy) NSString *currentFacepaintItem;
@property (nonatomic, strong) IBOutlet NFControlButtonStripView *verticalControlButtonStripView;
@property (nonatomic, strong) IBOutlet NFControlButtonStripView *horizontalControlButtonStripView;
@property (nonatomic, strong) ViewControllerComponent *layoutComponent;
@property (nonatomic, strong) IBOutlet UIButton *unlockThemeButton;

@property (nonatomic, strong) IBOutlet NFDraggableView *draggableFacePaintRemover;
@property (nonatomic, strong) NFScratchToRevealView *currentScratchableView;
@property CGPoint currentTouchPointOffset;


@end
