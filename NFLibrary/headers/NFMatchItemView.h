//
//  NFMatchItemView.h
//  PreschoolGames
//
//  Created by William Locke on 6/11/13.
//  Copyright (c) 2013 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum  {
     NFMatchItemViewStateTurnedUp,
     NFMatchItemViewStateTurnedDown
    }NFMatchItemViewState;

@interface NFMatchItemView : UIButton


@property int imageIndex;
@property int arrayIndex;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) NSString *upsideDownImageName;
@property CGRect originalFrame;


-(void)flip;
-(void)flipUpsideDown;


@end
