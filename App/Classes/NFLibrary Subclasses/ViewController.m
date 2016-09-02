//
//  ViewController.m
//  Cookie Maker
//
//  Created by William Locke on 1/25/13.
//  Copyright (c) 2013 Ninjafish Studios. All rights reserved.
//

#import "ViewController.h"
#import "Chartboost.h"
#import <objc/runtime.h>
//#import "SHK.h"
#import "FacepaintViewController.h"


@interface ViewController (){
    BOOL _registeredForDownloadNotification;
    
    NSMutableDictionary *_productDisplayerViewDownloadObservers;
    
    IBOutlet UIButton *_leftArrowButton;
    IBOutlet UIButton *_rightArrowButton;
}

@end 

@implementation ViewController

@synthesize appDelegate = _appDelegate;
@synthesize userSession = _userSession;

- (id)initWithNib
{
    self = [super initWithNib];
    if (self) {
        // Custom initialization
        
        //!!!
        _productDisplayerViewDownloadObservers = [[NSMutableDictionary alloc] init];
        _appDelegate = [[UIApplication sharedApplication] delegate];
        
        self.applicationWindow = _appDelegate.window;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    if([[UIScreen mainScreen] bounds].size.height == 568){
        [self adjustLayoutForIPhone5];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:(BOOL)animated];    // Call the super class
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(self.soundButton){
        if([NFSettings sharedInstance].soundsOn){
            [_soundButton setImage:[NFImage imageForName:self.imageNameForSoundButtonOn] forState:UIControlStateNormal];
        }else{
            [_soundButton setImage:[NFImage imageForName:self.imageNameForSoundButtonOff] forState:UIControlStateNormal];
        }
    }
    //    [self playBackgroundMusic];
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    

}


#pragma mark Events

-(void)soundButtonPressed:(id)sender{
    if([NFSettings sharedInstance].soundsOn){
        [NFSettings sharedInstance].soundsOn = NO;
        [[Sounds sharedInstance] stopAllSounds];
        [((UIButton *)sender) setImage:[NFImage imageForName:self.imageNameForSoundButtonOff] forState:UIControlStateNormal];
    }else{
        [NFSettings sharedInstance].soundsOn = YES;
        [self playBackgroundMusic];
        [((UIButton *)sender) setImage:[NFImage imageForName:self.imageNameForSoundButtonOn] forState:UIControlStateNormal];
        [self playBackgroundMusic];
    }
    [[((UIButton *)sender) imageView] setContentMode:UIViewContentModeScaleAspectFit];
    // This makes settings state persist over relaunch
    [[NFSettings sharedInstance] save];
}

-(void)playBackgroundMusic{
    //    [self.sounds stopLoopedSound:kSoundNamebg_home_choosecharacter_mixmatch];
    [self.sounds stopAllMusic];
    
    NSString *soundName = kSoundNameSoundTricksCuteBackgroundLoop2;
//    if([Session sharedInstance].backgroundMusicSoundName){
//        soundName = [Session sharedInstance].backgroundMusicSoundName;
//    }else{
//        soundName = kSoundNamebackground_music_mixed;
//    }
    
    //NSLog(@"play sound name: %@", soundName);
    
    
    [self.sounds playLoopedSound:soundName];
    [[Sounds sharedInstance] adjustVolumeForLoopedSound:soundName volume:0.1];
}

-(void)playBackgroundMusicForTheme:(NSString *)identifier{
//    NSString *soundName = [@"" stringByAppendingFormat:@"background_music_%@.mp3", identifier];
//    if (!([Session sharedInstance].backgroundMusicSoundName && [[Session sharedInstance].backgroundMusicSoundName isEqualToString:soundName])) {
//        [Session sharedInstance].backgroundMusicSoundName = soundName;
//        [self playBackgroundMusic];
//    }
}

-(void)playClickSoundWithIdentifier:(NSString *)identifier{
    NSString *soundName = [@"" stringByAppendingFormat:@"click_%@.caf", identifier];
    if(!identifier){
        soundName = @"click.caf";
    }
    [self.sounds playShortSound:soundName];
    
}


-(void)updateSoundButton{
    [[NFSettings sharedInstance] soundsOn];
    
    if([[NFSettings sharedInstance] soundsOn]){
        
        [self playBackgroundMusic];
        
        [self.soundButton setImage:[NFImage imageForName:self.imageNameForSoundButtonOn] forState:UIControlStateNormal];
        ;
    }else{
        [self.sounds stopAllSounds];
        [self.soundButton setImage:[NFImage imageForName:self.imageNameForSoundButtonOff] forState:UIControlStateNormal];
        
    }
    //    [[((UIButton *)sender) imageView] setContentMode:UIViewContentModeScaleAspectFit];
    // This makes settings state persist over relaunch
    [[NFSettings sharedInstance] save];
}

#pragma mark Actions
-(void)share{
    
    [self.fullScreenButton removeFromSuperview];
    UIImage *image = self.shareImage;
    UIImageWriteToSavedPhotosAlbum(image, self,
                                   @selector(cameraHandlerImage:didFinishSavingWithError:contextInfo:), nil);
    [self setNonPhotographicElementsHidden:NO];
    
    
//    NSString *shareText = [@"" stringByAppendingFormat:@"%@. %@", self.appDelegate.config.promotionalText, self.appDelegate.config.promotionalUrl];
//    SHKItem *shareItem = [SHKItem image:self.shareImage title:shareText];
//	self.shareKitActionSheet = [SHKActionSheet actionSheetForItem:shareItem];
//    [self.shareKitActionSheet showInView:self.view];
//    self.shareKitActionSheet.delegate = self;
}


#pragma mark Layout
-(void)layoutButtons{
    

    
}

-(void)reset{
        
    
}


#pragma mark IBActions

-(IBAction)unlockThemeButtonPressed:(id)sender{
    //NSLog(@"unlock theme button pressed");
    
    [self playClickSoundWithIdentifier:nil];
    
    int i=0;
    NSString *themeIdentifier;
    for(NSString *identifier in [self.imagesDictionary valueForKeyPath:@"shared.theme_buttons"]){
        //NSLog(@"identifier: %@", identifier);
        if (i == [sender tag]) {
            themeIdentifier = identifier;
        }
        i++;
    }
    
    NSString *bundleIdentifier = [[NSBundle mainBundle] bundleIdentifier];
    //NSLog(@"theme identifier: %@", themeIdentifier);
    NSString *productId = [@"" stringByAppendingFormat:@"%@.unlock_%@_pack", bundleIdentifier, themeIdentifier];
    //NSLog(@"product id: %@", productId);
    NFProduct *product;
    for(NFProduct *tmpProduct in self.store.products){
        if([tmpProduct.identifier isEqualToString:productId]){
            product = tmpProduct;
            break;
        }
    }
    //NSLog(@"product--%@", product.identifier);
    
    [self purchase:product shouldHandleDownloads:YES completionHandler:^(NFProduct *purchasedProduct, NFDownloader *downloader, NSError *error){
        //NSLog(@"download complete");
        
        if([self.store productHasAlreadyBeenBought:product.identifier]){
            [sender setHidden:YES];
            
            if([self respondsToSelector:@selector(themeUnlocked)]){
                [self themeUnlocked];
            }
        }
        
    }];
    
    
}

-(void)themeUnlocked{
    
}

#pragma mark Data
-(NSArray *)controlButtonNames{
    return @[@"shared-buttons-back", @"shared-buttons-reset", @"shared-buttons-camera", @"shared-theme_buttons-mixed", @"shared-theme_buttons-christmas", @"shared-theme_buttons-frozen", @"shared-theme_buttons-superhero", @"shared-theme_buttons-snowman", @"shared-theme_buttons-witch"];
    
}


-(void)showBackgroundWithIdentifier:(NSString *)identifier{
    
    NSString *imageName = [@"" stringByAppendingFormat:@"makeup-themes-%@-background.jpg", identifier];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectOffset([[UIScreen mainScreen] bounds], [[UIScreen mainScreen] bounds].size.width, 0)];
    
    imageView.image = [NFImage imageForName:imageName];
    if(!imageView.image){
        imageView.image = [NFImage imageForName:@"makeup-background.jpg"];
    }
    
    //NSLog(@"show bg: %@", imageName);
    
    [self.view insertSubview:imageView aboveSubview:self.backgroundImageView];
    
    [UIView animateWithDuration:kViewControllerDefaultAnimationDuration animations:^{
        imageView.frame = [[UIScreen mainScreen] bounds];
        
        self.backgroundImageView.frame = CGRectOffset([[UIScreen mainScreen] bounds], -[[UIScreen mainScreen] bounds].size.width, 0);
        
    }completion:^(BOOL finished){
        self.backgroundImageView.image = imageView.image;
        self.backgroundImageView.frame = imageView.frame;
        [imageView removeFromSuperview];
    }];
}

-(void)showLockButtonWithIdentifier:(NSString *)identifier{
    NSString *imageName = [@"" stringByAppendingFormat:@"shared-theme_buttons_locked-%@", identifier];
    
    
    
    UIButton *button = [[UIButton alloc] initWithFrame:self.unlockThemeButton.frame];
    [button setImage:[NFImage imageForName:imageName] forState:UIControlStateNormal];
    
    //NSLog(@"show button: %@", imageName);
    button.frame = CGRectOffset(self.unlockThemeButton.frame, 0, -self.view.frame.size.height * 0.1);
     
    int i=0;
    for(NSString *key in [self.imagesDictionary valueForKeyPath:@"shared.theme_buttons"]){
        //NSLog(@"identifier: %@", identifier);
        if ([key isEqualToString:identifier]){
            self.unlockThemeButton.tag = i;
        }
        i++;
    }
    
    
    NFProduct *product = [self.store productWithProductId:[@"" stringByAppendingFormat:@"%@.unlock_%@_pack", [[NSBundle mainBundle] bundleIdentifier], identifier]];
    if([self.store productHasAlreadyBeenBought:product.identifier]){
        button.hidden = YES;
    }else{
        button.hidden = NO;
    }
    
    
    [self.view insertSubview:button aboveSubview:self.unlockThemeButton];
    
    //    [self.view addSubview:button];
    
    [UIView animateWithDuration:kViewControllerDefaultAnimationDuration animations:^{
        CGRect lockButtonFrame = self.unlockThemeButton.frame;
        self.unlockThemeButton.frame = button.frame;
        button.frame = lockButtonFrame;
    }completion:^(BOOL finished){
        [button removeFromSuperview];
        self.unlockThemeButton.frame = button.frame;
        [self.unlockThemeButton setImage:[NFImage imageForName:imageName] forState:UIControlStateNormal];
        
        
        self.unlockThemeButton.hidden = button.hidden;
    }];
}

-(void)setNonPhotographicElementsHidden:(BOOL)nonPhotographicElementsHidden{
    [super setNonPhotographicElementsHidden:nonPhotographicElementsHidden];
    _leftArrowButton.hidden = _rightArrowButton.hidden = nonPhotographicElementsHidden;
    
}





@end
