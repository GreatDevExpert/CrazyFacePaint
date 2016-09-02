//
//  ScrollableBenchView.h
//  HalloweenDressUp
//
//  Created by William Locke on 10/3/13.
//  Copyright (c) 2013 Ninjafish Studios. All rights reserved.
//

#import "NFScrollableBenchView.h"

@interface ScrollableBenchView : NFScrollableBenchView

@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, strong) IBOutletCollection(NFBenchItemView) NSArray *facepaintDesignBenchItemViews;
@property (nonatomic, strong) IBOutletCollection(NFBenchItemView) NSArray *paintContainersBenchItemViews;
@property (nonatomic, strong) IBOutlet NFBenchItemView *hatsBenchItemView;
@property (nonatomic, strong) IBOutlet NFBenchItemView *wigsBenchItemView;
@property (nonatomic, strong) IBOutlet NFBenchItemView *glassesBenchItemView;
@property (nonatomic, strong) IBOutlet NFBenchView *accessoriesBenchView;

-(void)configure;

@end
