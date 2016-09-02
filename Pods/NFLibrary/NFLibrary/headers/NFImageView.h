//
//  NFImageView.h
//  Pods
//
//  Created by William Locke on 2/22/13.
//
//

#import <UIKit/UIKit.h>

@interface NFImageView : UIImageView

@property int imageIndex;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, strong) NSArray *items;
@property CGRect originalFrame;


-(void)layout;
-(void)releaseImages;

-(void)didSelectItem:(id)sender;
-(void)didSelectItemAtIndex:(int)index;


-(void)incrementImage;
-(void)decrementImage;


-(void)flatten;

@end
