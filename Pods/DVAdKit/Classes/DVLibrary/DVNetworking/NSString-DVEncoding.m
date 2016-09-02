//
//  NSString-encoding.m
//  Slots Party
//
//  Created by William Locke on 2/28/12.
//  Copyright 2012 William Locke. All rights reserved.
//

#import "NSString-DVEncoding.h"


@implementation NSString (DVEncoding)

// Creates url encoded string
+(NSString *)urlEncode:(NSString *)string{
    if(![string isKindOfClass:[NSString class]]){
        string = [@"" stringByAppendingFormat:@"%@", string];
        NSLog(@"Warning: not string class");
    }
    
    NSString *encodedString = string;
	encodedString = [encodedString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	encodedString = [encodedString stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
	return encodedString;
}
-(NSString *)filenameEncode
{
	NSString *encodedString;
	encodedString = [self stringByReplacingOccurrencesOfString:@":" withString:@"-"];
	encodedString = [encodedString stringByReplacingOccurrencesOfString:@"/" withString:@":"];
	return encodedString;
}



@end
