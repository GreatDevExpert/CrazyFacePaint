//
//  NSString-encoding.h
//  Slots Party
//
//  Created by William Locke on 2/28/12.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NSString (encoding)

+(NSString *)urlEncode:(NSString *)string;
-(NSString *)filenameEncode;

@end
