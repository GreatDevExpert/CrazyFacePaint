//
//  DressUpImageView.h
//  PrincessMakeover
//
//  Created by William Locke on 3/11/13.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import "NFImageView.h"

@interface NFDressUpImageView : NFImageView

@property (nonatomic, strong) NSArray *items;



-(void)didSelectItem:(id)sender;
-(void)didSelectItemAtIndex:(int)index;
-(void)incrementDressUpImage;

@end
