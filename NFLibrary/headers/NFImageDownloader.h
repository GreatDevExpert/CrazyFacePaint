//
//  NFImageDownloader.h
//  Pods
//
//  Created by William Locke on 5/30/13.
//
//

#import <UIKit/UIKit.h>

@interface NFImageDownloader : NSObject

+(void)downloadImage:(NSString *)imageUrl completionHandler:(void (^ )(UIImage *image))completionHandler;

@end
