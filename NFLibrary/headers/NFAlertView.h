//
//  NFAlertView.h
//
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^ NFAlertViewCallback)(UIAlertView *alertView, NSInteger buttonIndex);

/**
 Asyncronous version of UIAlertView.
 
     NFAlertView *alertView = [[NFAlertView alloc] initWithTitle:@"Some Title" message:@"Some message" cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
     
     [alertView show:^(UIAlertView *alertView, NSInteger buttonIndex){
            // handle user selection
     }];

 
 @warning *Important:* Ensure that other button titles comma separated list of button titles is nil terminated. Currently a compiler warning is not given for this. 
 */
@interface NFAlertView : UIAlertView{
    NFAlertViewCallback callback;
}

/**
 * Creates an instance of NFAlertView in a similar way to UIAlertView. 
 * @warning *Important:* Ensure that other button titles comma separated list of button titles is nil terminated. Currently a compiler warning is not given for this.
 */
- (id)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;

-(void)show:(NFAlertViewCallback)__callback;

@end
