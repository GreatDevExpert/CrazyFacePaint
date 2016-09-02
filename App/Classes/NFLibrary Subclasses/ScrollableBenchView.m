//
//  ScrollableBenchView.m
//  HalloweenDressUp
//
//  Created by William Locke on 10/3/13.
//  Copyright (c) 2013 Ninjafish Studios. All rights reserved.
//

#import "ScrollableBenchView.h"

@implementation ScrollableBenchView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)makeClickable:(NFBenchItemView *)benchItemView{
    benchItemView.clickable = YES;
    benchItemView.draggable = NO; 
}

-(void)configure{
     

    for(NFBenchItemView *benchItemView in self.facepaintDesignBenchItemViews){
        benchItemView.identifier = @"facepaint_design";
        [self makeClickable:benchItemView];
    }
    
    for(NFBenchItemView *benchItemView in self.paintContainersBenchItemViews){
        benchItemView.identifier = @"containers";
        [self makeClickable:benchItemView];
    }
    
    self.hatsBenchItemView.identifier = @"hats";
    [self makeClickable:self.hatsBenchItemView];
    
    self.wigsBenchItemView.identifier = @"wigs";
    [self makeClickable:self.wigsBenchItemView];
    
    self.glassesBenchItemView.identifier = @"glasses";
    [self makeClickable:self.glassesBenchItemView];
    
    self.accessoriesBenchView.identifier = @"accessories";
}


@end
