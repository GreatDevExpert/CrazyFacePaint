//
//  AdMobMediationAdapterVungle.m
//
//  Created by William Locke on 3/5/13.
//
//

#import "AdMobMediationAdapterVungle.h"


@interface AdMobMediationAdapterVungle(){
    
}
@end

@implementation AdMobMediationAdapterVungle


+(instancetype)sharedInstance
{
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    
    // returns the same object each time
    return _sharedObject;
}


@end
