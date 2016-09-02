#import <UIKit/UIKit.h>

@interface NFDeviceProfile : NSObject <NSCoding> {

    NSNumber *purcaseCount;
    NSNumber *purchaseAmount;
    NSNumber *purchaseLifetimeAmount;
    NSNumber *sessionCount;
    NSNumber *sessionLifetimeCount;

}

@property (nonatomic, copy) NSNumber *purcaseCount;
@property (nonatomic, copy) NSNumber *purchaseAmount;
@property (nonatomic, copy) NSNumber *purchaseLifetimeAmount;
@property (nonatomic, copy) NSNumber *sessionCount;
@property (nonatomic, copy) NSNumber *sessionLifetimeCount;

+ (NFDeviceProfile *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
