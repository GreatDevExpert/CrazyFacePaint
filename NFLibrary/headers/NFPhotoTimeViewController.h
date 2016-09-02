//
//  NFPhotoTimeViewController.h
//  Pods
//
//  Created by William Locke on 8/26/14.
//
//

#import "NFGameViewController.h"
#import "NFButton.h"

@interface NFPhotoTimeViewController : NFGameViewController


@property (nonatomic, strong) IBOutletCollection(NFImageView) NSMutableArray *selectableImageViews;
@property (nonatomic, strong) IBOutletCollection(NFButton) NSArray *selectableButtons;
@property (nonatomic, strong) IBOutlet NFButton *cameraButton;

@property (nonatomic, strong) IBOutletCollection(NFCharacterView) NSArray *characterViews;


-(void)layoutCharacters;

@end
