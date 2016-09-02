#import <Foundation/Foundation.h>

@class DVAdKitApp;
@class DVAdKitDevice;

@interface DVAdKitPurchase : NSObject <NSCoding> {

    DVAdKitApp *app;
    NSNumber *appId;
    DVAdKitDevice *device;
    NSNumber *deviceId;
    NSNumber *identifier;
    NSString *localizedTitle;
    NSNumber *price;
    NSString *priceLocale;
    NSString *productIdentifier;

}

@property (nonatomic, strong) DVAdKitApp *app;
@property (nonatomic, copy) NSNumber *appId;
@property (nonatomic, strong) DVAdKitDevice *device;
@property (nonatomic, copy) NSNumber *deviceId;
@property (nonatomic, copy) NSNumber *identifier;
@property (nonatomic, copy) NSString *localizedTitle;
@property (nonatomic, copy) NSNumber *price;
@property (nonatomic, copy) NSString *priceLocale;
@property (nonatomic, copy) NSString *productIdentifier;


+ (DVAdKitPurchase *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
