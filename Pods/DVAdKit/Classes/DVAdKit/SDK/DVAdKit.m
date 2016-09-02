//
//  NFAnalytics.m
//
//  Created by William Locke on 3/5/13.
//
//

#import "DVAdKit.h"




#import "DVAdKitWebAPI.h"

// DLog will output like DVAdKitLog only when the DEBUG variable is set
#define DEBUG_ YES

#ifdef DEBUG_
#   define DVAdKitLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DVAdKitLog(...)
#endif


@interface DVAdKit()<DVAdViewControllerDelegate>{

}

@end

@implementation DVAdKit

- (id)init
{
    self = [super init];
    if (self) {
        
        @try {
            
            [DVAdKitWebAPI sharedInstance];
            
        }
        @catch (NSException *exception) {
            DVAdKitLog(@"Exception");
        }
        @finally {
            
        }
    
    }
    return self;
}

+ (id)sharedInstance
{
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    
    // returns the same object each time
    return _sharedObject;
}





#pragma mark Start
-(void)start{
    
    [[DVAdKitWebAPI sharedInstance] start];
    
}


// Show an interstitial, optionally takes a location and/or a view argument
- (void)showInterstitial{
    [[DVAdKitWebAPI sharedInstance] showInterstitial];
}

-(void)showInterstitial:(NSString *)label{
    [[DVAdKitWebAPI sharedInstance] showInterstitial:label];

}

-(void)showInterstitial:(NSString *)label completionHandler:(void (^ )(BOOL impressionWasFilled))completionHandler{
    [[DVAdKitWebAPI sharedInstance] showInterstitial:label completionHandler:completionHandler];
    
}



#pragma mark Delegate
#pragma mark --DVAdKitViewControllerDelegate
-(void)didClickImpression:(DVAdKitImpression *)impression{
    [[DVAdKitWebAPI sharedInstance] addClickEventToPasteboardForImpression:impression];
    [[DVAdKitWebAPI sharedInstance] createClick:impression];
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(didClickInterstitial:)]){
        [self.delegate didClickInterstitial:nil];
    }
}

-(void)willCloseImpression:(DVAdKitImpression *)impression{
    if(!impression.clicked){
        [[DVAdKitWebAPI sharedInstance] deleteClick:impression];
    }
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(didCloseInterstitial:)]){
        [self.delegate didCloseInterstitial:nil];
    }
}

-(void)didPressRemoveAds{
    if(self.delegate && [self.delegate respondsToSelector:@selector(didPressRemoveAds)]){
        [self.delegate didPressRemoveAds];
    }
}




@end
