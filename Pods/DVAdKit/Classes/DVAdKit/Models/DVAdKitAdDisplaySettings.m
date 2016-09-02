#import "DVAdKitAdDisplaySettings.h"

@implementation DVAdKitAdDisplaySettings

@synthesize adSoundLink;
@synthesize animationStyle;
@synthesize shouldPresentAppStoreInsideApp;

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.adSoundLink forKey:@"adSoundLink"];
    [encoder encodeObject:self.animationStyle forKey:@"animationStyle"];
    [encoder encodeObject:[NSNumber numberWithBool:self.shouldPresentAppStoreInsideApp] forKey:@"shouldPresentAppStoreInsideApp"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super init])) {
        self.adSoundLink = [decoder decodeObjectForKey:@"adSoundLink"];
        self.animationStyle = [decoder decodeObjectForKey:@"animationStyle"];
        self.shouldPresentAppStoreInsideApp = [(NSNumber *)[decoder decodeObjectForKey:@"shouldPresentAppStoreInsideApp"] boolValue];
    }
    return self;
}

+ (DVAdKitAdDisplaySettings *)instanceFromDictionary:(NSDictionary *)aDictionary
{

    DVAdKitAdDisplaySettings *instance = [[DVAdKitAdDisplaySettings alloc] init];
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

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}


- (NSDictionary *)dictionaryRepresentation
{

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    if (self.adSoundLink) {
        [dictionary setObject:self.adSoundLink forKey:@"adSoundLink"];
    }

    if (self.animationStyle) {
        [dictionary setObject:self.animationStyle forKey:@"animationStyle"];
    }

    [dictionary setObject:[NSNumber numberWithBool:self.shouldPresentAppStoreInsideApp] forKey:@"shouldPresentAppStoreInsideApp"];

    return dictionary;

}


@end
