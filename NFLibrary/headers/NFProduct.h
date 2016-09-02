/** @warning *Important:* This class is created automatically using Objectify (http://tigerbears.com/objectify/). Code should not be modified directly but rather should use products.json file to create class. Update https://github.com/ninjafishstudios/ninjafish-templates/edit/master/App/App/Resources/Json/Product.example.json then run through program.
 */
//
//  NFProduct.h
//
//
//  Created by ___FULLUSERNAME___ on 5/23/13.
//  Copyright (c) 2013. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NFProduct : NSObject <NSCoding> {
    
    NSMutableArray *downloadImagesKeyPaths;
    BOOL downloadOnPurchase;
    NSMutableArray *downloadOnPurchaseDevices;
    BOOL downloading;
    NSString *identifier;
    NSString *imagesKeyPath;
    NSMutableArray *imagesKeyPaths;
    BOOL isPartOfPack;
    NSNumber *lockedIndex;
    NSMutableArray *lockedViewControllers;
    NSString *name;
    NSNumber *price;
    NSMutableArray *productsUnlockedUponPurchase;
    NSString *storeImage;
    NSString *thumbImagesKeyPath;
    NSNumber *tier;
    BOOL unlockEverything;
    NSNumber *virtualCurrencyAmount;
    BOOL watchToUnlock;
}

@property (nonatomic, copy) NSMutableArray *downloadImagesKeyPaths;
@property (nonatomic, assign) BOOL downloadOnPurchase;
@property (nonatomic, copy) NSMutableArray *downloadOnPurchaseDevices;
@property (nonatomic, assign) BOOL downloading;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSString *imagesKeyPath;
@property (nonatomic, copy) NSMutableArray *imagesKeyPaths;
@property (nonatomic, assign) BOOL isPartOfPack;
@property (nonatomic, copy) NSNumber *lockedIndex;
@property (nonatomic, copy) NSMutableArray *lockedViewControllers;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSNumber *price;
@property (nonatomic, copy) NSMutableArray *productsUnlockedUponPurchase;
@property (nonatomic, copy) NSString *storeImage;
@property (nonatomic, copy) NSString *thumbImagesKeyPath;
@property (nonatomic, copy) NSNumber *tier;
@property (nonatomic, assign) BOOL unlockEverything;
@property (nonatomic, copy) NSNumber *virtualCurrencyAmount;
@property (nonatomic, assign) BOOL watchToUnlock;

+ (NFProduct *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
