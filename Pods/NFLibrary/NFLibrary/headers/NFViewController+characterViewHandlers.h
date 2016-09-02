//
//  ViewController+frozen.h
//  BabyMommyStory
//
//  Created by William Locke on 6/6/14.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NFViewController.h"
#import "NFImageViewObject.h"
#import "NFCharacterView.h"

typedef enum {
    NFCharacterViewContentModeImageViewsSizedToImages,
    NFCharacterViewContentModeTopLeft,
    NFCharacterViewContentModeScaleToFill
    }NFCharacterViewContentMode;

@interface NFViewController (characterViewHandlers)

-(NSArray *)updateCharacterIdentifierOrderWithNormalLayerOrder:(NSArray *)identifiers;

-(NFImageViewObject *)imageViewObjectInImageViewObjects:(NSMutableArray *)imageViewObjects withIdentifier:(NSString *)imageViewIdentifier;
-(NSMutableArray *)imageViewObjectsForCharacterViewWithIdentifiers:(NSArray *)imageViewIdentifiers  withCharacterImagesBaseFolderKeyPath:(NSString *)characterImagesBaseFolderKeyPath clothingImagesBaseFolderKeyPath:(NSString *)clothingImagesBaseFolderKeyPath characterIndex:(NSNumber *)characterIndex;
-(void)layoutCharacterView:(NFCharacterView *)characterView withCharacterImagesBaseFolderKeyPath:(NSString *)characterImagesBaseFolderKeyPath clothingImagesBaseFolderKeyPath:(NSString *)clothingImagesBaseFolderKeyPath imageViewIdentifiers:(NSArray *)imageViewIdentifiers characterIndex:(NSNumber *)characterIndex;

-(NFCharacterView *)layoutCharacterView:(NFCharacterView *)characterView withImageViewObjects:(NSMutableArray *)imageViewObjects __attribute__((deprecated));
-(void)layoutCharacterView:(NFCharacterView *)characterView withCharacterImageViewObjects:(NSMutableArray *)imageViewObjects;

-(void)sizeImageViewsToImagesForCharacterView:(NFCharacterView *)characterView;
-(void)sizeImageViewsToImagesForCharacterView:(NFCharacterView *)characterView withContentMode:(NFCharacterViewContentMode)contentMode;
    
-(NSArray *)arrayOfFolderNamesForFoldersAtImagesKeyPath:(NSString *)keyPath;


-(NFImageViewObject *)addImageViewObjectToArray:(NSMutableArray *)imageViewObjects withIdentifier:(NSString *)item imageIndex:(NSNumber *)imageIndex imageNames:(NSArray *)imageNames;
-(NFImageViewObject *)addImageViewObjectToArray:(NSMutableArray *)imageViewObjects withIdentifier:(NSString *)item imageIndex:(NSNumber *)imageIndex imageNames:(NSArray *)imageNames animated:(NSNumber *)animated animationTiming:(NSArray *)animationTiming;
-(NSMutableArray *)addMultipleImageViewObjectsToArray:(NSMutableArray *)imageViewObjects withBaseIdentifier:(NSString *)baseIdentifier imageNames:(NSArray *)imageNames;

-(int)hideRandomNumberOfImageViewsInCharacterView:(NFCharacterView *)characterView withIdentifiers:(NSArray *)identifiers minimumNumberToHide:(int)mininumNumberToHide maximumNumberToHide:(int)maximumNumberToHide;


-(void)updateImageViewObjects:(NSMutableArray *)imageViewObjects withCharacterIndexes:(NSDictionary *)characterIndexes;
-(NSMutableDictionary *)updateCharacterIndexes:(NSMutableDictionary *)characterIndexes forIdentifier:(NSString *)identifier withIndex:(int)index withCharacterView:(NFCharacterView *)characterView;
-(NSMutableDictionary *)updateCharacterIndexes:(NSMutableDictionary *)characterIndexes forIdentifier:(NSString *)identifier withIndex:(int)index andImageNames:(NSArray *)imageNames;

-(NSMutableDictionary *)updateCharacterIndexes:(NSMutableDictionary *)characterIndexes forIdentifier:(NSString *)identifier withIndex:(int)index;

-(NSArray *)characterViewIdentifiersForCharacterImagesBaseFolderKeyPath:(NSString *)characterImagesBaseFolderKeyPath clothingImagesBaseFolderKeyPath:(NSString *)clothingImagesBaseFolderKeyPath;

@end
