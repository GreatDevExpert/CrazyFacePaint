//
//  NFPuzzleViewController.h
//  KidsJobs
//
//  Created by William Locke on 4/18/14.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import "NFGameViewController.h"

@interface NFPuzzleViewController : NFGameViewController

@property (nonatomic, strong) IBOutletCollection(NFDraggableView) NSArray *puzzlePieces;
@property (nonatomic, strong) IBOutletCollection(NFDraggableView) NSArray *puzzlePlacings;


@property (nonatomic, strong) IBOutletCollection(NFDraggableView) NSArray *wrongPieces;

-(void)layout;

-(void)draggableViewDidBeginDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)draggableViewDidContinueDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;
-(void)draggableViewDidEndDragging:(NFDraggableView *)draggableView touches:(NSSet *)touches withEvent:(UIEvent *)event;

-(void)didCompleteLevel;

@end
