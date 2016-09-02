//
//  NFFlattenableView.h
//  Pods
//
//  Created by William Locke on 2/22/13.
//
//

#import <UIKit/UIKit.h>

@interface NFFlattenableView : UIView


@property (nonatomic, strong) UIImageView *flattenedImageView;
@property BOOL flattened;

-(void)flatten;

@end
