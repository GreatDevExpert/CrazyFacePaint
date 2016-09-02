//
//  NFElectrocardiogramDisplayView.h
//  MonsterFrozen
//
//  Created by William Locke on 8/13/13.
//  Copyright (c) 2013 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NFImageView.h"

@interface NFElectrocardiogramDisplayView : UIView

@property (nonatomic, strong) IBOutlet NFImageView *displayLineImageView;


-(void)startAnimating:(void (^ )())completionHandler;

@end
