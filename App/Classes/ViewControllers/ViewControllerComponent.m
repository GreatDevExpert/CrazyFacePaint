//
//  ViewControllerLayoutComponent.m
//  BestFriendsMakeover
//
//  Created by William Locke on 10/15/14.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import "ViewControllerComponent.h"
#import "KSLabel.h"
#if __has_include("DVAdKit.h")
#import "DVAdKitMoreApps.h"
#endif

@protocol ViewControllerProtocol <NSObject>

@property (nonatomic, strong) NFControlButtonStripView *leftControlButtonStripView;
@property (nonatomic, strong) NFControlButtonStripView *rightControlButtonStripView;
@property (nonatomic, strong) UIButton *unlockThemeButton;
@property (nonatomic, strong) NFScrollableBenchView *scrollableBenchView;

@end


@implementation ViewControllerComponent

- (instancetype)initWithViewController:(NFGameViewController *)viewController
{
    self = [super init];
    if (self) {
        _viewController = viewController;
    }
    return self;
}

-(void)presentUnlockThemeButtonWithImageName:(NSString *)imageName productId:(NSString *)productId{
    NFProduct *product = [self.viewController.store productWithProductId:productId];
    UIButton *unlockThemeButton = [((id<ViewControllerProtocol>)self.viewController) unlockThemeButton];
    UIButton *button = [[UIButton alloc] initWithFrame:[((id<ViewControllerProtocol>)self.viewController) unlockThemeButton].frame];
    [button setImage:[NFImage imageForName:imageName] forState:UIControlStateNormal];
    unlockThemeButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    button.imageView.contentMode = unlockThemeButton.imageView.contentMode;
    button.frame = CGRectOffset(unlockThemeButton.frame, 0, -self.viewController.view.frame.size.height * 0.2);
    
    if([self.viewController.store productHasAlreadyBeenBought:product.identifier]){
        button.hidden = YES;
    }else{
        button.hidden = NO;
    }
    [self.viewController.view insertSubview:button aboveSubview:unlockThemeButton];
    
    [UIView animateWithDuration:0.7 animations:^{
        CGRect lockButtonFrame = unlockThemeButton.frame;
        unlockThemeButton.frame = button.frame;
        button.frame = lockButtonFrame;
    }completion:^(BOOL finished){
        [button removeFromSuperview];
        unlockThemeButton.frame = button.frame;
        [unlockThemeButton setImage:[NFImage imageForName:imageName] forState:UIControlStateNormal];
        //        [self.viewController.view insertSubview:unlockThemeButton belowSubview:self.titleLabel];
        [self.viewController.view addSubview:unlockThemeButton];
        unlockThemeButton.hidden = button.hidden;
        
        if ([self.viewController respondsToSelector:@selector(viewControllerTitleHandlersTitleLabel)]) {
            UILabel *titleLabel = [self.viewController viewControllerTitleHandlersTitleLabel];
            if (titleLabel.superview) {
                [self.viewController.view addSubview:titleLabel];
            }
        }
        
        if ([NFAdDisplayer sharedInstance].bannerAdView) {
            [self makeSpaceForBannerAd:[NFAdDisplayer sharedInstance].bannerAdView animated:NO];
        }
    }];
}


-(void)makeSpaceForBannerAd:(UIView *)bannerAdView animated:(BOOL)animated{

    
}



-(NSString *)unlockCharactersProductId{
    NSString *productId = [@"" stringByAppendingFormat:@"%@.unlock_characters", [[NSBundle mainBundle] bundleIdentifier]];
    return productId;
}

-(void)unlockCharacters{
    
    NSString *productId = [@"" stringByAppendingFormat:@"%@.unlock_characters", [[NSBundle mainBundle] bundleIdentifier]];
    NFProduct *product = [self.viewController.store productWithProductId:productId];
    [self.viewController purchase:product completionHandler:^(BOOL success) {
        if (success && [self.viewController.store productHasAlreadyBeenBought:productId]) {
            [self.viewController popThisViewController];
        }
    }];
}

#pragma mark <NFControlButtonStripViewDelegate>
-(void)controlButtonPressed:(id)sender inControlButtonStripView:(NFControlButtonStripView *)controlButtonStripView{
    
    NSString *buttonImageName = [controlButtonStripView.controlButtonNames objectAtIndex:[sender tag]];
    //NSLog(@"button image name: %@", buttonImageName);
    
    if([buttonImageName rangeOfString:@"more_games"].location != NSNotFound){
        [[NFAdDisplayer sharedInstance] showMoreApps];
    }else if([buttonImageName rangeOfString:@"choose_character"].location != NSNotFound){
        
        NSString *productId = [self unlockCharactersProductId];
        if ([self.viewController.store productHasAlreadyBeenBought:productId]){
            [self.viewController popThisViewController];
        }else{
            [self unlockCharacters];
        }
        
    }
}

-(NSString *)fontNameForTheme:(NSString *)theme{
    if ([theme isEqualToString:@"snowman"]) {
        return @"Futura-CondensedMedium";
    }else if ([theme isEqualToString:@"santa"]) {
        return @"Futura-CondensedMedium";
    }
    return @"Black Rose";
}
-(UIColor *)fontColorForTheme:(NSString *)theme{
    if ([theme isEqualToString:@"snowman"]) {
        // 41	101	214
        return [UIColor colorWithRed:41/255.0 green:101/255.0 blue:214/255.0 alpha:1.0];
    }else if ([theme isEqualToString:@"santa"]) {
        // 197	24	33
        return [UIColor colorWithRed:197/255.0 green:24/255.0 blue:33/255.0 alpha:1.0];
    }else if([theme isEqualToString:@"christmas"]){
        // 33	205	64
        return [UIColor colorWithRed:33/255.0 green:205/255.0 blue:64/255.0 alpha:1.0];
    }else if([theme isEqualToString:@"frozen"]){
        //46	174	216
        return [UIColor colorWithRed:46/255.0 green:174/255.0 blue:216/255.0 alpha:1.0];
    }

    return [UIColor colorWithRed:172/255.0 green:222/255.0 blue:255/255.0 alpha:1.0];
}

-(void)showTitleForTheme:(NSString *)theme{
    NSString *text;
    NSString *fontName;
    UIColor *textColor;
    
    textColor = [self fontColorForTheme:theme];
    fontName = [self fontNameForTheme:theme];
    
    NSString* themeTemp = theme;
    
    if ([theme isEqualToString:@"christmas"])
        theme = @"crazy";
    else if ([theme isEqualToString:@"frozen"])
        theme = @"princess";
    else if ([theme isEqualToString:@"santa"])
        theme = @"fairy";

    text = [@"" stringByAppendingFormat:@"%@%@", [[theme substringToIndex:1] uppercaseString], [theme substringFromIndex:1]];

    theme = themeTemp;
    [self.viewController showTitleWithText:text];
    
    KSLabel *titleLabel =  (KSLabel *)[self.viewController viewControllerTitleHandlersTitleLabel];
    titleLabel.font = [UIFont fontWithName:fontName size:titleLabel.font.pointSize * 2.0];
    titleLabel.textColor = textColor;
    [titleLabel setDrawGradient:NO];
    
}




@end
