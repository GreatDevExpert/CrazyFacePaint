
#import "DVWebApiResponseData.h"

#import "DVWebApiResponseDataError.h"

#import "DVDataStore.h"

@implementation DVWebApiResponseData

@synthesize currentItemCount;
@synthesize deleted;
@synthesize editLink;
@synthesize error;
@synthesize etag;
@synthesize fields;
@synthesize identifier;
@synthesize items;
@synthesize itemsPerPage;
@synthesize kind;
@synthesize lang;
@synthesize nextLink;
@synthesize pageIndex;
@synthesize pagingLinkTemplate;
@synthesize previousLink;
@synthesize selfLink;
@synthesize startIndex;
@synthesize totalItems;
@synthesize totalPages;
@synthesize updated;

- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.currentItemCount forKey:@"currentItemCount"];
    [encoder encodeObject:[NSNumber numberWithBool:self.deleted] forKey:@"deleted"];
    [encoder encodeObject:self.editLink forKey:@"editLink"];
    [encoder encodeObject:self.error forKey:@"error"];
    [encoder encodeObject:self.etag forKey:@"etag"];
    [encoder encodeObject:self.fields forKey:@"fields"];
    [encoder encodeObject:self.identifier forKey:@"identifier"];
    [encoder encodeObject:self.items forKey:@"items"];
    [encoder encodeObject:self.itemsPerPage forKey:@"itemsPerPage"];
    [encoder encodeObject:self.kind forKey:@"kind"];
    [encoder encodeObject:self.lang forKey:@"lang"];
    [encoder encodeObject:self.nextLink forKey:@"nextLink"];
    [encoder encodeObject:self.pageIndex forKey:@"pageIndex"];
    [encoder encodeObject:self.pagingLinkTemplate forKey:@"pagingLinkTemplate"];
    [encoder encodeObject:self.previousLink forKey:@"previousLink"];
    [encoder encodeObject:self.selfLink forKey:@"selfLink"];
    [encoder encodeObject:self.startIndex forKey:@"startIndex"];
    [encoder encodeObject:self.totalItems forKey:@"totalItems"];
    [encoder encodeObject:self.totalPages forKey:@"totalPages"];
    [encoder encodeObject:self.updated forKey:@"updated"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    if ((self = [super init])) {
        self.currentItemCount = [decoder decodeObjectForKey:@"currentItemCount"];
        self.deleted = [(NSNumber *)[decoder decodeObjectForKey:@"deleted"] boolValue];
        self.editLink = [decoder decodeObjectForKey:@"editLink"];
        self.error = [decoder decodeObjectForKey:@"error"];
        self.etag = [decoder decodeObjectForKey:@"etag"];
        self.fields = [decoder decodeObjectForKey:@"fields"];
        self.identifier = [decoder decodeObjectForKey:@"identifier"];
        self.items = [decoder decodeObjectForKey:@"items"];
        self.itemsPerPage = [decoder decodeObjectForKey:@"itemsPerPage"];
        self.kind = [decoder decodeObjectForKey:@"kind"];
        self.lang = [decoder decodeObjectForKey:@"lang"];
        self.nextLink = [decoder decodeObjectForKey:@"nextLink"];
        self.pageIndex = [decoder decodeObjectForKey:@"pageIndex"];
        self.pagingLinkTemplate = [decoder decodeObjectForKey:@"pagingLinkTemplate"];
        self.previousLink = [decoder decodeObjectForKey:@"previousLink"];
        self.selfLink = [decoder decodeObjectForKey:@"selfLink"];
        self.startIndex = [decoder decodeObjectForKey:@"startIndex"];
        self.totalItems = [decoder decodeObjectForKey:@"totalItems"];
        self.totalPages = [decoder decodeObjectForKey:@"totalPages"];
        self.updated = [decoder decodeObjectForKey:@"updated"];
    }
    return self;
}

+ (DVWebApiResponseData *)instanceFromDictionary:(NSDictionary *)aDictionary
{
    
    DVWebApiResponseData *instance = [[DVWebApiResponseData alloc] init];
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
    
    if ([key isEqualToString:@"error"]) {
        
        if ([value isKindOfClass:[NSDictionary class]]) {
            self.error = [DVWebApiResponseDataError instanceFromDictionary:value];
        }
        
    } else if ([key isEqualToString:@"items"]) {
        
        if ([value isKindOfClass:[NSArray class]])
        {
            
            NSMutableArray *myMembers = [NSMutableArray arrayWithCapacity:[value count]];
            for (id valueMember in value) {
                [myMembers addObject:valueMember];
            }
            
            self.items = myMembers;
            
        }
        
    } else {
        [super setValue:value forKey:key];
    }
    
}


- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
    if ([key isEqualToString:@"id"]) {
        [self setValue:value forKey:@"identifier"];
    } else {
        [super setValue:value forUndefinedKey:key];
    }
    
}


- (NSDictionary *)dictionaryRepresentation
{
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if (self.currentItemCount) {
        [dictionary setObject:self.currentItemCount forKey:@"currentItemCount"];
    }
    
    [dictionary setObject:[NSNumber numberWithBool:self.deleted] forKey:@"deleted"];
    
    if (self.editLink) {
        [dictionary setObject:self.editLink forKey:@"editLink"];
    }
    
    if (self.error) {
        [dictionary setObject:self.error forKey:@"error"];
    }
    
    if (self.etag) {
        [dictionary setObject:self.etag forKey:@"etag"];
    }
    
    if (self.fields) {
        [dictionary setObject:self.fields forKey:@"fields"];
    }
    
    if (self.identifier) {
        [dictionary setObject:self.identifier forKey:@"identifier"];
    }
    
    if (self.items) {
        [dictionary setObject:self.items forKey:@"items"];
    }
    
    if (self.itemsPerPage) {
        [dictionary setObject:self.itemsPerPage forKey:@"itemsPerPage"];
    }
    
    if (self.kind) {
        [dictionary setObject:self.kind forKey:@"kind"];
    }
    
    if (self.lang) {
        [dictionary setObject:self.lang forKey:@"lang"];
    }
    
    if (self.nextLink) {
        [dictionary setObject:self.nextLink forKey:@"nextLink"];
    }
    
    if (self.pageIndex) {
        [dictionary setObject:self.pageIndex forKey:@"pageIndex"];
    }
    
    if (self.pagingLinkTemplate) {
        [dictionary setObject:self.pagingLinkTemplate forKey:@"pagingLinkTemplate"];
    }
    
    if (self.previousLink) {
        [dictionary setObject:self.previousLink forKey:@"previousLink"];
    }
    
    if (self.selfLink) {
        [dictionary setObject:self.selfLink forKey:@"selfLink"];
    }
    
    if (self.startIndex) {
        [dictionary setObject:self.startIndex forKey:@"startIndex"];
    }
    
    if (self.totalItems) {
        [dictionary setObject:self.totalItems forKey:@"totalItems"];
    }
    
    if (self.totalPages) {
        [dictionary setObject:self.totalPages forKey:@"totalPages"];
    }
    
    if (self.updated) {
        [dictionary setObject:self.updated forKey:@"updated"];
    }
    
    return dictionary;
    
}


- (id)initWithNSURLResponseData:(NSData *)data
{
    NSObject *jsonObject = [DVDataStore jsonObjectFromData:data];
    if(!jsonObject){
        return [super init];
    }else if([jsonObject isKindOfClass:[NSDictionary class]]){
        if([((NSDictionary *)jsonObject) objectForKey:@"data"]){
            
        }
        DVWebApiResponseData *responseData = [DVWebApiResponseData instanceFromDictionary:(NSDictionary *)jsonObject];
        
        // TODO: remove
        responseData.rawObject = jsonObject;
        
        return responseData;
    }else if([jsonObject isKindOfClass:[NSArray class]]){
        self = [super init];
        if(self){
            self.items = (NSMutableArray *)jsonObject;
        }
    }
    
 
    return [super init];
}

@end


