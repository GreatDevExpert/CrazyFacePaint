//
//  NFDressUpView.h
//  NinjafishStudiosApp
//
//  Created by William Locke on 1/17/13.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "NFDressUpImageView.h"
#import "NFProductDisplayerView.h"

typedef enum {
    NFDressUpViewStateNone,
    NFDressUpViewStateDisplayingCategories,
    NFDressUpViewStateDisplayingThumbs,
    NFDressUpViewStateCount
}NFDressUpViewState;

@class NFSounds;
@class NFDressUpView;
@class NFStore;
@class NFViewController;
@protocol NFDressUpViewDelegate <NSObject>
@required
-(void)dressUpView:(NFDressUpView *)dressUpView didPressThumbButton:(id)sender;
@end

/**
 *  View used to display a series of image views that have various options
 *  for the image they can contain
 */
// TODO: Use NFImageViews instead of UIImageViews so that array of possible
// images can be set (as strings) as the NFImageView.items property, and the
// currently selected image can be set using NFImageView.imageIndex. 

// TODO: decouple this view from the control elements. Define a protocol for the
// control elements (such as NFScrollViewSelector), and set this view as the delegate
// for these control elements.

// TODO: This class could potentially be reduced to a single imagesDictionary property,
// if control objects are decoupled. 
@interface NFDressUpView : UIView <NFProductDisplayerViewDelegate>


@property (nonatomic, unsafe_unretained) id <NFDressUpViewDelegate> delegate;


@property (nonatomic, strong) IBOutletCollection(NFDressUpImageView) NSMutableArray *dressUpImageViews;




@property (nonatomic, strong) NSMutableDictionary *imagesDictionary DEPRECATED_ATTRIBUTE;;
@property (nonatomic, strong) NSMutableArray *dressUpKeyPaths DEPRECATED_ATTRIBUTE;;
@property (nonatomic, strong) NSMutableArray *dressThumbsKeyPaths DEPRECATED_ATTRIBUTE;;
@property (nonatomic, strong) NSMutableArray *categoryButtonKeyPaths DEPRECATED_ATTRIBUTE;;
@property BOOL shouldUseThumbSelector DEPRECATED_ATTRIBUTE;;
@property CGRect scrollViewSelectorFrame DEPRECATED_ATTRIBUTE;;
@property CGRect scrollViewSelectorBackgroundImageViewFrame DEPRECATED_ATTRIBUTE;
@property (nonatomic, copy) NSString *scrollViewSelectorBackgroundImageName DEPRECATED_ATTRIBUTE;
@property NFDressUpViewState state DEPRECATED_ATTRIBUTE;
@property int currentDressUpCategoryIndex DEPRECATED_ATTRIBUTE;
@property (nonatomic, strong) NSMutableArray *lockedCategories DEPRECATED_ATTRIBUTE;




// TODO: decouple from store. Use NFProductDisplayerView protocol (expand if necessary).
@property (nonatomic, strong) NFStore *store DEPRECATED_ATTRIBUTE;

// TODO: think about removing this. Perhaps use a helper object for sound events.
// Helper object could even be generalized to plug in to all UI elements such as
// in order to play sounds on certain events. (Perhaps use a separate delegate even?
// that sends events to helper object. 
@property (nonatomic, strong) NFSounds *sounds DEPRECATED_ATTRIBUTE;;

@property (nonatomic, copy) NSString *itemSelectedSoundName DEPRECATED_ATTRIBUTE;;
@property (nonatomic, copy) NSString *categorySelectedSoundName DEPRECATED_ATTRIBUTE;;
@property CGRect switchButtonFrame DEPRECATED_ATTRIBUTE;
@property (nonatomic, copy) NSString *switchButtonImageName DEPRECATED_ATTRIBUTE;
@property (nonatomic, strong) NFViewController *viewController DEPRECATED_ATTRIBUTE;

/** 
 * Key paths of incompatible dress ups.
 */
@property (nonatomic, strong) NSArray *incompatibleDressUps DEPRECATED_ATTRIBUTE;




#pragma mark Data
-(NFDressUpImageView *)dressUpImageViewWithIdentifier:(NSString *)identifier;


-(void)didSelectItem:(id)sender forDressUpImageViewWithIdentifier:(NSString *)identifier;


@end
