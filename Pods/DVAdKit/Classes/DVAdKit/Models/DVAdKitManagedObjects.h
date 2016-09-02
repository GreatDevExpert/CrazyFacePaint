//
//  ManagedObjects.h
//  MonsterCafe
//
//  Created by William Locke on 5/24/13.
//  Copyright (c) 2013 Ninjafish Studios. All rights reserved.
//

#import <Foundation/Foundation.h>
@class DVAdKitManagedObjects;
@class DVAdKitApp;
@class DVAdKitDevice;
@class DVAdKitImpression;

@interface DVAdKitManagedObjects : NSObject

@property (nonatomic, strong) DVAdKitDevice *device;
@property (nonatomic, strong) DVAdKitApp *app;
@property (nonatomic, strong) DVAdKitImpression *lastImpression;
@property (nonatomic, strong) NSMutableArray *impressionsShown;
@property (nonatomic, strong) NSMutableArray *appsInstalled;
@property (nonatomic, strong) NSDate *appDataLastQueriedAt;
@property (nonatomic, strong) NSDate *appsInstalledDataLastQueriedAt;
@property (nonatomic, strong) NSDate *blockAdRequestsUntil;



+ (DVAdKitManagedObjects *)sharedInstance;

-(void)saveLastImpression;

-(NSMutableArray *)impressionsShown;
-(void)saveImpressionsShown;
-(void)addImpressionToImpressionsShown:(DVAdKitImpression *)impression;

-(void)saveApp;


-(NSMutableArray *)appsInstalled;
-(void)saveAppsInstalled;

-(NSDate *)appsInstalledDataLastQueriedAt;
-(void)saveAppsInstalledDataLastQueriedAt;


-(NSDate *)appDataLastQueriedAt;
-(void)saveAppDataLastQueriedAt;


-(NSDate *)blockAdRequestsUntil;
-(void)saveBlockAdRequestsUntil;


-(void)saveDevice;

-(void)saveManagedObjects;


@end
