//
//  NFInterstitialViewController.h
//  DressUpMusic
//
//  Created by William Locke on 5/20/13.
//
//

#import <UIKit/UIKit.h>
#import "DVAdKitImpression.h"
#import "DVAdKitCreative.h"
@class DVAdViewController;

@protocol DVAdViewControllerDelegate <NSObject>

@optional
-(void)willCloseImpression:(DVAdKitImpression *)impression;

@optional
-(void)didClickImpression:(DVAdKitImpression *)impression;

@optional
-(void)didPressRemoveAds;

@end

@interface DVAdViewController : UIViewController

@property (nonatomic, unsafe_unretained) id<DVAdViewControllerDelegate> delegate;
@property (nonatomic, strong) DVAdKitImpression *impression;
@property (nonatomic, strong) DVAdKitCreative *creative;
@property (nonatomic, strong) UIImage *adImage;
@property (nonatomic, strong) UIImage *frameImage;


- (id)init;

#pragma mark Navigation
-(void)show;
-(void)dismiss;


@end
