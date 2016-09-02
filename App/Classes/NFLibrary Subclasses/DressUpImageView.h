//
//  DressUpImageView.h
//  PrincessMakeover
//
//  Created by William Locke on 3/11/13.
//  Copyright (c) 2013 Ninjafish Studios. All rights reserved.
//

#import "NFImageView.h"

@interface DressUpImageView : NFImageView

@property (nonatomic, strong) NSArray *items;


-(void)didSelectItem:(id)sender;
-(void)incrementDressUpImage;

@end
