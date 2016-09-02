//
//  NSString-validation.h
//  Slots Party
//
//  Created by William Locke on 2/28/12.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NSString (explode)

+(NSArray *)explode:(NSString *)delimiter string:(NSString *)string;

@end