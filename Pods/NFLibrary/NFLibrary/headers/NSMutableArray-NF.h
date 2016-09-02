//
//  NSMutableArray-NF.h
//  Cupcake
//
//  Created by William Locke on 12/3/12.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSMutableArray (NF)

-(void)addInt:(int)number;
-(BOOL)containsObjectsFromArray:(NSArray *)array;



// Queue
- (id) dequeue;
- (void) enqueue:(id)obj;


// Stack
- (void) push: (id)item;
- (id) pop;
- (id) peek;


@end
