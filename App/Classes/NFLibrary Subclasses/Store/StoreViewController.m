//
//  StoreViewController.m
//  Ice Pop & Popsicle Maker
//
//  Created by William Locke on 10/18/12.
//
//

#import "StoreViewController.h"
#import "NFImage.h"
#import "Store.h"
#import "NFLayout.h"
#import "NFSounds.h"
#import "NFAlertView.h"

//static UIAlertView *_storeAlertView;

@interface StoreViewController (){
    UIView *_activityIndicatorView;
    IBOutlet UIScrollView *_scrollView;
    CGSize _productImageSize;
    IBOutlet UIButton *_backButton;
    IBOutlet UIImageView *_canopyImageView;
    CGPoint _currentScrollViewOffest;
    BOOL _storeAlreadyPreviewed;
    
    NFAlertView *_storeAlertView;
    
    StoreViewControllerCallback _callback;
    
    NSMutableArray *_productViews;
}

@end

static StoreViewController *_storeViewController;

@implementation StoreViewController

@synthesize viewController = _viewController;
//@synthesize delegate = _delegate;
@synthesize productId = _productId;
@synthesize restorePurchasesImageName = _restorePurchasesImageName;
@synthesize store = _store;

@synthesize backButtonSoundName = _backButtonSoundName;
@synthesize backNavigationSoundName = _backNavigationSoundName;
@synthesize presentThisViewControllerSoundName = _presentThisViewControllerSoundName;


#pragma mark Static Functions
+(StoreViewController *)sharedInstanceWithStore:(Store *)store{
    if(!_storeViewController){
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            _storeViewController = [[StoreViewController alloc] initWithNibName:@"StoreViewController_iPhone" bundle:nil];
        } else {
            _storeViewController = [[StoreViewController alloc] initWithNibName:@"StoreViewController_iPad" bundle:nil];
        }
    }
    _storeViewController.store = store;
    return _storeViewController;
}
+(StoreViewController *)sharedInstance{
    if(!_storeViewController){
        if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            _storeViewController = [[StoreViewController alloc] initWithNibName:@"StoreViewController_iPhone" bundle:nil];
        } else {
            _storeViewController = [[StoreViewController alloc] initWithNibName:@"StoreViewController_iPad" bundle:nil];
        }
    }
    return _storeViewController;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _restorePurchasesImageName = @"store-restore";
        _activityIndicatorView = [NFLayout activityIndicatorView];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self layout];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark Layout Functions
-(void)layout{
    [self layoutProducts];
    [self.view addSubview:_backButton];
}

-(void)layoutProducts{
    
    [_scrollView removeFromSuperview];
    if(_scrollView){
        _currentScrollViewOffest = _scrollView.contentOffset;
    }
    
    _scrollView = [[UIScrollView alloc] initWithFrame:_scrollView.frame];
    _scrollView.contentSize = CGSizeZero;
    
    _productViews = [[NSMutableArray alloc] init];
    
    [self.view addSubview:_scrollView];
    
    
    for(int i=0; i < [[Store sharedInstance].products count]; i++){
        [self layoutProductAtIndex:i];
    }
    
    [self layoutRestorePurchasesButton];
    
    [_canopyImageView removeFromSuperview];
    [self.view addSubview:_canopyImageView];
    [self.view addSubview:_backButton];
    
    _scrollView.contentOffset = _currentScrollViewOffest;
}

-(void)layoutRestorePurchasesButton{
    NSString *imageName = _restorePurchasesImageName;
    UIImage *image = [NFImage imageForName:imageName];
    
    UIView *productView = [[UIView alloc] initWithFrame:CGRectMake(0, _scrollView.contentSize.height, image.size.width, image.size.height)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, productView.frame.size.width, productView.frame.size.height)];
    imageView.image = image;
    [productView addSubview:imageView];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, productView.frame.size.width, productView.frame.size.height)];
    [button addTarget:self action:@selector(productButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [button setTag:[self.store.products count]];
    [productView addSubview:button];
    [_scrollView addSubview:productView];
    
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, _scrollView.contentSize.height + image.size.height);
}

-(void)layoutProductAtIndex:(int)index{
    
    NFProduct *product = [self.store.products objectAtIndex:index];
    NSString *productId = product.identifier;
    NSString *imageName =product.storeImage;
    
    UIImage *image = [NFImage imageForName:imageName];
    
    
    UIView *productView = [[UIView alloc] initWithFrame:CGRectMake(0, _scrollView.contentSize.height, image.size.width, image.size.height)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, productView.frame.size.width, productView.frame.size.height)];
    imageView.image = image;
    [productView addSubview:imageView];
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, productView.frame.size.width, productView.frame.size.height)];
    [button addTarget:self action:@selector(productButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [button setTag:index];
    [productView addSubview:button];
    
    
    
    if([self.store productHasAlreadyBeenBought:productId]){
        CGSize soldOutImageViewSize = CGSizeMake(productView.frame.size.width * 0.8, productView.frame.size.height * 0.8);
        UIImageView *soldImageView = [[UIImageView alloc] initWithFrame:CGRectMake((productView.frame.size.width - soldOutImageViewSize.width) / 2.0 ,(productView.frame.size.height - soldOutImageViewSize.height) / 2.0, soldOutImageViewSize.width, soldOutImageViewSize.height)];
        soldImageView.image = [NFImage imageForName:@"store-sold-out"];
        soldImageView.contentMode = UIViewContentModeScaleAspectFit;
        [productView addSubview:soldImageView];
    }
    
    
    
    [_scrollView addSubview:productView];
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width, _scrollView.contentSize.height + image.size.height);
    
    
    [_productViews addObject:productView];
    
}

#pragma mark Events
-(IBAction)restoreButtonPressed:(id)sender{
    
    [self.view addSubview:_activityIndicatorView];
    
    [[Store sharedInstance] restorePurchases:^(BOOL success) {
        [_activityIndicatorView removeFromSuperview];
        if(success){
            [self layoutProducts];
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Purchases Restored" message:@"Your purchases have been restored" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            
        }else{
            
        }
        
    }];
    
    
}
 

-(void)productButtonPressed:(id)sender{
    int index = [sender tag];
    
    if(index >= [self.store.products count]){
        //NSLog(@"Debug: restoring purchases");
        
        [self restoreButtonPressed:sender];
        
        return;
    }else{
        
    }
    
    NFProduct *product = [self.store.products objectAtIndex:index];
    [self purchase:product.identifier];
    
}

-(void)purchase:(NSString *)productId{
    
    NFProduct *product = [self.store productWithProductId:productId];
    
    if([[Store sharedInstance] productHasAlreadyBeenBought:productId]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Sold Out!" message:@"You have already purchased this item." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    if(_callback){
        //NSLog(@".4. THERE IS A CALLBACK");
    }
    
    __block StoreViewControllerCallback callback = _callback;
    
    [self.view addSubview:_activityIndicatorView];
    
    
    [self.store purchase:product completionHandler:^(BOOL success){
        //NSLog(@"purchase did %@", success ? @"succeed" : @"fail");
        [_activityIndicatorView removeFromSuperview];
        
        if(_callback){
            //NSLog(@".5. THERE IS A CALLBACK");
        }
        
        if(success){
            [self layoutProducts];
            
            if(_callback){
                _callback(product, nil);
            }else{
                //NSLog(@"Error: no callback given for StoreViewController");
                
            }
            
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Purchase Successful" message:@"You have successfully purchased this item" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alertView show];
            
        }else{
            
            if(_callback){
                _callback(product, [NSError errorWithDomain:[[NSBundle mainBundle] bundleIdentifier] code:1 userInfo:[[NSDictionary alloc] initWithObjectsAndKeys:@"Error purchasing", NSLocalizedDescriptionKey, nil]]);
                
            }else{
                //NSLog(@"Error: no callback given for StoreViewController");
            }
        }
    }];
    
    
}

-(IBAction)backButtonPressed:(id)sender{
    if([StoreViewController sharedInstance].backButtonSoundName){
        [[NFSounds sharedInstance] playSound:[StoreViewController sharedInstance].backButtonSoundName];
    }
    [self dismissThisViewController];
}


#pragma mark Navigation Functions
-(void)showInViewController:(UIViewController *)viewController{
    self.viewController = viewController;
    [self presentThisViewController];
    
    self.productId = nil;
}

//-(void)showInViewController:(UIViewController *)viewController afterPromptForProduct:(NSString *)productId{
//    self.viewController = viewController;
//    self.productId = productId;
//
//
//
//    [[self storeAlertView] show];
//}

-(void)showInViewController:(UIViewController *)viewController afterPromptForProduct:(NSString *)productId callback:(StoreViewControllerCallback)callback{
    
    self.viewController = viewController;
    self.productId = productId;
    
    NFProduct *product = [self.store productWithProductId:self.productId];
    _storeAlertView = [self storeAlertViewForProduct:product];
    
    _callback = callback;
    
    if(_callback){
        //NSLog(@"THERE IS A CALLBACK");
    }
    
    [_storeAlertView show:^(UIAlertView *alertView, NSInteger buttonIndex){
        if(buttonIndex == [alertView cancelButtonIndex]){
            return;
        }
        NSString *buttonTitle = [alertView buttonTitleAtIndex:buttonIndex];
        if([buttonTitle isEqualToString:@"Unlock Everything"]){
            [self presentThisViewControllerForProduct:[self.store unlockEverythingProduct]];
        }else{
            [self presentThisViewControllerForProduct:product];
        }
    }];
}

//-(NFAlertView *)storeAlertView{
//    NSString *productName = @"this item";
//    if(self.productId){
//        productName = [self.store productNameForProductId:self.productId];
//
//    }
//
//    NSString *message = [@"" stringByAppendingFormat:@"You don't own this item yet, would you like to buy the %@ feature? This feature will %@.", productName, [productName lowercaseString]];
//
//    _storeAlertView = [[NFAlertView alloc] initWithTitle:@"Sorry" message:message cancelButtonTitle:@"Not Now" otherButtonTitles:@"Go to Store", nil];
//
//
//    return _storeAlertView;
//}

-(NFAlertView *)storeAlertViewForProduct:(NFProduct *)product{
    NSString *productName = @"this item";
    if(self.productId){
        productName = [self.store productNameForProductId:self.productId];
    }
    
    NSString *message = [@"" stringByAppendingFormat:@"You don't own this item yet, would you like to buy the %@ feature? This feature will %@.", productName, [productName lowercaseString]];
    
    _storeAlertView = [[NFAlertView alloc] initWithTitle:@"" message:message cancelButtonTitle:@"Not Now" otherButtonTitles:@"Unlock Everything", [@"" stringByAppendingFormat:@"%@", product.name],  nil];
    
    
    return _storeAlertView;
}

-(void)scrollPreviewScrollView{
    [self scrollPreviewScrollViewToProduct:[self.store productWithProductId:self.productId]];
}


-(void)scrollPreviewScrollViewToProduct:(NFProduct *)product{
    if(_storeAlreadyPreviewed){
        //NSLog(@"Debug: store already previewed");
    }
    
    _scrollView.contentOffset = CGPointMake(0, _scrollView.contentSize.height - _scrollView.frame.size.height);
    
    CGPoint contentOffset;
    
    if(self.productId){
        int index = [self.store.products indexOfObject:product];
        UIView *productView = [_productViews objectAtIndex:index];
        
        if(index == 0){
            contentOffset = CGPointZero;
        }else{
            contentOffset = CGPointMake(0, productView.frame.origin.y - productView.frame.size.height * 0.5);
        }
    }else{
        contentOffset = CGPointMake(0, 0);
    }
    
    
    [UIView animateWithDuration:1.0 animations:^{
        _scrollView.contentOffset = contentOffset;
    }completion:^(BOOL finished){
        _storeAlreadyPreviewed = YES;
    }];
}

-(void)presentThisViewController{
    [self presentThisViewControllerForProduct:nil];
}

-(void)presentThisViewControllerForProduct:(NFProduct *)product{
    if([StoreViewController sharedInstance].presentThisViewControllerSoundName){
        [[NFSounds sharedInstance] playSound:[StoreViewController sharedInstance].presentThisViewControllerSoundName];
    }
    
    self.view.frame = CGRectMake(0,-self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
    
    [_viewController.view addSubview:self.view];
    
    _scrollView.contentOffset = CGPointMake(0, _scrollView.contentSize.height - _scrollView.frame.size.height);
    
    
    if(_callback){
        //NSLog(@".2. THERE IS A CALLBACK");
    }
    
    
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = CGRectMake(0,0, self.view.frame.size.width, self.view.frame.size.height);
    }completion:^(BOOL finished){
        
        [self.viewController presentModalViewController:self animated:NO];
        
        [self scrollPreviewScrollViewToProduct:product];
        
        if(product){
            
            if(_callback){
                //NSLog(@".3. THERE IS A CALLBACK");
            }
            
            if(![[Store sharedInstance] productHasAlreadyBeenBought:product.identifier]){
                [self purchase:product.identifier];
            }else{
                _callback(product, nil);
            }
            
        }
    }];
    
}

-(void)dismissThisViewController{
    if([StoreViewController sharedInstance].backNavigationSoundName){
        [[NFSounds sharedInstance] playSound:[StoreViewController sharedInstance].backNavigationSoundName];
    }
    
    
    [self.viewController dismissModalViewControllerAnimated:NO];
    [self.viewController.view addSubview:self.view];
    
    [UIView animateWithDuration:0.5 animations:^{
        self.view.frame = CGRectMake(0,-self.view.frame.size.height, self.view.frame.size.width, self.view.frame.size.height);
        
    }completion:^(BOOL finished){
        
        
        [self.view removeFromSuperview];
        
    }];
}

-(void)showSuccessfulPurchaseAlertView:(NFProduct *)product{
    [self layoutProducts];
    
}

#pragma mark Alert View Delegate Functions
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex == [alertView cancelButtonIndex]){
        return;
    }
    [self presentThisViewController];
}


@end
