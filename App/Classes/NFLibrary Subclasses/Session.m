//
//  Session.m
//  HalloweenDressUp
//
//  Created by William Locke on 10/7/13.
//  Copyright (c) 2013 Ninjafish Studios. All rights reserved.
//

#import "Session.h"

@implementation Session

+(Session *)sharedInstance
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
