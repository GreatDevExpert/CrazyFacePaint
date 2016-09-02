//
//  MakeupViewController.m
//  KidsFacePaint
//
//  Created by William Locke on 10/28/13.
//  Copyright (c) 2013 Ninjafish Studios. All rights reserved.
//

#import "FacepaintViewController.h"
#import "ScrollableBenchView.h"
#import "NFCharacterView.h"
#import "NFGameViewController.h"
#import "NFScrollableBenchView.h"
#import "NFBenchViewObject.h"
#import "NFViewController+scrollableBenchViewHandlers.h"
#import "NFViewController+scratchableViewHandlers.h"
#import "NFViewController+soundHandlers.h"
#import "MakeUpViewController.h"
#import "NFViewController+characterViewHandlers.h"

#if __has_include("DVAdKit.h")
#import "DVAdKitMoreApps.h"
#import "DVInteractiveAdManager.h"
#import "DVInteractiveAd.h"
#endif


@interface FacepaintViewController ()<NFScrollableBenchViewDelegate, NFCharacterViewDelegate, NFControlButtonStripViewDelegate, NFProductDisplayerViewDelegate, NFDraggableViewDelegate, NFScrollViewSelectorDelegate>{
}

@end

@implementation FacepaintViewController

- (id)initWithNib
{
    self = [super initWithNib];
    if (self) {
        
        self.applicationWindow = [[[UIApplication sharedApplication] delegate] window];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.layoutComponent = [[ViewControllerComponent alloc] initWithViewController:self];
    
    [self layout];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




#pragma mark Layout
-(void)layout{
    
    [super layout];
    
    self.currentFacepaintItem = @"facepaint1";
    self.currentTheme = @"christmas";
    
    [self layoutCharacter];
    
    [self layoutScrollableBenchView];
    [self.scrollableBenchView previewScrollView:nil shouldOnlyPreviewOnce:NO];
    
    [self layoutButtons];
    
    [self layoutScrollViewSelector];
    [self hideScrollViewSelector];
    
    [self layoutUnlockedThemeButton];
    
    
    self.draggableFacePaintRemover.delegate = self;
    self.draggableFacePaintRemover.shouldFloatBackToOriginalFrameUponTouchedEnded = YES;
}

-(void)layoutButtons{
    [super layoutButtons];
    
    _verticalControlButtonStripView.controlButtonNames = @[@"shared-buttons-back", @"activities-facepaint-buttons-themes-christmas", @"activities-facepaint-buttons-themes-frozen", @"activities-facepaint-buttons-themes-santa", @"activities-facepaint-buttons-themes-snowman", @"shared-buttons-activities-make_up"];
    
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        _verticalControlButtonStripView.spacing = CGSizeMake(0,0);
    }else{
        _verticalControlButtonStripView.spacing = CGSizeMake(0,0);
    }
    
    _verticalControlButtonStripView.itemSize = CGSizeMake(NFGeometryUniversalDistance(50), NFGeometryUniversalDistance(50));
    
    
    [_verticalControlButtonStripView layout];
    _verticalControlButtonStripView.delegate = self;
    [self.view addSubview:_verticalControlButtonStripView];
    _verticalControlButtonStripView.backgroundColor = [UIColor clearColor];
    
    
    _horizontalControlButtonStripView.controlButtonNames = @[@"shared-buttons-back", @"activities-facepaint-buttons-themes-christmas", @"activities-facepaint-buttons-themes-frozen", @"activities-facepaint-buttons-themes-santa", @"activities-facepaint-buttons-themes-snowman"];
    _horizontalControlButtonStripView.spacing = CGSizeMake(-6,0);
    _horizontalControlButtonStripView.direction = NFDirectionMake(1, 0);
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        _horizontalControlButtonStripView.itemSize = CGSizeMake(110, 110);
        _horizontalControlButtonStripView.spacing = CGSizeMake(0, 0);
    }else{
        _horizontalControlButtonStripView.itemSize = CGSizeMake(50,50);
    }
    
    
    [_horizontalControlButtonStripView layout];
    _horizontalControlButtonStripView.delegate = self;
    [self.view addSubview:_horizontalControlButtonStripView];
    _horizontalControlButtonStripView.backgroundColor = [UIColor clearColor];
    
    
}

-(void)layoutScrollViewSelector{
    
    self.scrollViewSelector.originalFrame = self.scrollViewSelector.frame;
    ((NFImageView *)_scrollViewSelector.backgroundImageView).originalFrame = ((NFImageView *)_scrollViewSelector.backgroundImageView).frame;
    
    self.scrollViewSelector.scrollView.frame = CGRectMake(self.scrollViewSelector.frame.origin.x, self.scrollViewSelector.frame.origin.y, self.scrollViewSelector.frame.size.width, self.scrollViewSelector.frame.size.height);
    self.scrollViewSelector.itemSize = CGSizeMake(self.scrollViewSelector.frame.size.width, self.scrollViewSelector.frame.size.width);
    
}

-(void)layoutUnlockedThemeButton{
    self.unlockThemeButton.frame = CGRectMake(_verticalControlButtonStripView.frame.origin.x + _verticalControlButtonStripView.frame.size.width, _verticalControlButtonStripView.frame.origin.y, _verticalControlButtonStripView.itemSize.width, _verticalControlButtonStripView.itemSize.height);
    
    self.unlockThemeButton.frame = CGRectMake(_verticalControlButtonStripView.frame.origin.x + _verticalControlButtonStripView.frame.size.width, _verticalControlButtonStripView.frame.origin.y, _verticalControlButtonStripView.itemSize.width * 1.1, _verticalControlButtonStripView.itemSize.height * 1.2);
    
    [self presentUnlockThemeButton];
}

-(void)presentUnlockThemeButton{
    NSString *lockedThemeButtonImageName = [@"" stringByAppendingFormat:@"activities-facepaint-buttons-themes_locked-%@", self.currentTheme];
    
    [self.layoutComponent presentUnlockThemeButtonWithImageName:lockedThemeButtonImageName productId:[self productIdForTheme:self.currentTheme]];
}


#pragma mark -- Character
-(void)layoutCharacter{
    [super layoutCharacter];
    
    for (UIImageView *imageView in self.characterView.imageViews) {
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
    
    [self updateCharacterIdentifierOrderWithNormalLayerOrder:@[@"facepaint", @"hairs"]];
}

-(NSString *)clothingImagesBaseFolderKeyPath{
    
    return @"activities.dress_up.clothing";
}

-(NSString *)characterImagesBaseFolderKeyPath{
    return @"shared.characters";
}

-(NSArray *)characterViewIdentifiers{
    NSMutableArray *characterViewIdentifiers =  [[NSMutableArray alloc] initWithArray:[super characterViewIdentifiers]];
//    [characterViewIdentifiers addObject:@"facepaint"];
    [characterViewIdentifiers insertObject:@"facepaint" atIndex:1];


    [characterViewIdentifiers addObjectsFromArray:@[ @"outfits", @"glasses", @"hairs", @"hats" ]];
    
    return characterViewIdentifiers;
}


-(NSString *)baseFolderKeyPath{
    return @"activities.facepaint";
}

-(void)switchTheme:(NSString *)themeIdentifier{
    self.currentTheme = themeIdentifier;
    
    [self layoutScrollableBenchView];
    [self.scrollableBenchView updateArrowButtons];
    
    [self presentUnlockThemeButton];

    [self displayMoreAppsButtonRandomly];
    
    [self.layoutComponent showTitleForTheme:themeIdentifier];
    
    [self hideScrollViewSelector];
}


#pragma mark More Games
-(void)displayMoreAppsButtonRandomly{
#if __has_include("DVAdKit.h")
    if([[DVAdKitMoreApps sharedInstance] moreAppsLoaded]){
        if([[DVAdKitMoreApps sharedInstance] moreAppsButton]){
            [[[DVAdKitMoreApps sharedInstance] moreAppsButton].superview addSubview:[[DVAdKitMoreApps sharedInstance] moreAppsButton]];
        }
        int showOnZero = arc4random() % ([DVAdKitMoreApps sharedInstance].impressionCount + 1);
        if (showOnZero == 0) {
            [[DVAdKitMoreApps sharedInstance] displayMoreAppsButtonWithImageName:@"home-buttons-more_games" action:0];
        }
    }
#endif

}


#pragma mark Scrollable Bench

-(void)layoutScrollableBenchView{
    
    NSMutableArray *benchViewObjects = [[NSMutableArray alloc] init];
    NFBenchViewObject *benchViewObject;
    NFBenchItemViewObject *benchItemViewObject;
    
    NSString *makeupItemsKeyPath = [self keyPathForCurrentFacepaintThemeDictionary];

    for(NSArray *benchItemIdentifiers in [self scrollableBenchViewIdentifiers]){
        benchViewObject = [[NFBenchViewObject alloc] init];
        benchViewObject.benchItemViewObjects = [[NSMutableArray alloc] init];
        
        for(NSString *identifier in benchItemIdentifiers){
            benchItemViewObject = nil;
            benchViewObject.identifier = identifier;
            
            BOOL isIndividualBenchItem = [self isBenchItemIndividual:identifier];
            
            if(isIndividualBenchItem){
                
                NSString *benchItemKeyPath = [self benchItemKeyPathForIdentifier:identifier];
                
                NSString *benchItemImageName = [self.imagesDictionary valueForKeyPath:benchItemKeyPath];
                
                NSString *appliersKeyPath = [@"" stringByAppendingFormat:@"%@.%@.appliers", makeupItemsKeyPath, identifier];
                NSArray *applierImageNames = [self.imagesDictionary valueForKeyPath:appliersKeyPath];
                BOOL useApplierForBenchItem = NO;
                if(applierImageNames){
                    for(NFBenchItemViewObject *tmpBenchItemViewObject in benchViewObject.benchItemViewObjects){
                        if([tmpBenchItemViewObject.identifier isEqualToString:identifier]){
                            useApplierForBenchItem = YES;
                            benchItemImageName = [applierImageNames firstObject];
                            break;
                        }
                    }
                }
                
                benchItemViewObject = [self benchItemViewObjectWithImageName:benchItemImageName withIdentifier:identifier];
                
                benchItemViewObject.rotateOnDragAngle = [self rotateOnDragAngleForIdentifier:identifier];
                
                if(!benchItemImageName){
                    NSLog(@"WARNING: bench item image name is null for identifier: %@", identifier);
                }
                
                NSString *activeItemKeyPath = [@"" stringByAppendingFormat:@"%@.%@.active", makeupItemsKeyPath, identifier];
                id activeItem = [self.imagesDictionary valueForKeyPath:activeItemKeyPath];
                if(activeItem){
                    if([activeItem isKindOfClass:[NSArray class]] && [activeItem count] > 0){
                        benchItemViewObject.draggingImageName = [activeItem objectAtIndex:0];
                    }else if([activeItem isKindOfClass:[NSString class]]){
                        benchItemViewObject.draggingImageName = activeItem;
                    }
                }
                benchItemViewObject.clickable = [self isBenchItemClickable:identifier];
                
                // This needs to be improved but basically supporting old folder structure
                // where eye_liner and eye_shadow have applier bench item and container bench_item in same
                // folder. Applier and container both have same identifier right now so we differentiate
                // between them by seeing which one is using applier images.
                if (useApplierForBenchItem) {
                    benchItemViewObject.clickable = NO;
                }
                
                [benchViewObject.benchItemViewObjects addObject:benchItemViewObject];
            }else{
                
                NSString *appliersKeyPath = [@"" stringByAppendingFormat:@"%@.%@.appliers", makeupItemsKeyPath, identifier];
                NSArray *applierImageNames = [self.imagesDictionary valueForKeyPath:appliersKeyPath];
                
                NSString *accessoryKeyPath = [@"" stringByAppendingFormat:@"%@.%@.accessory", makeupItemsKeyPath, identifier];
                if(![self.imagesDictionary valueForKeyPath:accessoryKeyPath]){
                    accessoryKeyPath = [@"" stringByAppendingFormat:@"%@.%@.cap", makeupItemsKeyPath, identifier];
                }
                NSString *accessoryImageName = [self.imagesDictionary valueForKeyPath:accessoryKeyPath];
                
                CGPoint accessoryImageViewOffset = [self accessoryImageViewOffsetForBenchItemIdentifier:identifier];
                
                benchViewObject = [self benchViewObjectWithImageNames:applierImageNames withIdentifier:identifier rotateOnDragAngle:[self rotateOnDragAngleForIdentifier:identifier] accessoryImageName:accessoryImageName accessoryImageViewOffset:accessoryImageViewOffset];
                
                benchViewObject.benchItemViewObjectTopLeftOffset = CGPointMake(self.scrollableBenchView.frame.size.width * 0.05, self.scrollableBenchView.frame.size.height * 0.05);
                benchViewObject.benchItemViewObjectBottomRightOffset = CGPointMake(self.scrollableBenchView.frame.size.width * 0.05, 0.0);
                
                
                NSString *containersKeyPath = [@"" stringByAppendingFormat:@"%@.%@.containers", makeupItemsKeyPath, identifier];
                NSArray *containerImageNames = [self.imagesDictionary valueForKeyPath:containersKeyPath];

                if (containerImageNames) {
                    for(NFBenchItemViewObject *benchItemViewObject in benchViewObject.benchItemViewObjects){
                        int index = [benchViewObject.benchItemViewObjects indexOfObject:benchItemViewObject];
                        NSString *containerImageName = nil;
                        if(index < [containerImageNames count]){
                            containerImageName = [containerImageNames objectAtIndex:index];
                        }
                        benchItemViewObject.accessoryImageName = containerImageName;
                        benchItemViewObject.positionAccessoryBelowBenchItemView = YES;
                    }
                }
                
            }
        }
        
        benchViewObject.benchItemViewObjectBottomRightOffset = [self bottomRightOffsetForBenchViewObject:benchViewObject];
        benchViewObject.benchItemViewObjectTopLeftOffset = [self topLeftOffsetForBenchViewObject:benchViewObject];
        
        [benchViewObjects addObject:benchViewObject];
    }
    
    
    NSString *benchImageName = [self benchImageName];
    
    self.scrollableBenchView = [self layoutScrollableBenchView:self.scrollableBenchView withBenchViewObjects:benchViewObjects andBackgroundImageName:benchImageName];
    
    [self.scrollableBenchView layout];
    // Lock any facepaint items that are meant to be locked
    for (NFBenchView *benchView in self.scrollableBenchView.benchViews){
        benchView.lockImageName = [@"" stringByAppendingFormat:@"shared-locks-%@", self.currentTheme];
    }
    [self.scrollableBenchView layout];
    
    self.scrollableBenchView.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.scrollableBenchView.backgroundImageView.frame = CGRectOffset(self.scrollableBenchView.backgroundImageView.frame, 0, self.scrollableBenchView.frame.size.height * 0.5);
    
    
    // Lock any facepaint items that are meant to be locked
    for (NFBenchView *benchView in self.scrollableBenchView.benchViews){
        
        for (NFBenchItemView *benchItemView in benchView.benchItemViews){
            
            // Identify any bench item views with an identifier that has the word 'facepaint'
            // in it as a facepaint item, and lock any that have a corresponding product (that has not been purchased yet
            if ([benchItemView.identifier rangeOfString:@"facepaint"].location != NSNotFound) {
                benchItemView.productId = [self productIdForBenchItemView:benchItemView];
                if (![self.store productHasAlreadyBeenBought:benchItemView.productId]) {
                    [benchItemView lock];
                }
            }
            
            if ([benchItemView.identifier isEqualToString:@"brush"]) {
                benchItemView.frame = CGRectOffset(benchItemView.frame, -benchItemView.frame.size.width * 0.2, -benchItemView.frame.size.height * 0.3);
                benchItemView.originalFrame = benchItemView.frame;
                if (![self brushTipImageViewForBenchItemView:benchItemView]) {
                    NFImageView *brushTipImageView = [NFImageView new];
                    brushTipImageView.frame = CGRectMake(0, 0, benchItemView.frame.size.width, benchItemView.frame.size.height);
                    brushTipImageView.image = [NFImage imageForName:@"activities-facepaint-brushes-christmas-tip"];
                    brushTipImageView.identifier = @"brush_tip";
                    brushTipImageView.contentMode = benchItemView.imageView.contentMode;
                    [benchItemView addSubview:brushTipImageView];
                }
            }
        }
    }
    
    [self.view insertSubview:self.scrollableBenchView aboveSubview:self.characterView];
    self.scrollableBenchView.delegate = self;

    
    
    [self.scrollableBenchView addSubview:self.scrollableBenchView.rightArrowButton];
    [self.scrollableBenchView addSubview:self.scrollableBenchView.leftArrowButton];
    [self.scrollableBenchView updateArrowButtons];
    
}

-(NSString *)benchImageName{
    return [self.imagesDictionary valueForKeyPath:[@"" stringByAppendingFormat:@"activities.facepaint.themes.%@.bench", self.currentTheme]];
}

-(NFImageView *)brushTipImageViewForBenchItemView:(NFBenchItemView *)benchItemView{
    for(NFImageView *imageView in benchItemView.subviews){
        if ([imageView isKindOfClass:[NFImageView class]] && [imageView.identifier isEqualToString:@"brush_tip"]) {
            return imageView;
        }
    }
    return nil;
}

-(void)updateScrollableBenchView{
    for(NFBenchView *benchView in self.scrollableBenchView.benchViews){
        [self updateProductPropertiesForProductDisplayerView:benchView];
    }
    [self.scrollableBenchView layout];

    [self.scrollableBenchView addSubview:self.scrollableBenchView.rightArrowButton];
    [self.scrollableBenchView addSubview:self.scrollableBenchView.leftArrowButton];
    [self.scrollableBenchView updateArrowButtons];
}

-(NSArray *)scrollableBenchViewIdentifiers{
    //NSAssert(NO, @"Subclass this function to specify bench items and grouping");
    // Example grouping
    return @[ @[@"glasses", @"hairs", @"hats", @"outfits"], @[@"facepaint1", @"facepaint2", @"facepaint3", @"facepaint4", @"brush"], @[@"facepaint5", @"facepaint6", @"facepaint7", @"facepaint8", @"brush"] ];
}

-(BOOL)isBenchItemClickable:(NSString *)benchItemIdentifier{
    // Possible reverse this and have a draggable list.
    NSArray *draggableItems = @[@"brush"];
    if([draggableItems indexOfObject:benchItemIdentifier] != NSNotFound){
        return NO;
    }
    return YES;
}

-(CGPoint)topLeftOffsetForBenchViewObject:(NFBenchViewObject *)benchViewObject{
    if([benchViewObject.identifier rangeOfString:@"lipstick"].location != NSNotFound){
        return CGPointMake(self.scrollableBenchView.frame.size.width * 0.05, self.scrollableBenchView.frame.size.height * 0.05);
    }else if([benchViewObject.identifier rangeOfString:@"powder"].location != NSNotFound){
        return CGPointMake(self.scrollableBenchView.frame.size.width * 0.05, 0.0);
    }else if([benchViewObject.identifier rangeOfString:@"mascara"].location != NSNotFound){
        return CGPointMake(self.scrollableBenchView.frame.size.width * 0.05, 0);
    }
    return CGPointZero;
}

-(CGPoint)bottomRightOffsetForBenchViewObject:(NFBenchViewObject *)benchViewObject{
    NSMutableArray *benchItemViewObjectIdentifiers = [[NSMutableArray alloc] init];
    for(NFBenchItemViewObject *benchItemViewObject in benchViewObject.benchItemViewObjects){
        [benchItemViewObjectIdentifiers addObject:benchItemViewObject.identifier];
    }
    
    if ([benchItemViewObjectIdentifiers indexOfObject:@"hairs"] != NSNotFound){
        return CGPointMake(self.scrollableBenchView.frame.size.width * 0.0, self.scrollableBenchView.frame.size.height * 0.1);
    }else if ([benchItemViewObjectIdentifiers indexOfObject:@"earrings"] != NSNotFound){
        return CGPointMake(self.scrollableBenchView.frame.size.width * 0.0, self.scrollableBenchView.frame.size.height * 0.1);
    }else if ([benchItemViewObjectIdentifiers indexOfObject:@"eye_liner"] != NSNotFound){
        return CGPointMake(self.scrollableBenchView.frame.size.width * 0.0, self.scrollableBenchView.frame.size.height * 0.1);
    }
    
    if([benchViewObject.identifier rangeOfString:@"lipstick"].location != NSNotFound){
        return CGPointMake(self.scrollableBenchView.frame.size.width * 0.05, 0.0);
    }else if([benchViewObject.identifier rangeOfString:@"powder"].location != NSNotFound){
        return CGPointMake(self.scrollableBenchView.frame.size.width * 0.05, self.scrollableBenchView.frame.size.height * 0.15);
    }else if([benchViewObject.identifier rangeOfString:@"mascara"].location != NSNotFound){
        return CGPointMake(self.scrollableBenchView.frame.size.width * 0.05, self.scrollableBenchView.frame.size.height * 0.2);
    }
    return CGPointZero;
}


-(CGPoint)accessoryImageViewOffsetForBenchItemIdentifier:(NSString *)benchItemIdentifier{
    if([benchItemIdentifier rangeOfString:@"lipstick"].location != NSNotFound){
        return CGPointMake(NFGeometryUniversalDistance(14), NFGeometryUniversalDistance(50));
    }else if([benchItemIdentifier rangeOfString:@"powder"].location != NSNotFound){
        return CGPointMake(NFGeometryUniversalDistance(0), NFGeometryUniversalDistance(-25));
    }
    return CGPointZero;
}

-(BOOL)isBenchItemIndividual:(NSString *)benchItemIdentifier{
    NSArray *benchItemsWithMultipleItems = @[@"lipstick", @"mascara", @"powder"];
    for(NSString *benchItemWithMultipleItems in benchItemsWithMultipleItems){
        if([benchItemIdentifier rangeOfString:benchItemWithMultipleItems].location != NSNotFound){
            return NO;
        }
    }
    return YES;
}

-(NSString *)keyPathForCurrentFacepaintThemeDictionary{
    NSArray *possibleKeyPaths = @[ [@"" stringByAppendingFormat:@"%@.themes.%@.make_up", self.baseFolderKeyPath, self.currentTheme], [@"" stringByAppendingFormat:@"%@.make_up", self.baseFolderKeyPath], [@"" stringByAppendingFormat:@"%@.themes.%@", self.baseFolderKeyPath, self.currentTheme] ];
    
    for (NSString *keyPath in possibleKeyPaths){
        if([self.imagesDictionary valueForKeyPath:keyPath]){
            return keyPath;
        }
    }
    
    return [@"" stringByAppendingFormat:@"%@.make_up", self.baseFolderKeyPath];
}

-(float)rotateOnDragAngleForIdentifier:(NSString *)benchItemIdentifier{
    if ([benchItemIdentifier isEqualToString:@"brush"]) {
        return -M_PI * 0.3;
    }
    return 0;
}

-(NSString *)productIdForBenchView:(NFBenchView *)benchView{
    NSString *productId = [@"" stringByAppendingFormat:@"%@.unlock_%@_%@", [[NSBundle mainBundle] bundleIdentifier], self.currentTheme, benchView.identifier];
    
    return productId;
}

-(NSString *)productIdForBenchItemView:(NFBenchItemView *)benchItemView{
    NSString *productId = [@"" stringByAppendingFormat:@"%@.unlock_%@_%@", [[NSBundle mainBundle] bundleIdentifier], self.currentTheme, benchItemView.identifier];
    
    return productId;
}

-(NSString *)benchItemKeyPathForIdentifier:(NSString *)identifier{
    NSString *makeupItemsKeyPath = [self keyPathForCurrentFacepaintThemeDictionary];
    NSString *benchItemKeyPath = [@"" stringByAppendingFormat:@"%@.%@.bench_item", makeupItemsKeyPath, identifier];
    return benchItemKeyPath;
}

-(NSString *)thumbsKeyPathForIdentifier:(NSString *)identifier{
    NSString *thumbsKeyPath = [@"" stringByAppendingFormat:@"activities.make_up.make_up.%@.thumbs", identifier];
    if (self.currentTheme) {
        thumbsKeyPath = [@"" stringByAppendingFormat:@"%@.themes.%@.make_up.%@.thumbs", self.baseFolderKeyPath, self.currentTheme, identifier];
    }
    
    return thumbsKeyPath;
}

-(NFBenchItemView *)facepaintBrushForVisibleBenchView{
    NFBenchView *currentBenchView = [self.scrollableBenchView.benchViews objectAtIndex:self.scrollableBenchView.page];
    NFBenchItemView *brushBenchItemView;
    for (NFBenchItemView *benchItemView in currentBenchView.benchItemViews){
        if ([benchItemView.identifier isEqualToString:@"brush"]) {
            brushBenchItemView = benchItemView;
            break;
        }
    }
    return brushBenchItemView;
}

#pragma mark  Scroll View Selector
-(void)hideScrollViewSelector{
    if(_scrollViewSelector.frame.origin.x != _scrollViewSelector.originalFrame.origin.x){
        return;
    }
    
    [UIView animateWithDuration:kViewControllerDefaultAnimationDuration animations:^{
        _scrollViewSelector.backgroundImageView.frame = CGRectMake(self.view.frame.size.width, _scrollViewSelector.backgroundImageView.frame.origin.y, _scrollViewSelector.backgroundImageView.frame.size.width, _scrollViewSelector.backgroundImageView.frame.size.height);
        
        _scrollViewSelector.frame = CGRectMake(self.view.frame.size.width, _scrollViewSelector.frame.origin.y, _scrollViewSelector.frame.size.width, _scrollViewSelector.frame.size.height);
    }completion:^(BOOL finished){
        
    }];
}

-(void)showScrollViewSelector{
    _scrollViewSelector.hidden = NO;
    _scrollViewSelector.backgroundImageView.hidden = NO;
    
    [self.view addSubview:_scrollViewSelector.backgroundImageView];
    [self.view addSubview:_scrollViewSelector];
    
    if(_scrollViewSelector.frame.origin.x == _scrollViewSelector.originalFrame.origin.x){
        return;
    }
    
    _scrollViewSelector.scrollView.layer.masksToBounds = YES;
    _scrollViewSelector.scrollView.layer.cornerRadius = NFGeometryUniversalDistance(7);
    
    _scrollViewSelector.backgroundImageView.frame = CGRectMake(self.view.frame.size.width, _scrollViewSelector.backgroundImageView.frame.origin.y, _scrollViewSelector.backgroundImageView.frame.size.width, _scrollViewSelector.backgroundImageView.frame.size.height);
    
    
    _scrollViewSelector.frame = CGRectMake(self.view.frame.size.width, _scrollViewSelector.frame.origin.y, _scrollViewSelector.frame.size.width, _scrollViewSelector.frame.size.height);
    

    [UIView animateWithDuration:kViewControllerDefaultAnimationDuration animations:^{
        _scrollViewSelector.frame = _scrollViewSelector.originalFrame;
        _scrollViewSelector.backgroundImageView.frame = ((NFImageView *)_scrollViewSelector.backgroundImageView).originalFrame;
    }completion:^(BOOL finished){
        
    }];
    
}



#pragma mark Facepaint Designs
-(void)presentFacePaintDesignForBenchItemView:(NFBenchItemView *)benchItemView{
    static BOOL blockPresentFacePaintDesignForBenchItemView;
    if(blockPresentFacePaintDesignForBenchItemView){
        return;
    }
    
    blockPresentFacePaintDesignForBenchItemView = YES;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.2 * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
        blockPresentFacePaintDesignForBenchItemView = NO;
    });
    
//    _currentBenchItemView = benchItemView;
    
    UIView *previewView = [[UIView alloc] initWithFrame:NFGeometryCGRectZeroedOrigin(self.characterView.frame)];
//    if([[UIScreen mainScreen] bounds].size.height == 568){
//        previewView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
//    }

    NSString *keyPath = [@"" stringByAppendingFormat:@"%@.%@.items", [self keyPathForCurrentFacepaintThemeDictionary], benchItemView.identifier];
    
    
    NSArray *items = [NFJsonPath valueForJsonPath:keyPath inObject:self.imagesDictionary];

    for(NSString *item in items){
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:NFGeometryCGRectZeroedOrigin(previewView.frame)];
        imageView.image = [NFImage imageForName:item];
        //        imageView.backgroundColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:0.1];
        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [previewView addSubview:imageView];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
    }
    
    [self.characterView addSubview:previewView];
    
    [NFAnimation showViewWithSpinAndGrow:previewView duration:0.5 completionHandler:^(BOOL finished){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC), dispatch_get_current_queue(), ^{
            if([NFAnimation respondsToSelector:@selector(hideViewWithSpinAndShrink:duration:completionHandler:)]){
                [NFAnimation hideViewWithSpinAndShrink:previewView duration:0.5 completionHandler:^(BOOL finished){
                    
                }];
            }else{
                [previewView removeFromSuperview];
            }
        });
    }];
    
}

-(void)presentThumbsForBenchItemView:(NFBenchItemView *)benchItemView{
    NSString *keyPath = [@"" stringByAppendingFormat:@"%@.%@.items", [self keyPathForCurrentFacepaintThemeDictionary], benchItemView.identifier];
    NSString *thumbsKeyPath = [keyPath stringByReplacingOccurrencesOfString:@".items" withString:@".thumbs"];
    
    NSString *productId = [@"" stringByAppendingFormat:@"%@.unlock_%@_%@", [[NSBundle mainBundle] bundleIdentifier], self.currentTheme, benchItemView.identifier];
    _scrollViewSelector.productId = productId;
    [self updateProductPropertiesForProductDisplayerView:_scrollViewSelector];
    
    NFProduct *product = [self.store productWithProductId:productId];
    if (product.watchToUnlock) {
        _scrollViewSelector.lockImageName = @"shared-watch_to_unlock";
    }else{
        _scrollViewSelector.lockImageName = @"shared-locks-christmas";
    }
    
    _scrollViewSelector.items = [NFJsonPath valueForJsonPath:thumbsKeyPath inObject:self.imagesDictionary];
    [_scrollViewSelector layout];
    [self showScrollViewSelector];
    
    _scrollViewSelector.scrollView.contentOffset = CGPointZero;
}

#pragma mark Scratchable View
-(NFScratchToRevealView *)scratchToRevealViewForBenchItemView:(NFBenchItemView *)benchItemView{

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.frame];
    
    NSString *keyPath = [@"" stringByAppendingFormat:@"%@.%@.items", [self keyPathForCurrentFacepaintThemeDictionary], self.currentFacepaintItem];
    NFImageView *makeupImageView = [self.characterView imageViewWithIdentifier:@"facepaint"];
    [self flattenView:makeupImageView];
    
    NSString *imageName = @"";
    NSArray *imageNames = [NFJsonPath valueForJsonPath:keyPath inObject:self.imagesDictionary];
    
    int index = benchItemView.tag;
    if(index < [imageNames count]){
        imageName = [imageNames objectAtIndex:index];
    }

    imageView.image = [NFImage imageForName:imageName];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.image = [NFImage imageFromView:imageView];

    CGRect percentageFrame;
    percentageFrame = CGRectMake(0.1, 0.2, 0.8, 0.65);
    imageView.image = [NFImage crop:imageView.image toPercentageFrame:percentageFrame];
    imageView.frame = CGRectMake(imageView.frame.size.width * percentageFrame.origin.x, imageView.frame.size.height * percentageFrame.origin.y, imageView.frame.size.width * percentageFrame.size.width, imageView.frame.size.height * percentageFrame.size.height);
    [makeupImageView addSubview:imageView];
    
    
    NFScratchToRevealView *scratchToRevealView;
    scratchToRevealView = [NFScratchToRevealView makeScratchable:imageView mode:NFScratchToRevealViewModeMasking];
    scratchToRevealView.identifier = benchItemView.benchView.scrollableBenchView.identifier;
    scratchToRevealView.scratchDiameter = NFGeometryUniversalDistance(10);
    scratchToRevealView.tag = index;
    
    return scratchToRevealView;
}

-(void)flattenView:(NFImageView *)imageView{
    
    UIImage *image = [NFImage imageFromView:imageView];
    UIImageView *flattenedImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageView.frame.size.width, imageView.frame.size.height)];
    flattenedImageView.image = image;
    
    for(UIView *subview in imageView.subviews){
        [subview removeFromSuperview];
    }
    [imageView addSubview:flattenedImageView];
    
}

#pragma mark IBActions
-(IBAction)unlockThemeButtonPressed:(id)sender{

    NSString *productId = [self productIdForTheme:self.currentTheme];
    NFProduct *product = [self.store productWithProductId:productId];
    [self purchase:product completionHandler:^(BOOL success) {
        if (success) {
            // Can create a didPurchase event to handle this kinda stuff.
            [self didCompletePurchase];
        }
    }];
}

-(IBAction)backButtonPressed:(id)sender{
    self.scrollableBenchView.clipsToBounds = YES;
    
    [super backButtonPressed:sender];
}

#pragma mark Purchases/Products
-(NSString *)productIdForTheme:(NSString *)theme{
    return [@"" stringByAppendingFormat:@"%@.unlock_%@_pack", [[NSBundle mainBundle] bundleIdentifier], theme];
}

-(void)didCompletePurchase{
    [self updateProductPropertiesForProductDisplayerView:self.scrollViewSelector];
    [self.scrollViewSelector layout];
    
    for(NFBenchView *benchView in self.scrollableBenchView.benchViews){
        
        [self updateProductPropertiesForProductDisplayerView:benchView];
        for(NFBenchItemView *benchItemView in benchView.benchItemViews){
            if ([benchItemView locked]) {
                [benchItemView lock];
            }else{
                [benchItemView unlock];
            }
        }
    }
    [self.scrollableBenchView layout];
    [self.scrollableBenchView addSubview:self.scrollableBenchView.leftArrowButton];
    [self.scrollableBenchView addSubview:self.scrollableBenchView.rightArrowButton];
    [self.scrollableBenchView updateArrowButtons];
    
    [self presentUnlockThemeButton];
    
}

#pragma mark Geometry
-(CGPoint)correctedTouchPointForDraggableView:(NFBenchItemView *)benchItemView touches:(NSSet *)touches touchResponderView:(UIView *)touchResponderView {
    UITouch *touch = [touches anyObject];
    CGPoint correctedPoint = [touch locationInView:touchResponderView];
    
    
    correctedPoint = CGPointMake(correctedPoint.x - benchItemView.frame.size.width * 0.35, correctedPoint.y - benchItemView.frame.size.height * 0.7);

    
#ifdef DEBUG
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(correctedPoint.x, correctedPoint.y, 2,2);
    view.backgroundColor = [UIColor orangeColor];
    [touchResponderView addSubview:view];
#endif
    
    return correctedPoint;
}


#pragma mark Delegates
#pragma mark <NFScrollableBenchViewDelegate>
-(void)benchView:(NFBenchView *)benchView didSelectBenchItemView:(NFBenchItemView *)benchItemView{
    
    // Check if bench item view pressed is a facepaint item
    if ([benchItemView.identifier rangeOfString:@"facepaint"].location != NSNotFound) {
        
        if (benchItemView.locked) {
            NFProduct *product = [self.store productWithProductId:benchItemView.productId];
            if (product.isPartOfPack) {
                product = [self.store productPackThatContainsProduct:product];
            }
            [self purchase:product completionHandler:^(BOOL success) {
                int currentPage = self.scrollableBenchView.page;
                [self layoutScrollableBenchView];
                [self.scrollableBenchView scrollToPage:currentPage animated:NO];
                self.scrollableBenchView.page = currentPage;
                [self.scrollableBenchView.pageControl setCurrentPage:self.scrollableBenchView.page];
                [self.scrollableBenchView updateArrowButtons];
            }];
            return;
        }
        
        self.currentFacepaintItem = benchItemView.identifier;
        [self presentFacePaintDesignForBenchItemView:benchItemView];
        [self presentThumbsForBenchItemView:benchItemView];
        
        [_scrollViewSelector setDelegate:(self.retainedBlock = [NFProductDisplayerViewBlockDelegate blockDelegateWithSelectedItemBlock:^(id<NFProductDisplayerView> productDisplayerView, id sender ){
            NFBenchItemView *brushBenchItemView = [self facepaintBrushForVisibleBenchView];
            brushBenchItemView.tag = [sender tag];
            NFImageView *brushTip = [self brushTipImageViewForBenchItemView:brushBenchItemView];
            UIImage *image = [NFImage imageForName:[_scrollViewSelector.items objectAtIndex:[sender tag]]];
            image = [NFImage crop:image toPercentageFrame:CGRectMake(0.2, 0.2, 0.4, 0.4)];
            brushTip.image = [NFImage changeColor:[NFImage imageForName:@"activities-facepaint-brushes-christmas-tip"] colorSelected:[NFImage colorFromImage:image]];
            
        }])];
        
    }else{
        // Else treat as a clothing/accessory item such as glasses, dresses, hats etc.
        [self presentThumbsForBenchItemView:benchItemView];
        
        
        [_scrollViewSelector setDelegate:(self.retainedBlock = [NFProductDisplayerViewBlockDelegate blockDelegateWithSelectedItemBlock:^(id<NFProductDisplayerView> productDisplayerView, id sender ){
            
            [super productDisplayerView:productDisplayerView didSelectItem:sender completionHandler: ^(NFProduct *purchasedProduct, NFDownloader *downloader, NSError *error){
                if(purchasedProduct || downloader){

                }
                [self updateProductPropertiesForProductDisplayerView:productDisplayerView];
                [_scrollViewSelector layout];
                
                int currentPage = self.scrollableBenchView.page;
                [self layoutScrollableBenchView];
                [self.scrollableBenchView scrollToPage:currentPage animated:NO];
                self.scrollableBenchView.page = currentPage;
                [self.scrollableBenchView.pageControl setCurrentPage:self.scrollableBenchView.page];
                [self.scrollableBenchView updateArrowButtons];
                
            }];
            
            if(![productDisplayerView isSenderAvailable:sender]){
                return;
            }
            
            // [self playClickSoundWithIdentifier:benchItemView.identifier];
            NSString *itemsKeyPath = [@"" stringByAppendingFormat:@"%@.%@.items", [self keyPathForCurrentFacepaintThemeDictionary], benchItemView.identifier];
            NFImageView *imageView = [self.characterView imageViewWithIdentifier:benchItemView.identifier];
            NSArray *imageNames = [self.imagesDictionary valueForKeyPath:itemsKeyPath];
            NSString *imageName = [imageNames objectAtIndex:[sender tag]];
            
            imageView.image = [NFImage imageForName:imageName];
            
        }])];
        
        
    }
    
}

-(void)benchItemViewDidBeginDragging:(NFBenchItemView *)benchItemView touches:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if ([benchItemView.identifier isEqualToString:@"brush"]) {
        _scratchableFacepaintView = [self scratchToRevealViewForBenchItemView:benchItemView];
    }
    
    
}

-(void)benchItemViewDidContinueDragging:(NFBenchItemView *)benchItemView touches:(NSSet *)touches withEvent:(UIEvent *)event{
    
    if ([benchItemView.identifier isEqualToString:@"brush"]) {
        
        CGPoint point = [self correctedTouchPointForDraggableView:benchItemView touches:touches touchResponderView:_scratchableFacepaintView];
        [_scratchableFacepaintView handleDragToPoint:point updateMask:YES updateDisplayedImage:YES];
        
    }
    
}

-(void)benchItemViewDidEndDragging:(NFBenchItemView *)benchItemView touches:(NSSet *)touches withEvent:(UIEvent *)event{
    
    
}



#pragma mark <NFControlStripViewDelegate>
-(void)controlButtonPressed:(id)sender inControlButtonStripView:(NFControlButtonStripView *)controlButtonStripView{
    NSString *controlButtonImageName = [controlButtonStripView.controlButtonNames objectAtIndex:[sender tag]];
    
    if ([controlButtonImageName rangeOfString:@"back"].location != NSNotFound) {
        [self backButtonPressed:sender];
    }else if([controlButtonImageName rangeOfString:@"make_up"].location != NSNotFound){
        self.nextViewControllerClass = [MakeUpViewController class];
        [self presentNextActivityViewController];
    }else{
        
        NSArray *componentsArray = [controlButtonImageName componentsSeparatedByString:@"-"];
        NSString *themeIdentifier = [componentsArray lastObject];

        [self switchTheme:themeIdentifier];
           
    }
    
}




#pragma mark <NFDraggableViewDelegate>
-(void)draggableViewDidBeginDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self playLoopedSoundForObject:draggableView inFunction:_cmd];
    
    if(draggableView == self.draggableFacePaintRemover){
        
        NFImageView *makeupImageView = [self.characterView imageViewWithIdentifier:@"facepaint"];
        self.currentScratchableView = [self flattenAndMakeImageViewScratchable:makeupImageView scratchableWithMode:NFScratchToRevealViewModeErase];
        for(UIView *view in makeupImageView.subviews){
            [view removeFromSuperview];
        }
        [makeupImageView addSubview:self.currentScratchableView];
        [_scratchableFacepaintView reset];
        [makeupImageView addSubview:_scratchableFacepaintView];
        
    }
    
    
}

-(void)draggableViewDidContinueDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event{
    BOOL showGuide = NO;
#ifdef DEBUG
    showGuide = YES;
#endif
    
    
    

    CGPoint touchPoint = [[touches anyObject] locationInView:self.view];
    [self.currentScratchableView handleDragToPoint:touchPoint updateMask:YES updateDisplayedImage:YES];
    
}

-(void)draggableViewDidEndDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self stopLoopedSoundForObject:draggableView inFunction:_cmd];
    
}




#pragma mark Banner Ads
-(void)makeSpaceForBannerAd:(UIView *)bannerAdView animated:(BOOL)animated{
    _verticalControlButtonStripView.frame = CGRectMake(_verticalControlButtonStripView.frame.origin.x, bannerAdView.frame.size.height, _verticalControlButtonStripView.frame.size.width, _verticalControlButtonStripView.frame.size.height);
    
    self.unlockThemeButton.frame = CGRectMake(self.unlockThemeButton.frame.origin.x, bannerAdView.frame.size.height, self.unlockThemeButton.frame.size.width, self.unlockThemeButton.frame.size.height);
    
}


@end
