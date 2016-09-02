//
//  NFJsonPath.h
//  Pods
//
//  Created by William Locke on 1/31/13.
//
//

#import <UIKit/UIKit.h>

typedef enum {
  NFJsonPathPartTypeNone,
  NFJsonPathPartTypeKey,
  NFJsonPathPartTypeIndexSet,
  NFJsonPathPartTypeIndexRange,
  NFJsonPathPartTypeIndex
} NFJsonPathPartType;

@interface NFJsonPath : NSObject


//+(id)valueForJsonPathPart:(NSString*)part inObject:(id)currentObj;


+(id)valueForJsonPath:(NSString*)fullPath inObject:(id)currentObj;


@end
