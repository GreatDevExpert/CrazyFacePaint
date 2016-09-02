//
//  NFWebApiResponseData.h
//  Pods
//
//  Created by William Locke on 3/21/13.
//
//

#import <Foundation/Foundation.h>
@class DVWebApiResponseDataError;

@protocol DVWebApiResponseData <NSObject>

@property (nonatomic, copy) NSNumber *currentItemCount;
@property (nonatomic, assign) BOOL deleted;
@property (nonatomic, copy) NSString *editLink;
@property (nonatomic, copy) NSString *etag;
@property (nonatomic, copy) NSString *fields;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, copy) NSNumber *itemsPerPage;
@property (nonatomic, copy) NSString *kind;
@property (nonatomic, copy) NSString *lang;
@property (nonatomic, copy) NSString *nextLink;
@property (nonatomic, copy) NSNumber *pageIndex;
@property (nonatomic, copy) NSString *pagingLinkTemplate;
@property (nonatomic, copy) NSString *previousLink;
@property (nonatomic, copy) NSString *selfLink;
@property (nonatomic, copy) NSNumber *startIndex;
@property (nonatomic, copy) NSNumber *totalItems;
@property (nonatomic, copy) NSNumber *totalPages;
@property (nonatomic, copy) NSString *updated;
@property (nonatomic, strong) NSData *data;

@property (nonatomic, strong) id rawObject;


@required
-(void)initWithData:(NSData *)data;

@end


@interface DVWebApiResponseData : NSObject <NSCoding, DVWebApiResponseData> {
    NSNumber *currentItemCount;
    BOOL deleted;
    NSString *editLink;
    DVWebApiResponseDataError *error;
    NSString *etag;
    NSString *fields;
    NSString *identifier;
    NSMutableArray *items;
    NSNumber *itemsPerPage;
    NSString *kind;
    NSString *lang;
    NSString *nextLink;
    NSNumber *pageIndex;
    NSString *pagingLinkTemplate;
    NSString *previousLink;
    NSString *selfLink;
    NSNumber *startIndex;
    NSNumber *totalItems;
    NSNumber *totalPages;
    NSString *updated;
}

@property (nonatomic, copy) NSNumber *currentItemCount;
@property (nonatomic, assign) BOOL deleted;
@property (nonatomic, copy) NSString *editLink;
@property (nonatomic, strong) DVWebApiResponseDataError *error;
@property (nonatomic, copy) NSString *etag;
@property (nonatomic, copy) NSString *fields;
@property (nonatomic, copy) NSString *identifier;
@property (nonatomic, copy) NSMutableArray *items;
@property (nonatomic, copy) NSNumber *itemsPerPage;
@property (nonatomic, copy) NSString *kind;
@property (nonatomic, copy) NSString *lang;
@property (nonatomic, copy) NSString *nextLink;
@property (nonatomic, copy) NSNumber *pageIndex;
@property (nonatomic, copy) NSString *pagingLinkTemplate;
@property (nonatomic, copy) NSString *previousLink;
@property (nonatomic, copy) NSString *selfLink;
@property (nonatomic, copy) NSNumber *startIndex;
@property (nonatomic, copy) NSNumber *totalItems;
@property (nonatomic, copy) NSNumber *totalPages;
@property (nonatomic, copy) NSString *updated;

// TODO: remove
@property (nonatomic, strong) id rawObject;
@property (nonatomic, strong) NSData *data;

+ (DVWebApiResponseData *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;




- (id)initWithNSURLResponseData:(NSData *)data;

@end
