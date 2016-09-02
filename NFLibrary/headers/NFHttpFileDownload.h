//
//  HttpFileDownload.h
//
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface NFHttpFileDownload : NSOperation 

@property (nonatomic, copy) NSString *urlString;
@property (nonatomic, copy) NSString *filePath;

typedef void (^ completionHandler)(NSURLResponse *response, NSData *data, NSError *error);

- (id)initWithOperationQueue:(NSOperationQueue *)queue;

-(BOOL)sendRequestWithUrl:(NSString *)url
               httpMethod:(NSString *)httpMethod
                   params:(NSMutableDictionary *)params
                    files:(NSMutableArray *)files
        completionHandler:(completionHandler)completionHandler;


@end
