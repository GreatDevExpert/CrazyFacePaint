//
//  NFChartboost.h
//
//  Created by William Locke on 3/5/13.
//
//

#import <Foundation/Foundation.h>
#import "NFAdDisplayer.h"

@interface NFChartboost : NSObject

typedef void (^ NFChartboostShowImpressionCompletionHandler)(BOOL installed);

@property (nonatomic, copy) NSString *interstialAdUnitId;

@property (nonatomic, unsafe_unretained) id<NFAdDisplayerDelegate> delegate;

+ (NFChartboost *)sharedInstance;

- (void)showInterstitial:(NSString *)label;
-(void)showInterstitial:(NSString *)label completionHandler:(NFChartboostShowImpressionCompletionHandler)completionHandler;

@end
