//
//  DVEasterEggs.h
//  HalloweenDressUp
//
//  Created by William Locke on 10/1/14.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DVStoreProductHandler;
#import "DVInteractiveAd.h"

static int kDVInteractiveAdContainerViewTag = 327837344;

@interface DVInteractiveAdManager : NSObject

@property (nonatomic, strong) NSMutableArray *interactiveAds;
@property (nonatomic, strong) DVStoreProductHandler *storeProductHandler;


+ (DVInteractiveAdManager *)sharedInstance;



-(void)displayEmbeddedInteractive:(NSArray *)interactiveAdViews;
-(void)displayEmbeddedInteractive:(NSArray *)interactiveAdViews withCompletionHandler:(void (^ )(DVInteractiveAd *interactiveAd))interactiveAdLoaded;

-(void)displayEmbeddedInteractive:(NSArray *)interactiveAdViews withLabel:(NSString *)label completionHandler:(void (^ )(DVInteractiveAd *interactiveAd))interactiveAdLoaded;




//-(void)displayEmbeddedInteractives;
//-(void)displayEmbeddedInteractivesWithCompletionHandler:(void (^ )(DVInteractiveAd *interactiveAd))interactiveAdLoaded;
//-(void)displayEmbeddedInteractivesWithLabel:(NSString *)label completionHandler:(void (^ )(DVInteractiveAd *interactiveAd))interactiveAdLoaded;



@end
