//
//  NFUndoRedoInvocation.h
//  Cupcake
//
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NFUndoRedoInvocation : NSObject


@property (nonatomic, strong) NSInvocation *undoInvocation;
@property (nonatomic, retain) NSInvocation *redoInvocation;

@property (nonatomic, retain) NSObject *redoTarget;
@property (nonatomic, retain) NSObject *undoTarget;

@property (nonatomic, retain) NSArray *undoArguments;
@property (nonatomic, retain) NSArray *redoArguments;


- (id)initWithUndoAction:(SEL)undoAction undoTarget:(NSObject *)undoTarget undoArguments:(NSArray *)undoArguments redoAction:(SEL)redoAction redoTarget:(NSObject *)redoTarget redoArguments:(NSArray *)redoArguments;


@end
