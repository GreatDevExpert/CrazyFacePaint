//
//  NFBenchItemViewObject.h
//  PrincessFashionResort
//
//  Created by William Locke on 6/15/14.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NFBenchItemViewObject : NSObject

@property (nonatomic, strong) NSString *imageName;
@property CGFloat rotateOnDragAngle;
@property (nonatomic, strong) NSString *accessoryImageName;
@property CGPoint accessoryImageViewOffset;
@property BOOL positionAccessoryBelowBenchItemView;
@property (nonatomic, strong) NSString *identifier;
@property BOOL clickable;
@property CGPoint topLeftOffset;
@property (nonatomic, strong) NSString *draggingImageName;
@property BOOL animated;


@end
