//
//  NFChartboost.m
//
//  Created by William Locke on 3/5/13.
//
//

#import "NFChartboost.h"

#import "Chartboost.h"


@interface NFChartboost()<ChartboostDelegate>{
    NFChartboostShowImpressionCompletionHandler _showImpressionCompletionHandler;
    
}
@end

@implementation NFChartboost

+ (NFChartboost *)sharedInstance
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

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}



- (void)showInterstitial:(NSString *)label{
    
    [self showInterstitial:label completionHandler:nil];
    
}

-(void)showInterstitial:(NSString *)label completionHandler:(NFChartboostShowImpressionCompletionHandler)completionHandler{
    _showImpressionCompletionHandler = completionHandler;
    
    [[Chartboost sharedChartboost] setDelegate:self];
    
    // Fetch the interstitial ad.
    [[Chartboost sharedChartboost] showInterstitial:label];
    
}



#pragma mark <ChartboostDelegate>
// Called when an interstitial has failed to come back from the server
- (void)didFailToLoadInterstitial:(NSString *)location{
    if (_showImpressionCompletionHandler) {
        _showImpressionCompletionHandler(NO);
    }

    if(self.delegate && [self.delegate respondsToSelector:@selector(didFailToLoadInterstitial:)]) {
        [self.delegate didFailToLoadInterstitial:location];
    }
}

// Called when the user dismisses the interstitial
// If you are displaying the add yourself, dismiss it now.
- (void)didDismissInterstitial:(NSString *)location{
    if (_showImpressionCompletionHandler) {
        _showImpressionCompletionHandler(YES);
    }

    if(self.delegate && [self.delegate respondsToSelector:@selector(didDismissInterstitial:)]) {
        [self.delegate didDismissInterstitial:location];
    }
}

// Same as above, but only called when dismissed for a close
- (void)didCloseInterstitial:(NSString *)location{
    if (_showImpressionCompletionHandler) {
        _showImpressionCompletionHandler(YES);
    }
    
    NSLog(@"did close interstitial");
    if(self.delegate && [self.delegate respondsToSelector:@selector(didCloseInterstitial:)]) {
        [self.delegate didCloseInterstitial:location];
    }
}

// Same as above, but only called when dismissed for a click
- (void)didClickInterstitial:(NSString *)location{
    if (_showImpressionCompletionHandler) {
        _showImpressionCompletionHandler(YES);
    }
    
    NSLog(@"did click interstitial");
    
    if(self.delegate && [self.delegate respondsToSelector:@selector(didClickInterstitial:)]) {
        [self.delegate didClickInterstitial:location];
    }
}




@end
