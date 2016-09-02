//
//  Session.h
//  HalloweenDressUp
//
//  Created by William Locke on 10/7/13.
//  Copyright (c) 2013 Ninjafish Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Session;

@interface Session : NSObject

@property (nonatomic, strong) NSNumber *characterIndex;
@property (nonatomic, copy) NSNumber *bonusCharacter;
@property (nonatomic, copy) NSString *currentTheme;

+(Session *)sharedInstance;

@end
