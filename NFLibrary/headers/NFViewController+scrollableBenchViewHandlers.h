//
//  ViewController+scrollableBenchViewHandlers.h
//  PrincessFashionResort
//
//  Created by William Locke on 6/15/14.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import "NFViewController.h"
#import "NFBenchViewObject.h"

@interface NFViewController (scrollableBenchViewHandlers)

-(NFBenchItemViewObject *)benchItemViewObjectWithImageName:(NSString *)imageName;
-(NFBenchItemViewObject *)benchItemViewObjectWithImageName:(NSString *)imageName  withIdentifier:(NSString *)identifier;


-(NFBenchViewObject *)addBenchViewObjectToArray:(NSMutableArray *)benchViewObjects withImageNames:(NSArray *)imageNames withIdentifier:(NSString *)identifier;
-(NFBenchViewObject *)addBenchViewObjectToArray:(NSMutableArray *)benchViewObjects withImageNames:(NSArray *)imageNames withIdentifier:(NSString *)identifier rotateOnDragAngle:(CGFloat)rotateOnDragAngle;
-(NFBenchViewObject *)addBenchViewObjectToArray:(NSMutableArray *)benchViewObjects withImageNames:(NSArray *)imageNames withIdentifier:(NSString *)identifier rotateOnDragAngle:(CGFloat)rotateOnDragAngle accessoryImageName:(NSString *)accessoryImageName accessoryImageViewOffset:(CGPoint)accessoryImageViewOffset;

-(NFBenchItemViewObject *)addBenchItemViewObjectToBenchViewObject:(NFBenchViewObject *)benchViewObject withImageName:(NSString *)imageName withIdentifier:(NSString *)identifier;
-(NFBenchItemViewObject *)addBenchItemViewObjectToBenchViewObject:(NFBenchViewObject *)benchViewObject withImageName:(NSString *)imageName withIdentifier:(NSString *)identifier rotateOnDragAngle:(CGFloat)rotateOnDragAngle;
-(NFBenchItemViewObject *)addBenchItemViewObjectToBenchViewObject:(NFBenchViewObject *)benchViewObject withImageName:(NSString *)imageName withIdentifier:(NSString *)identifier rotateOnDragAngle:(CGFloat)rotateOnDragAngle accessoryImageName:(NSString *)accessoryImageName accessoryImageViewOffset:(CGPoint)accessoryImageViewOffset;


-(NFBenchItemViewObject *)benchItemViewObjectWithImageName:(NSString *)imageName  withIdentifier:(NSString *)identifier rotateOnDragAngle:(CGFloat)rotateOnDragAngle;
-(NFBenchItemViewObject *)benchItemViewObjectWithImageName:(NSString *)imageName  withIdentifier:(NSString *)identifier rotateOnDragAngle:(CGFloat)rotateOnDragAngle accessoryImageName:(NSString *)accessoryImageName accessoryImageViewOffset:(CGPoint)accessoryImageViewOffset;

-(NFBenchViewObject *)benchViewObjectWithImageNames:(NSArray *)imageNames withIdentifier:(NSString *)identifier;
-(NFBenchViewObject *)benchViewObjectWithImageNames:(NSArray *)imageNames withIdentifier:(NSString *)identifier rotateOnDragAngle:(CGFloat)rotateOnDragAngle;
-(NFBenchViewObject *)benchViewObjectWithImageNames:(NSArray *)imageNames withIdentifier:(NSString *)identifier rotateOnDragAngle:(CGFloat)rotateOnDragAngle accessoryImageName:(NSString *)accessoryImageName accessoryImageViewOffset:(CGPoint)accessoryImageViewOffset;

-(NFScrollableBenchView *)layoutScrollableBenchView:(NFScrollableBenchView *)scrollableBenchView withBenchViewObjects:(NSArray *)benchViewObjects;
-(NFScrollableBenchView *)layoutScrollableBenchView:(NFScrollableBenchView *)scrollableBenchView withBenchViewObjects:(NSArray *)benchViewObjects andBackgroundImageName:(NSString *)backgroundImageName;


-(BOOL)handleLeftArrowPressed:(id)sender forScrollableBenchView:(NFScrollableBenchView *)scrollableBenchView;
-(BOOL)handleRightArrowPressed:(id)sender forScrollableBenchView:(NFScrollableBenchView *)scrollableBenchView;

-(NFBenchItemView *)benchItemViewWithIdentifier:(NSString *)identifier inScrollableBenchView:(NFScrollableBenchView *)scrollableBenchView;

@end
