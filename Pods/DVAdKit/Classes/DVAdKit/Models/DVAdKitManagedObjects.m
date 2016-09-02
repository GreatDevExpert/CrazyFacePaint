//
//  ManagedObjects.m
//  MonsterCafe
//
//  Created by William Locke on 5/24/13.
//  Copyright (c) 2013 Ninjafish Studios. All rights reserved.
//

#import "DVAdKitManagedObjects.h"
#import "DVDataStore.h"
#import "DVAdKitApp.h"
#import "DVAdKitDevice.h"
#import "DVDate.h"
#import "DVAdKitImpression.h"


NSString *const kDVAdKitManagedObjectKeyDevice = @"DVAdKitManagedObjectKeyDevice";
NSString *const kDVAdKitManagedObjectKeyApp = @"DVAdKitManagedObjectKeyApp";
NSString *const kDVAdKitManagedObjectKeyLastImpression = @"DVAdKitManagedObjectKeyLastImpression";
NSString *const kDVAdKitManagedObjectKeyImpressionsShown = @"DVAdKitManagedObjectKeyImpressionsShown";
NSString *const kDVAdKitManagedObjectKeyAppsInstalled = @"DVAdKitManagedObjectKeyAppsInstalled";
NSString *const kDVAdKitManagedObjectKeyAppDataLastQueriedAt = @"DVAdKitManagedObjectKeyAppDataLastQueriedAt";
NSString *const kDVAdKitManagedObjectKeyAppsInstalledDataLastQueriedAt = @"DVAdKitManagedObjectKeyAppsInstalledDataLastQueriedAt";
NSString *const kDVAdKitManagedObjectKeyBlockAdRequestsUntil = @"DVAdKitManagedObjectKeyBlockAdRequestsUntil";


@implementation DVAdKitManagedObjects

+ (DVAdKitManagedObjects *)sharedInstance
{
    // structure used to test whether the block has completed or not
    static dispatch_once_t p = 0;
    
    // initialize sharedObject as nil (first call only)
    __strong static id _sharedObject = nil;
    
    // executes a block object once and only once for the lifetime of an application
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    
    // returns the same object each time
    return _sharedObject;
}


-(DVAdKitDevice *)device{
    if (!_device) {
        _device = [NSKeyedUnarchiver objectForKey:kDVAdKitManagedObjectKeyDevice];
        if(!_device){
            return nil;
        }
    }
    return _device;
}

-(void)saveDevice{
    [NSKeyedArchiver archiveObject:_device forKey:kDVAdKitManagedObjectKeyDevice];
}

-(DVAdKitImpression *)lastImpression{
    if (!_lastImpression) {
        _lastImpression = [NSKeyedUnarchiver objectForKey:kDVAdKitManagedObjectKeyLastImpression];
        if(!_lastImpression){
            return nil;
        }
    }
    return _lastImpression;
}

-(void)saveLastImpression{
    [NSKeyedArchiver archiveObject:_lastImpression forKey:kDVAdKitManagedObjectKeyLastImpression];
}

-(NSMutableArray *)impressionsShown{
    if (!_impressionsShown) {
        _impressionsShown = [NSKeyedUnarchiver objectForKey:kDVAdKitManagedObjectKeyImpressionsShown];
        if(!_impressionsShown){
            _impressionsShown = [[NSMutableArray alloc] init];
        }
    }
    return _impressionsShown;
}

-(void)saveImpressionsShown{
    [NSKeyedArchiver archiveObject:_impressionsShown forKey:kDVAdKitManagedObjectKeyImpressionsShown];
}

-(void)addImpressionToImpressionsShown:(DVAdKitImpression *)impression{
    int maxImpressionsShownLength = 10;
    _impressionsShown = [self impressionsShown];
    
    NSMutableArray *impressionsToRemove = [[NSMutableArray alloc] init];
    for(int i=0; i < [_impressionsShown count]; i++){
        DVAdKitImpression *shownImpression = [_impressionsShown objectAtIndex:i];
        if(shownImpression.createdAt){
            NSDate *date = [DVDate dateFromString:shownImpression.createdAt];
            if(date){
                if([[NSDate date] timeIntervalSince1970] - [date timeIntervalSince1970] > kDVDateTimeIntervalOneHour){
                    [impressionsToRemove addObject:shownImpression];
                }
            }
        }
    }
    for(DVAdKitImpression *impressionToRemove in impressionsToRemove){
        int index = [_impressionsShown indexOfObject:impressionToRemove];
        if(index != NSNotFound){
            if(index < [_impressionsShown count]){
                [_impressionsShown removeObjectAtIndex:index];
            }
        }
    }
    
    [_impressionsShown addObject:impression];
}


-(NSMutableArray *)appsInstalled{
    if (!_appsInstalled) {
        _appsInstalled = [NSKeyedUnarchiver objectForKey:kDVAdKitManagedObjectKeyAppsInstalled];
        if(!_appsInstalled){
            _appsInstalled = [[NSMutableArray alloc] init];
        }
    }
    return _appsInstalled;
}

-(void)saveAppsInstalled{
    [NSKeyedArchiver archiveObject:_appsInstalled forKey:kDVAdKitManagedObjectKeyAppsInstalled];
}



-(DVAdKitApp *)app{
    if (!_app) {
        _app = [NSKeyedUnarchiver objectForKey:kDVAdKitManagedObjectKeyApp];
        if(!_app){
            return nil;
        }
    }
    return _app;
}

-(void)saveApp{
    [NSKeyedArchiver archiveObject:_app forKey:kDVAdKitManagedObjectKeyApp];
}


-(NSDate *)appDataLastQueriedAt{
    if (!_appDataLastQueriedAt) {
        _appDataLastQueriedAt = [NSKeyedUnarchiver objectForKey:kDVAdKitManagedObjectKeyAppDataLastQueriedAt];
    }
    return _appDataLastQueriedAt;
}

-(void)saveAppDataLastQueriedAt{
    [NSKeyedArchiver archiveObject:_appDataLastQueriedAt forKey:kDVAdKitManagedObjectKeyAppDataLastQueriedAt];
}


-(NSDate *)blockAdRequestsUntil{
    if (!_blockAdRequestsUntil) {
        _blockAdRequestsUntil = [NSKeyedUnarchiver objectForKey:kDVAdKitManagedObjectKeyBlockAdRequestsUntil];
    }
    return _blockAdRequestsUntil;
}

-(void)saveBlockAdRequestsUntil{
    [NSKeyedArchiver archiveObject:_blockAdRequestsUntil forKey:kDVAdKitManagedObjectKeyBlockAdRequestsUntil];
}





-(NSDate *)appsInstalledDataLastQueriedAt{
    if (!_appsInstalledDataLastQueriedAt) {
        _appsInstalledDataLastQueriedAt = [NSKeyedUnarchiver objectForKey:kDVAdKitManagedObjectKeyAppsInstalledDataLastQueriedAt];
    }
    return _appDataLastQueriedAt;
}

-(void)saveAppsInstalledDataLastQueriedAt{
    [NSKeyedArchiver archiveObject:_appsInstalledDataLastQueriedAt forKey:kDVAdKitManagedObjectKeyAppsInstalledDataLastQueriedAt];
}


-(void)saveManagedObjects{
    [self saveDevice];
    [self saveApp];
    [self saveLastImpression];

    [self saveImpressionsShown];
    [self saveAppDataLastQueriedAt];
}


@end
