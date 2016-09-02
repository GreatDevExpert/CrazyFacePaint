//
//  NFImageDownloader.m
//  Pods
//
//  Created by William Locke on 5/30/13.
//
//

#import "DVImageDownloader.h"
#import "AFImageRequestOperation.h"

@implementation DVImageDownloader

+(void)downloadImage:(NSString *)imageUrl completionHandler:(void (^ )(UIImage *image))completionHandler{
    
    UIImage *adImage = [UIImage imageNamed:@"interstitial.jpg"];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:imageUrl]];
    AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest:request imageProcessingBlock:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
        
        completionHandler(image);
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
        completionHandler(nil);
    }];
    operation.imageScale = 1.0;
    
    [operation start];
    
}


@end
