//
//  NSString-manipulation.h
//  Slots Party
//
//  Created by William Locke on 2/28/12.
//  Copyright 2012 William Locke. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NSString (manipulation)


-(void)ellipsisTruncateToLength:(int)length;
-(void)urlEncode;
-(void)stripPhoneNumber;

-(NSString *)formatAsUSPhoneNumber;

@end
