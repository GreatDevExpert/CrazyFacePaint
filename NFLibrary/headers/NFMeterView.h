//
//  NFMeterView.h
//  Pods
//
//  Created by Jeff Patternstein on 9/15/14.
//
//

#import <UIKit/UIKit.h>
@class NFMeterView;

@protocol MeterViewDelegate <NSObject>

-(void)meterViewDidTimeOut:(NFMeterView *)meterView;

@end

@interface NFMeterView : UIView

@property (nonatomic, unsafe_unretained) id<MeterViewDelegate> delegate;
@property (nonatomic, strong) IBOutletCollection(UIImageView) NSArray *items;

@property float interval;


-(void)startMeter;
-(void)resetMeter;

@end
