//
//  NFImageDownloader.h
//  Pods
//
//  Created by William Locke on 5/30/13.
//
//

#import <Foundation/Foundation.h>

@interface DVImageDownloader : NSObject

+(void)downloadImage:(NSString *)imageUrl completionHandler:(void (^ )(UIImage *image))completionHandler;

@end
