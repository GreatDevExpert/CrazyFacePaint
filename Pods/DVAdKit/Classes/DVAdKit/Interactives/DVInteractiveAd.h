//
//  DVInteractiveAd.h
//
//  Created by William Locke on 10/2/14.
//

#import <Foundation/Foundation.h>
#import "DVAdKitImpression.h"
#import "DVStoreProductHandler.h"
@interface DVInteractiveAd : NSObject


@property (nonatomic, strong) DVAdKitImpression *impression;
@property (nonatomic, strong) NSArray *views;
@property (nonatomic, strong) NSMutableArray *adImages;
@property (nonatomic, strong) NSString *label;

@property BOOL installed;
@property BOOL canOpenRemoteAppStoreUrl;
@property BOOL clicked;

@property (nonatomic, strong) DVStoreProductHandler *storeProductHandler;

// TODO: remove
@property (nonatomic, strong) NSString *appStoreLink;
@property (nonatomic, strong) NSString *localAppLink;


- (instancetype)initWithViews:(NSArray *)views;


-(void)displayInteractiveAdWithOptions:(NSMutableDictionary *)options withCompletionHandler:(void (^ )(DVInteractiveAd *interactiveAd))interactiveAdLoaded;

-(void)recordClick;
-(void)open;


// Add animation option
-(void)dismiss;

#pragma mark ===== ACTIONS ======
-(void)popin;





@end
