//
//  Store.h
//  NinjafishStudiosApp
//
//  Created by William Locke on 11/20/12.
//  Copyright (c) 2012 William Locke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NFStore.h"


//#NFConstantsBegin

extern NSString * const kProductIdNameRemoveAds;
extern NSString * const kProductIdNameUnlockAllCharacters;
extern NSString * const kProductIdNameAllRegularFacePaint;
extern NSString * const kProductIdNameRegularBench1;
extern NSString * const kProductIdNameRegularBench2;
extern NSString * const kProductIdNameAllSparkleFacePaint;
extern NSString * const kProductIdNameAllPatternFacePaint;
extern NSString * const kProductIdNameAllColorfulFacePaint;
extern NSString * const kProductIdNameUnlockAllHats;
extern NSString * const kProductIdNameUnlockAllHair;
extern NSString * const kProductIdNameUnlockAllGlasses;
extern NSString * const kProductIdNameAllFairyFacePaintDesignsandDressUps;
extern NSString * const kProductIdNameFairyBench1;
extern NSString * const kProductIdNameFairyBench2;
extern NSString * const kProductIdNameUnlockAllFairyAccessories;
extern NSString * const kProductIdNameUnlockAllFairyEarrings;
extern NSString * const kProductIdNameUnlockAllFairyGlasses;
extern NSString * const kProductIdNameUnlockAllFairyHats;
extern NSString * const kProductIdNameUnlockAllFairyNecklaces;
extern NSString * const kProductIdNameUnlockAllFairyOutfits;
extern NSString * const kProductIdNameUnlockAllFairyShoes;
extern NSString * const kProductIdNameUnlockAllFairyWigs;
extern NSString * const kProductIdNameAllPrincessFacePaintDesignsandDressUps;
extern NSString * const kProductIdNamePrincessBench1;
extern NSString * const kProductIdNamePrincessBench2;
extern NSString * const kProductIdNameUnlockAllPrincessAccessories;
extern NSString * const kProductIdNameUnlockAllPrincessEarrings;
extern NSString * const kProductIdNameUnlockAllPrincessGlasses;
extern NSString * const kProductIdNameUnlockAllPrincessHats;
extern NSString * const kProductIdNameUnlockAllPrincessNecklaces;
extern NSString * const kProductIdNameUnlockAllPrincessOutfits;
extern NSString * const kProductIdNameUnlockAllPrincessShoes;
extern NSString * const kProductIdNameUnlockAllPrincessWigs;
extern NSString * const kProductIdNameAllPumpkinFacePaintDesignsandDressUps;
extern NSString * const kProductIdNamePumpkinBench1;
extern NSString * const kProductIdNamePumpkinBench2;
extern NSString * const kProductIdNameUnlockAllPumpkinAccessories;
extern NSString * const kProductIdNameUnlockAllPumpkinEarrings;
extern NSString * const kProductIdNameUnlockAllPumpkinGlasses;
extern NSString * const kProductIdNameUnlockAllPumpkinHats;
extern NSString * const kProductIdNameUnlockAllPumpkinNecklaces;
extern NSString * const kProductIdNameUnlockAllPumpkinOutfits;
extern NSString * const kProductIdNameUnlockAllPumpkinShoes;
extern NSString * const kProductIdNameUnlockAllPumpkinWigs;
extern NSString * const kProductIdNameAllScaryFacePaintDesignsandDressUps;
extern NSString * const kProductIdNameScaryBench1;
extern NSString * const kProductIdNameScaryBench2;
extern NSString * const kProductIdNameUnlockAllScaryAccessories;
extern NSString * const kProductIdNameUnlockAllScaryEarrings;
extern NSString * const kProductIdNameUnlockAllScaryGlasses;
extern NSString * const kProductIdNameUnlockAllScaryHats;
extern NSString * const kProductIdNameUnlockAllScaryNecklaces;
extern NSString * const kProductIdNameUnlockAllScaryOutfits;
extern NSString * const kProductIdNameUnlockAllScaryShoes;
extern NSString * const kProductIdNameUnlockAllScaryWigs;
extern NSString * const kProductIdNameAllVampireFacePaintDesignsandDressUps;
extern NSString * const kProductIdNameVampireBench1;
extern NSString * const kProductIdNameVampireBench2;
extern NSString * const kProductIdNameUnlockAllVampireAccessories;
extern NSString * const kProductIdNameUnlockAllVampireEarrings;
extern NSString * const kProductIdNameUnlockAllVampireGlasses;
extern NSString * const kProductIdNameUnlockAllVampireHats;
extern NSString * const kProductIdNameUnlockAllVampireNecklaces;
extern NSString * const kProductIdNameUnlockAllVampireOutfits;
extern NSString * const kProductIdNameUnlockAllVampireShoes;
extern NSString * const kProductIdNameUnlockAllVampireWigs;
extern NSString * const kProductIdNameAllWitchFacePaintDesignsandDressUps;
extern NSString * const kProductIdNameWitchBench1;
extern NSString * const kProductIdNameWitchBench2;
extern NSString * const kProductIdNameUnlockAllWitchAccessories;
extern NSString * const kProductIdNameUnlockAllWitchEarrings;
extern NSString * const kProductIdNameUnlockAllWitchGlasses;
extern NSString * const kProductIdNameUnlockAllWitchHats;
extern NSString * const kProductIdNameUnlockAllWitchNecklaces;
extern NSString * const kProductIdNameUnlockAllWitchOutfits;
extern NSString * const kProductIdNameUnlockAllWitchShoes;
extern NSString * const kProductIdNameUnlockAllWitchWigs;
//#NFConstantsEnd




@interface Store : NFStore

+(Store *)sharedInstance;
+(Store *)sharedInstanceWithProducts:(NSArray*)products completionHandler:(NFStoreResponseHandler)completionHandler;


@end
