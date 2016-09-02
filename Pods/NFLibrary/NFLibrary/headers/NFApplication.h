//
//  MyUIApplication.h
//  CakeMaker
//
//  Created by William Locke on 9/25/13.
//  Copyright (c) 2013 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NFApplicationViewController <NSObject>

@optional
-(UIView *)activityIndicatorView;
@end

@protocol NFApplicationParentalGateProtocol <NSObject>

@required
-(void)show:(void (^ )(BOOL verified))completionHandler;

@end

@interface NFApplication : UIApplication

@property (nonatomic, strong) id<NFApplicationParentalGateProtocol> parentalGate;

-(BOOL)openURL:(NSURL *)url;

@end
