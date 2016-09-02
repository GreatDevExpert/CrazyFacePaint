//
//  NSData-applicationData.h
//
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NSData (applicationData)

+(NSString *)applicationDataFilePathForFilename:(NSString *)fileName;
+ (BOOL)writeApplicationData:(NSData *)data toFile:(NSString *)fileName;
+ (NSData *)applicationDataFromFile:(NSString *)fileName;

@end
