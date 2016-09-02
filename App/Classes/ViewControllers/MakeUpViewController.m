//
//  MakeupViewController.m
//  KidsFacePaint
//
//  Created by William Locke on 10/28/13.
//  Copyright (c) 2013 Ninjafish Studios. All rights reserved.
//

#import "MakeUpViewController.h"
#import "ScrollableBenchView.h"
#import "NFCharacterView.h"
#import "NFGameViewController.h"
#import "NFScrollableBenchView.h"
#import "NFBenchViewObject.h"
#import "NFViewController+scrollableBenchViewHandlers.h"
#import "NFViewController+scratchableViewHandlers.h"
#import "NFViewController+soundHandlers.h"
#import "FacepaintViewController.h"


#if __has_include("DVAdKit.h")
#import "DVAdKitMoreApps.h"
#import "DVInteractiveAdManager.h"
#import "DVInteractiveAd.h"
#endif

@interface MakeUpViewController ()<NFScrollableBenchViewDelegate, NFCharacterViewDelegate, NFControlButtonStripViewDelegate, NFProductDisplayerViewDelegate, NFDraggableViewDelegate, NFScrollViewSelectorDelegate>{
}

@end

@implementation MakeUpViewController

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
    self.currentTheme = @"sparkle";

    [super layout];
    
    [self layoutCharacter];
    
    [self layoutScrollableBenchView];
    
    [self layoutButtons];
    
    [self layoutUnlockedThemeButton];
    
}

-(void)layoutButtons{
    [super layoutButtons];
    
    _verticalControlButtonStripView.controlButtonNames = @[@"shared-buttons-back", @"activities-make_up-buttons-themes-sparkle", @"shared-buttons-activities-facepaint" ]; //, @"shared-buttons-choose_character"];
    
    
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
    
    
    _horizontalControlButtonStripView.controlButtonNames = @[@"shared-buttons-back", @"activities-make_up-buttons-themes-color", @"activities-make_up-buttons-themes-pink", @"activities-make_up-buttons-themes-purple", @"activities-make_up-buttons-themes-sparkle"];
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

-(void)layoutUnlockedThemeButton{
    self.unlockThemeButton.frame = CGRectMake(_verticalControlButtonStripView.frame.origin.x + _verticalControlButtonStripView.frame.size.width, _verticalControlButtonStripView.frame.origin.y, _verticalControlButtonStripView.itemSize.width, _verticalControlButtonStripView.itemSize.height);
    
    self.unlockThemeButton.frame = CGRectMake(_verticalControlButtonStripView.frame.origin.x + _verticalControlButtonStripView.frame.size.width, _verticalControlButtonStripView.frame.origin.y, _verticalControlButtonStripView.itemSize.width * 1.1, _verticalControlButtonStripView.itemSize.height * 1.2);
    
    [self presentUnlockThemeButton];
}

-(void)presentUnlockThemeButton{
    NSString *lockedThemeButtonImageName = [@"" stringByAppendingFormat:@"activities-make_up-buttons-themes_locked-%@", self.currentTheme];
    [self.layoutComponent presentUnlockThemeButtonWithImageName:lockedThemeButtonImageName productId:[self productIdForTheme:self.currentTheme]];
    
}

-(void)switchTheme:(NSString *)themeIdentifier{
    self.currentTheme = themeIdentifier;
    
    NSString *themeTitle = [@"" stringByAppendingFormat:@"%@%@", [[themeIdentifier substringToIndex:1] uppercaseString], [themeIdentifier substringFromIndex:1]];
    UILabel *titleLabel = [self showTitleWithText:themeTitle];
    titleLabel.font = [UIFont systemFontOfSize:NFGeometryUniversalDistance(50)];
    
    [self layoutScrollableBenchView];
    
    [self presentUnlockThemeButton];
    
    
}

#pragma mark Character
-(void)layoutCharacter{
    [super layoutCharacter];
    
    for (UIImageView *imageView in self.characterView.imageViews) {
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
    
}

-(NSString *)clothingImagesBaseFolderKeyPath{
    
    return @"activities.dress_up.clothing";
}

-(NSString *)characterImagesBaseFolderKeyPath{
    return @"shared.characters";
}

-(NSArray *)characterViewIdentifiers{
    NSMutableArray *characterViewIdentifiers =  [[NSMutableArray alloc] initWithArray:[super characterViewIdentifiers]];
//    [characterViewIdentifiers addObject:@"makeup"];
//    [characterViewIdentifiers addObject:@"makeup2"];

    [characterViewIdentifiers addObjectsFromArray:@[@"eyes", @"earrings", @"hair_pieces", @"necklaces"]];
    
    return characterViewIdentifiers;
}


-(NSString *)baseFolderKeyPath{
    return @"activities.make_up";
}



#pragma mark Scrollable Bench

-(void)layoutScrollableBenchView{
    [super layoutScrollableBenchView];
    
    self.scrollableBenchView.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.scrollableBenchView.backgroundImageView.frame = CGRectOffset(self.scrollableBenchView.backgroundImageView.frame, 0, self.scrollableBenchView.frame.size.height * 0.5);
    
    for (NFBenchView *benchView in self.scrollableBenchView.benchViews){
        for(NFBenchItemView *benchItemView in benchView.benchItemViews){
            if ([benchItemView.identifier isEqualToString:@"eye_liner"] || [benchItemView.identifier isEqualToString:@"eye_shadow"]) {
                benchItemView.tag = 0;
            }
        }
    }
    
    
    [self.scrollableBenchView addSubview:self.scrollableBenchView.rightArrowButton];
    [self.scrollableBenchView addSubview:self.scrollableBenchView.leftArrowButton];
    self.scrollableBenchView.leftArrowButton.hidden = YES;
    self.scrollableBenchView.rightArrowButton.hidden = NO;
}

-(NSString *)benchImageName{
    return [self.imagesDictionary valueForKeyPath:[@"" stringByAppendingFormat:@"activities.make_up.themes.%@.bench", self.currentTheme]];
}

-(NSArray *)scrollableBenchViewIdentifiers{
    //NSAssert(NO, @"Subclass this function to specify bench items and grouping");
    // Example grouping
    return @[ @[@"earrings", @"hair_pieces", @"necklaces", @"eyes"], @[@"lipsticks"], @[@"mascara"], @[@"powders"], @[@"eye_liner", @"eye_liner", @"eye_shadow", @"eye_shadow"] ];
}

-(CGPoint)topLeftOffsetForBenchViewObject:(NFBenchViewObject *)benchViewObject{
    if([benchViewObject.identifier rangeOfString:@"lipstick"].location != NSNotFound){
        return CGPointZero;
    }else if([benchViewObject.identifier rangeOfString:@"powder"].location != NSNotFound){
        return CGPointMake(self.scrollableBenchView.frame.size.width * 0.15, self.scrollableBenchView.frame.size.height * 0.0);
    }
    return [super topLeftOffsetForBenchViewObject:benchViewObject];
}

-(CGPoint)bottomRightOffsetForBenchViewObject:(NFBenchViewObject *)benchViewObject{
    if([benchViewObject.identifier rangeOfString:@"lipstick"].location != NSNotFound){
        return CGPointMake(self.scrollableBenchView.frame.size.width * 0.05, self.scrollableBenchView.frame.size.height * 0.2);
    }else if([benchViewObject.identifier rangeOfString:@"powder"].location != NSNotFound){
        return CGPointMake(self.scrollableBenchView.frame.size.width * 0.15, self.scrollableBenchView.frame.size.height * 0.05);
    }
    return [super bottomRightOffsetForBenchViewObject:benchViewObject];
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
    [self updateProductPropertiesForProductDisplayerView:self.sideScrollViewSelector];
    [self.sideScrollViewSelector layout];
    
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
-(CGPoint)offsetForBenchItemView:(NFBenchItemView *)benchItemView{
    CGPoint offset;
    if([benchItemView.identifier rangeOfString:@"lipstick"].location != NSNotFound){
        offset = CGPointMake(-benchItemView.frame.size.width * 0.2, -benchItemView.frame.size.height * 0.82);
    }else if([benchItemView.identifier rangeOfString:@"powder"].location != NSNotFound){
        offset = CGPointMake(-benchItemView.frame.size.width * 0.0, -benchItemView.frame.size.height * 0.8);
    }else if([benchItemView.identifier rangeOfString:@"mascara"].location != NSNotFound){
        offset = CGPointMake(-benchItemView.frame.size.width * 0.45, -benchItemView.frame.size.height * 0.25);
    }else if([benchItemView.identifier isEqualToString:@"eye_liner"]){
        offset = CGPointMake(-benchItemView.frame.size.width * 0.1, -benchItemView.frame.size.height * 1.0);
    }else if([benchItemView.identifier isEqualToString:@"eye_shadow"]){
        offset = CGPointMake(-benchItemView.frame.size.width * 0.15, -benchItemView.frame.size.height * 1.1);
    }
    return offset;
}

-(float)rotateOnDragAngleForIdentifier:(NSString *)benchItemIdentifier{
    if ([benchItemIdentifier isEqualToString:@"mascara"]) {
        return -M_PI * 0.5;
    }else if ([self isMakeupItem:benchItemIdentifier]) {
        return -M_PI * 0.15;
    }
    return 0;
}




#pragma mark Delegates
#pragma mark <NFScrollableBenchViewDelegate>
-(void)benchItemViewDidBeginDragging:(NFBenchItemView *)benchItemView touches:(NSSet *)touches withEvent:(UIEvent *)event{
    [super benchItemViewDidBeginDragging:benchItemView touches:touches withEvent:event];
    
    if ([benchItemView.identifier isEqualToString:@"lipsticks"]) {
        self.currentScratchableView.scratchDiameter = NFGeometryUniversalDistance(10);
    }

    
}


#pragma mark <NFControlStripViewDelegate>
-(void)controlButtonPressed:(id)sender inControlButtonStripView:(NFControlButtonStripView *)controlButtonStripView{
    NSString *controlButtonImageName = [controlButtonStripView.controlButtonNames objectAtIndex:[sender tag]];
    
    if ([controlButtonImageName rangeOfString:@"back"].location != NSNotFound) {
        [self backButtonPressed:sender];
    }else if([controlButtonImageName rangeOfString:@"facepaint"].location != NSNotFound){
        self.nextViewControllerClass = [FacepaintViewController class];
        [self presentNextActivityViewController];
    }else if([controlButtonImageName rangeOfString:@"choose_character"].location != NSNotFound){
        
        [self.layoutComponent controlButtonPressed:sender inControlButtonStripView:controlButtonStripView];
        
    }else{
        
        NSArray *componentsArray = [controlButtonImageName componentsSeparatedByString:@"-"];
        NSString *themeIdentifier = [componentsArray lastObject];        
        [self switchTheme:themeIdentifier];
        
    }
}



#pragma mark Banner Ads
-(void)makeSpaceForBannerAd:(UIView *)bannerAdView animated:(BOOL)animated{
    _verticalControlButtonStripView.frame = CGRectMake(_verticalControlButtonStripView.frame.origin.x, bannerAdView.frame.size.height, _verticalControlButtonStripView.frame.size.width, _verticalControlButtonStripView.frame.size.height);
    
    self.unlockThemeButton.frame = CGRectMake(self.unlockThemeButton.frame.origin.x, bannerAdView.frame.size.height, self.unlockThemeButton.frame.size.width, self.unlockThemeButton.frame.size.height);
    
    
    
}


@end
