//
//  NFUndoRedo.h
//  Cupcake
//
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>


/** Class for handling undo/redo for UI interaction. 
    
    NFUndoRedo *undoRedo = [[NFUndoRedo alloc] init];
    [undoRedo regesterUndoAction:@selector(removeFromSuperview) undoTarget:imageView undoArguments:nil redoAction:@selector(addSubview:) redoTarget:_consumableLayer redoArguments:[NSArray arrayWithObject:imageView]];
    
    // To undo most recent item on undo stack
    [undoRedo undo];
 
    // To redo most recent item on redo stack
    [undoRedo redo];
 
 
 Example: https://github.com/ninjafishstudios/cookiemaker/blob/develop/App/Classes/ViewControllers/DecorateViewController.m
 
 Dependencies:
    - NFLibrary/NFCategories
 
 */
@interface NFUndoRedo : NSObject

@property (nonatomic, strong) NSMutableArray *undoStack;
@property (nonatomic, strong) NSMutableArray *redoStack;

-(void)undo;
-(void)redo;
-(void)reset;

-(void)regesterUndoAction:(SEL)undoAction undoTarget:(NSObject *)undoTarget undoArguments:(NSArray *)undoArguments redoAction:(SEL)redoAction redoTarget:(NSObject *)redoTarget redoArguments:(NSArray *)redoArguments;


@end
