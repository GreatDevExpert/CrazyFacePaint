#import <UIKit/UIKit.h>

@interface NFAnalyticsProfile : NSObject <NSCoding> {

    NSNumber *count;

}

@property (nonatomic, copy) NSNumber *count;

+ (NFAnalyticsProfile *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
