//
//  NFProductDisplayerView.h
//  LollipopMaker
//
//  Created by William Locke on 2/12/13.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol NFProductDisplayerViewDelegate;

@protocol NFProductDisplayerView <NSObject>

@required
-(NSString *)productId;

@required
-(void)setLockedIndex:(int)lockedIndex;
@required
-(void)setDownloadedIndex:(int)downloadedIndex;
@required
-(void)setDownloadingIndex:(int)downloadingIndex;
@required
-(BOOL)isSenderLocked:(id)sender;
@required
-(BOOL)isSenderStillDownloading:(id)sender;
@required
-(BOOL)doesSenderStillNeedToBeDownloaded:(id)sender;
@required
-(BOOL)isItemAtIndexLocked:(int)index;
@required
-(BOOL)itemAtIndexStillNeedsToBeDownloaded:(int)index;
@required
-(BOOL)itemAtIndexIsDownloading:(int)index;
@required
-(BOOL)isSenderAvailable:(id)sender;

@optional
-(void)setDelegate:(id<NFProductDisplayerViewDelegate>)delegate;

-(void)layout;

@optional
-(void)setDelegate:(id<NFProductDisplayerViewDelegate>)delegate;



@end


@protocol NFProductDisplayerViewDelegate <NSObject>
@required
-(void)productDisplayerView:(id<NFProductDisplayerView>)productDisplayerView didSelectItem:(id)sender;
@end





typedef void (^NFProductDisplayerViewSelectedItemBlock)(id<NFProductDisplayerView>productDisplayerView, id sender);
@interface NFProductDisplayerViewBlockDelegate : NSObject<NFProductDisplayerViewDelegate>
{
    NFProductDisplayerViewSelectedItemBlock _selectedItemBlock;
}

- (id) initWithSelectedItemBlock:(NFProductDisplayerViewSelectedItemBlock)selectedItemBlock;
+ (NFProductDisplayerViewBlockDelegate *)blockDelegateWithSelectedItemBlock:(NFProductDisplayerViewSelectedItemBlock)selectedItemBlock;
-(void)productDisplayerView:(id<NFProductDisplayerView>)productDisplayerView didSelectItem:(id)sender;
@end




