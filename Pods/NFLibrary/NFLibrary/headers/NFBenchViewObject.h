//
//  NFBenchViewObject.h
//  PrincessFashionResort
//
//  Created by William Locke on 6/15/14.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NFBenchItemViewObject.h"

@interface NFBenchViewObject : NSObject

@property (nonatomic, strong) NSMutableArray *benchItemViewObjects;
@property CGPoint benchItemViewObjectTopLeftOffset;
@property CGPoint benchItemViewObjectBottomRightOffset;
@property (nonatomic, strong) NSString *identifier;

@end
