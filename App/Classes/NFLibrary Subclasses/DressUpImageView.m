//
//  DressUpImageView.m
//  PrincessMakeover
//
//  Created by William Locke on 3/11/13.
//  Copyright (c) 2013 Ninjafish Studios. All rights reserved.
//

#import "DressUpImageView.h"
#import "NFImage.h"

@implementation DressUpImageView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
} 


-(void)didSelectItem:(id)sender{
    self.imageIndex = [sender tag];
    NSAssert(self.imageIndex < [self.items count], @"Index of selected image out of bounds");
    
    self.image = [NFImage imageForName:[self.items objectAtIndex:self.imageIndex]];
    
    
}

-(void)incrementDressUpImage{
    self.imageIndex = (self.imageIndex + 1) % [self.items count];
    self.image = [NFImage imageForName:[self.items objectAtIndex:self.imageIndex]];
    
}

@end
