//
//  NFChecklistView.h
//  MommysNewBaby
//
//  Created by William Locke on 9/25/14.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NFViewController.h"
@class NFChecklistView;

@protocol NFChecklistViewDelegate <NSObject>

@optional
-(void)didCompleteChecklist:(NFChecklistView *)checklistView;

@end

@interface NFChecklistView : UIView

- (instancetype)initWithViewController:(NFViewController *)viewController;

@property (nonatomic, unsafe_unretained) id<NFChecklistViewDelegate> delegate;
@property (nonatomic, strong) NFViewController *viewController;
@property (nonatomic, strong) NSArray *itemImageNames;
@property (nonatomic, copy) NSString *baseKeyPath;
@property (nonatomic, strong) NSDictionary *dictionary;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, copy) NSString *backgroundImageName;
@property (nonatomic, copy) NSString *rowImageName;
@property (nonatomic, copy) NSString *checkboxOnImageName;
@property (nonatomic, copy) NSString *checkboxOffImageName;
@property (nonatomic, copy) NSString *xButtonImageName;
@property (nonatomic, strong) UIButton *xButton;
@property (nonatomic, strong) NSMutableArray *rows;
@property (nonatomic, strong) NSMutableArray *checkboxes;

@property int numberOfCheckedOffItems;

#pragma mark Layout
-(void)layout;

-(CGRect)itemRectForItemView:(UIImageView *)itemView inRowImageView:(UIView *)rowImageView;
-(CGRect)checkboxRectForCheckboxImageView:(UIImageView *)checkboxImageView inRowImageView:(UIView *)rowImageView;
-(CGRect)xButtonRectForImage:(UIImage *)xButtonImage;

-(CGSize)paddingForRows;

-(BOOL)checklistComplete;
-(void)didCompleteChecklist;
-(void)checkOffItem:(NSString *)itemIdentifier;

-(void)show;


-(void)reset;

@end
