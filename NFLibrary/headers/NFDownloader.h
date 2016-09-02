//
//  NFDownloader.h
//
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
@class NFHttpFileDownload;
@class NFStore;

typedef enum {
    NFDownloaderStatusNone = 0,
    NFDownloaderStatusInProgress = 1,
    NFDownloaderStatusDone = 2,
    NFDownloaderStatusDontDownload = 3,
    NFDownloaderStatusHaltedByNoConnection = 4,
    NFDownloaderStatusHaltedByError = 5
}NFDownloaderStatus;

extern NSString * const kNFDownloaderFinshedDownloading;


// TODO: separate UI stuff from downloading stuff.
// Move UI stuff to its own class.
@interface NFDownloader : NSObject

@property (nonatomic, retain) NSMutableArray *items;
@property (nonatomic, retain) NSMutableArray *downloadedItems;
@property (nonatomic, retain) NSMutableArray *undownloadedItems;
@property (nonatomic, retain) NSString *errorMessage;
@property BOOL done;
@property BOOL error;
@property NFDownloaderStatus downloaderStatus;
@property (nonatomic, retain) NSString *key;
@property BOOL saveAfterEachDownload;

/***
 * Set these to indicate which downloads have completed.
 * For instance, the downloader might be downloading images for 3 different
 * product purchases, so the keys that store the persistent information that
 * these downloads have been made should be added to this array. 
 */
@property NSMutableArray *downloadKeys;


typedef void (^ NFDownloaderCallback)(NFDownloaderStatus downloaderStatus, NSError *error);

-(void)download:(NFDownloaderCallback)callback;
-(float)percentComplete;
- (id)initWithItems:(NSMutableArray *)items;
- (id)initWithImagesDictionary:(NSMutableDictionary *)imagesDictionary;

+(void)configureWithDomainName:(NSString *)domainName;
+(NFDownloader *)sharedNFDownloader;
+(NFDownloader *)sharedNFDownloaderWithItems:(NSMutableArray *)items;
+(NSMutableArray *)downloadsForItems:(NSMutableDictionary *)items;


#pragma mark Parsing code
+(void)autoCreateDownloadImagesFile;
-(void)showDownloaderInViewController:(UIViewController *)viewController callback:(NFDownloaderCallback)callback;
+(BOOL)imagesForSectionAreDownloaded:(NSString *)section;
+(void)setImagesForSectionDownloaded:(NSString *)section;
+(NSString *)imageSectionKeyForSection:(NSString *)section;
+(void)setAllowHighResDownloads:(BOOL)allowHighResDownloads;

#pragma mark Data functions
+(void)downloadContentForProductsAlreadyBoughtUsingContentDictionary:(NSMutableDictionary *)contentDictionary store:(NFStore *)store;
+(void)downloadHDImagesFromContentDictionaryAfterPrompt:(NSMutableDictionary *)contentDictionary;
-(void)addItemsFromImagesDictionary:(NSMutableDictionary *)imagesDictionary;
-(void)downloadWithKey:(NSString *)downloadKey callback:(NFDownloaderCallback)callback;
+(BOOL)valueForDownloadKey:(NSString *)downloadKey;


#pragma mark Reset
-(void)reset;

+(BOOL)valueForDownloadKey:(NSString *)downloadKey;

@end
