//
//  NFAlertView.h
//
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ NFButtonCallback)();

/**
 Asyncronous version of UIAlertView.
 
     NFAlertView *alertView = [[NFAlertView alloc] initWithTitle:@"Some Title" message:@"Some message" cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
     
     [alertView show:^(UIAlertView *alertView, NSInteger buttonIndex){
            // handle user selection
     }];

 
 @warning *Important:* Ensure that other button titles comma separated list of button titles is nil terminated. Currently a compiler warning is not given for this. 
 */
@interface NFButton : UIButton{
    NFButtonCallback _callback;
}

@property (nonatomic, copy) NSString *identifier;

-(void) handleControlEvent:(UIControlEvents)event
                 withBlock:(NFButtonCallback) action;
@end
