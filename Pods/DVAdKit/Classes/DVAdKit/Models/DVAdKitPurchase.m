#import "DVAdKitPurchase.h"

#import "DVAdKitApp.h"
#import "DVAdKitDevice.h"

@implementation DVAdKitPurchase

@synthesize app;
@synthesize appId;
@synthesize device;
@synthesize deviceId;
@synthesize identifier;
@synthesize localizedTitle;
@synthesize price;
@synthesize priceLocale;
@synthesize productIdentifier;

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.app forKey:@"app"];
    [encoder encodeObject:self.appId forKey:@"appId"];
    [encoder encodeObject:self.device forKey:@"device"];
    [encoder encodeObject:self.deviceId forKey:@"deviceId"];
    [encoder encodeObject:self.identifier forKey:@"identifier"];
    [encoder encodeObject:self.localizedTitle forKey:@"localizedTitle"];
    [encoder encodeObject:self.price forKey:@"price"];
    [encoder encodeObject:self.priceLocale forKey:@"priceLocale"];
    [encoder encodeObject:self.productIdentifier forKey:@"productIdentifier"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super init])) {
        self.app = [decoder decodeObjectForKey:@"app"];
        self.appId = [decoder decodeObjectForKey:@"appId"];
        self.device = [decoder decodeObjectForKey:@"device"];
        self.deviceId = [decoder decodeObjectForKey:@"deviceId"];
        self.identifier = [decoder decodeObjectForKey:@"identifier"];
        self.localizedTitle = [decoder decodeObjectForKey:@"localizedTitle"];
        self.price = [decoder decodeObjectForKey:@"price"];
        self.priceLocale = [decoder decodeObjectForKey:@"priceLocale"];
        self.productIdentifier = [decoder decodeObjectForKey:@"productIdentifier"];
    }
    return self;
}

+ (DVAdKitPurchase *)instanceFromDictionary:(NSDictionary *)aDictionary
{

    DVAdKitPurchase *instance = [[DVAdKitPurchase alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary
{

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    [self setValuesForKeysWithDictionary:aDictionary];

}

- (void)setValue:(id)value forKey:(NSString *)key
{

    if ([key isEqualToString:@"app"]) {

        if ([value isKindOfClass:[NSDictionary class]]) {
            self.app = [DVAdKitApp instanceFromDictionary:value];
        }

    } else if ([key isEqualToString:@"device"]) {

        if ([value isKindOfClass:[NSDictionary class]]) {
            self.device = [DVAdKitDevice instanceFromDictionary:value];
        }

    } else {
        [super setValue:value forKey:key];
    }

}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

    if ([key isEqualToString:@"app_id"]) {
        [self setValue:value forKey:@"appId"];
    } else if ([key isEqualToString:@"device_id"]) {
        [self setValue:value forKey:@"deviceId"];
    } else if ([key isEqualToString:@"localized_title"]) {
        [self setValue:value forKey:@"localizedTitle"];
    } else if ([key isEqualToString:@"price_locale"]) {
        [self setValue:value forKey:@"priceLocale"];
    } else if ([key isEqualToString:@"product_identifier"]) {
        [self setValue:value forKey:@"productIdentifier"];
    } else {
        [super setValue:value forUndefinedKey:key];
    }

}


- (NSDictionary *)dictionaryRepresentation
{

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    if (self.app) {
        [dictionary setObject:self.app forKey:@"app"];
    }

    if (self.appId) {
        [dictionary setObject:self.appId forKey:@"appId"];
    }

    if (self.device) {
        [dictionary setObject:self.device forKey:@"device"];
    }

    if (self.deviceId) {
        [dictionary setObject:self.deviceId forKey:@"deviceId"];
    }

    if (self.identifier) {
        [dictionary setObject:self.identifier forKey:@"identifier"];
    }
    if (self.localizedTitle) {
        [dictionary setObject:self.identifier forKey:@"localizedTitle"];
    }

    if (self.price) {
        [dictionary setObject:self.price forKey:@"price"];
    }

    if (self.priceLocale) {
        [dictionary setObject:self.priceLocale forKey:@"priceLocale"];
    }

    if (self.productIdentifier) {
        [dictionary setObject:self.productIdentifier forKey:@"productIdentifier"];
    }

    return dictionary;

}


@end
