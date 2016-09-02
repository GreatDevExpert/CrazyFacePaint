//
//  Store.m
//  NinjafishStudiosApp
//
//  Created by William Locke on 11/20/12.
//  Copyright (c) 2012 William Locke. All rights reserved.
//

#import "Store.h"
#import "NFStore.h"


static Store *_sharedInstance;

//#NFConstantsBegin

NSString * const kProductIdNameRemoveAds = @"com.ninjafishstudios.halloweenfacepaint.remove_ads";
NSString * const kProductIdNameUnlockAllCharacters = @"com.ninjafishstudios.halloweenfacepaint.unlock_all_characters";
NSString * const kProductIdNameAllRegularFacePaint = @"com.ninjafishstudios.halloweenfacepaint.unlock_regular_pack";
NSString * const kProductIdNameRegularBench1 = @"com.ninjafishstudios.halloweenfacepaint.unlock_regular_bench1";
NSString * const kProductIdNameRegularBench2 = @"com.ninjafishstudios.halloweenfacepaint.unlock_regular_bench2";
NSString * const kProductIdNameAllSparkleFacePaint = @"com.ninjafishstudios.halloweenfacepaint.unlock_sparkle_pack";
NSString * const kProductIdNameAllPatternFacePaint = @"com.ninjafishstudios.halloweenfacepaint.unlock_pattern_pack";
NSString * const kProductIdNameAllColorfulFacePaint = @"com.ninjafishstudios.halloweenfacepaint.unlock_color_pack";
NSString * const kProductIdNameUnlockAllHats = @"com.ninjafishstudios.halloweenfacepaint.unlock_accessories_hats";
NSString * const kProductIdNameUnlockAllHair = @"com.ninjafishstudios.halloweenfacepaint.unlock_accessories_wigs";
NSString * const kProductIdNameUnlockAllGlasses = @"com.ninjafishstudios.halloweenfacepaint.unlock_accessories_glasses";
NSString * const kProductIdNameAllFairyFacePaintDesignsandDressUps = @"com.ninjafishstudios.halloweenfacepaint.unlock_christmas_pack";
NSString * const kProductIdNameFairyBench1 = @"com.ninjafishstudios.halloweenfacepaint.unlock_christmas_bench1";
NSString * const kProductIdNameFairyBench2 = @"com.ninjafishstudios.halloweenfacepaint.unlock_christmas_bench2";
NSString * const kProductIdNameUnlockAllFairyAccessories = @"com.ninjafishstudios.halloweenfacepaint.unlock_christmas_accessories";
NSString * const kProductIdNameUnlockAllFairyEarrings = @"com.ninjafishstudios.halloweenfacepaint.unlock_christmas_earrings";
NSString * const kProductIdNameUnlockAllFairyGlasses = @"com.ninjafishstudios.halloweenfacepaint.unlock_christmas_glasses";
NSString * const kProductIdNameUnlockAllFairyHats = @"com.ninjafishstudios.halloweenfacepaint.unlock_christmas_hats";
NSString * const kProductIdNameUnlockAllFairyNecklaces = @"com.ninjafishstudios.halloweenfacepaint.unlock_christmas_necklaces";
NSString * const kProductIdNameUnlockAllFairyOutfits = @"com.ninjafishstudios.halloweenfacepaint.unlock_christmas_outfits";
NSString * const kProductIdNameUnlockAllFairyShoes = @"com.ninjafishstudios.halloweenfacepaint.unlock_christmas_shoes";
NSString * const kProductIdNameUnlockAllFairyWigs = @"com.ninjafishstudios.halloweenfacepaint.unlock_christmas_wigs";
NSString * const kProductIdNameAllPrincessFacePaintDesignsandDressUps = @"com.ninjafishstudios.halloweenfacepaint.unlock_frozen_pack";
NSString * const kProductIdNamePrincessBench1 = @"com.ninjafishstudios.halloweenfacepaint.unlock_frozen_bench1";
NSString * const kProductIdNamePrincessBench2 = @"com.ninjafishstudios.halloweenfacepaint.unlock_frozen_bench2";
NSString * const kProductIdNameUnlockAllPrincessAccessories = @"com.ninjafishstudios.halloweenfacepaint.unlock_frozen_accessories";
NSString * const kProductIdNameUnlockAllPrincessEarrings = @"com.ninjafishstudios.halloweenfacepaint.unlock_frozen_earrings";
NSString * const kProductIdNameUnlockAllPrincessGlasses = @"com.ninjafishstudios.halloweenfacepaint.unlock_frozen_glasses";
NSString * const kProductIdNameUnlockAllPrincessHats = @"com.ninjafishstudios.halloweenfacepaint.unlock_frozen_hats";
NSString * const kProductIdNameUnlockAllPrincessNecklaces = @"com.ninjafishstudios.halloweenfacepaint.unlock_frozen_necklaces";
NSString * const kProductIdNameUnlockAllPrincessOutfits = @"com.ninjafishstudios.halloweenfacepaint.unlock_frozen_outfits";
NSString * const kProductIdNameUnlockAllPrincessShoes = @"com.ninjafishstudios.halloweenfacepaint.unlock_frozen_shoes";
NSString * const kProductIdNameUnlockAllPrincessWigs = @"com.ninjafishstudios.halloweenfacepaint.unlock_frozen_wigs";
NSString * const kProductIdNameAllPumpkinFacePaintDesignsandDressUps = @"com.ninjafishstudios.halloweenfacepaint.unlock_santa_pack";
NSString * const kProductIdNamePumpkinBench1 = @"com.ninjafishstudios.halloweenfacepaint.unlock_santa_bench1";
NSString * const kProductIdNamePumpkinBench2 = @"com.ninjafishstudios.halloweenfacepaint.unlock_santa_bench2";
NSString * const kProductIdNameUnlockAllPumpkinAccessories = @"com.ninjafishstudios.halloweenfacepaint.unlock_santa_accessories";
NSString * const kProductIdNameUnlockAllPumpkinEarrings = @"com.ninjafishstudios.halloweenfacepaint.unlock_santa_earrings";
NSString * const kProductIdNameUnlockAllPumpkinGlasses = @"com.ninjafishstudios.halloweenfacepaint.unlock_santa_glasses";
NSString * const kProductIdNameUnlockAllPumpkinHats = @"com.ninjafishstudios.halloweenfacepaint.unlock_santa_hats";
NSString * const kProductIdNameUnlockAllPumpkinNecklaces = @"com.ninjafishstudios.halloweenfacepaint.unlock_santa_necklaces";
NSString * const kProductIdNameUnlockAllPumpkinOutfits = @"com.ninjafishstudios.halloweenfacepaint.unlock_santa_outfits";
NSString * const kProductIdNameUnlockAllPumpkinShoes = @"com.ninjafishstudios.halloweenfacepaint.unlock_santa_shoes";
NSString * const kProductIdNameUnlockAllPumpkinWigs = @"com.ninjafishstudios.halloweenfacepaint.unlock_santa_wigs";
NSString * const kProductIdNameAllScaryFacePaintDesignsandDressUps = @"com.ninjafishstudios.halloweenfacepaint.unlock_scary_pack";
NSString * const kProductIdNameScaryBench1 = @"com.ninjafishstudios.halloweenfacepaint.unlock_scary_bench1";
NSString * const kProductIdNameScaryBench2 = @"com.ninjafishstudios.halloweenfacepaint.unlock_scary_bench2";
NSString * const kProductIdNameUnlockAllScaryAccessories = @"com.ninjafishstudios.halloweenfacepaint.unlock_scary_accessories";
NSString * const kProductIdNameUnlockAllScaryEarrings = @"com.ninjafishstudios.halloweenfacepaint.unlock_scary_earrings";
NSString * const kProductIdNameUnlockAllScaryGlasses = @"com.ninjafishstudios.halloweenfacepaint.unlock_scary_glasses";
NSString * const kProductIdNameUnlockAllScaryHats = @"com.ninjafishstudios.halloweenfacepaint.unlock_scary_hats";
NSString * const kProductIdNameUnlockAllScaryNecklaces = @"com.ninjafishstudios.halloweenfacepaint.unlock_scary_necklaces";
NSString * const kProductIdNameUnlockAllScaryOutfits = @"com.ninjafishstudios.halloweenfacepaint.unlock_scary_outfits";
NSString * const kProductIdNameUnlockAllScaryShoes = @"com.ninjafishstudios.halloweenfacepaint.unlock_scary_shoes";
NSString * const kProductIdNameUnlockAllScaryWigs = @"com.ninjafishstudios.halloweenfacepaint.unlock_scary_wigs";
NSString * const kProductIdNameAllVampireFacePaintDesignsandDressUps = @"com.ninjafishstudios.halloweenfacepaint.unlock_snowman_pack";
NSString * const kProductIdNameVampireBench1 = @"com.ninjafishstudios.halloweenfacepaint.unlock_snowman_bench1";
NSString * const kProductIdNameVampireBench2 = @"com.ninjafishstudios.halloweenfacepaint.unlock_snowman_bench2";
NSString * const kProductIdNameUnlockAllVampireAccessories = @"com.ninjafishstudios.halloweenfacepaint.unlock_snowman_accessories";
NSString * const kProductIdNameUnlockAllVampireEarrings = @"com.ninjafishstudios.halloweenfacepaint.unlock_snowman_earrings";
NSString * const kProductIdNameUnlockAllVampireGlasses = @"com.ninjafishstudios.halloweenfacepaint.unlock_snowman_glasses";
NSString * const kProductIdNameUnlockAllVampireHats = @"com.ninjafishstudios.halloweenfacepaint.unlock_snowman_hats";
NSString * const kProductIdNameUnlockAllVampireNecklaces = @"com.ninjafishstudios.halloweenfacepaint.unlock_snowman_necklaces";
NSString * const kProductIdNameUnlockAllVampireOutfits = @"com.ninjafishstudios.halloweenfacepaint.unlock_snowman_outfits";
NSString * const kProductIdNameUnlockAllVampireShoes = @"com.ninjafishstudios.halloweenfacepaint.unlock_snowman_shoes";
NSString * const kProductIdNameUnlockAllVampireWigs = @"com.ninjafishstudios.halloweenfacepaint.unlock_snowman_wigs";
NSString * const kProductIdNameAllWitchFacePaintDesignsandDressUps = @"com.ninjafishstudios.halloweenfacepaint.unlock_witch_pack";
NSString * const kProductIdNameWitchBench1 = @"com.ninjafishstudios.halloweenfacepaint.unlock_witch_bench1";
NSString * const kProductIdNameWitchBench2 = @"com.ninjafishstudios.halloweenfacepaint.unlock_witch_bench2";
NSString * const kProductIdNameUnlockAllWitchAccessories = @"com.ninjafishstudios.halloweenfacepaint.unlock_witch_accessories";
NSString * const kProductIdNameUnlockAllWitchEarrings = @"com.ninjafishstudios.halloweenfacepaint.unlock_witch_earrings";
NSString * const kProductIdNameUnlockAllWitchGlasses = @"com.ninjafishstudios.halloweenfacepaint.unlock_witch_glasses";
NSString * const kProductIdNameUnlockAllWitchHats = @"com.ninjafishstudios.halloweenfacepaint.unlock_witch_hats";
NSString * const kProductIdNameUnlockAllWitchNecklaces = @"com.ninjafishstudios.halloweenfacepaint.unlock_witch_necklaces";
NSString * const kProductIdNameUnlockAllWitchOutfits = @"com.ninjafishstudios.halloweenfacepaint.unlock_witch_outfits";
NSString * const kProductIdNameUnlockAllWitchShoes = @"com.ninjafishstudios.halloweenfacepaint.unlock_witch_shoes";
NSString * const kProductIdNameUnlockAllWitchWigs = @"com.ninjafishstudios.halloweenfacepaint.unlock_witch_wigs";
//#NFConstantsEnd



@implementation Store

- (id)initWithProducts:(NSArray *)products
{
    self = [super initWithProducts:products];
    if (self) {

        
    }
    return self;
}


+(Store *)sharedInstance{
    return _sharedInstance;
}

+(Store *)sharedInstanceWithProducts:(NSArray*)products completionHandler:(NFStoreResponseHandler)completionHandler{
    if(!_sharedInstance){
        _sharedInstance = [[Store alloc] initWithProducts:products completionHandler:completionHandler];
        //_sharedInstance = (Store *)[NFStore sharedInstanceWithProducts:products];
    }
    return _sharedInstance;
}





//-(int)lockedIndexForDataKeyPath:(NSString *)dataKeyPath{
//     
//    
//    if([dataKeyPath isEqualToString:kDataKeyPathPlates]){
//        if(![self productHasAlreadyBeenBought:kProductIdUnlockAllFlavors]){
//            return 4;
//        }
//    }else if([dataKeyPath isEqualToString:kDataKeyPathIcing]){
//        if(![self productHasAlreadyBeenBought:kProductIdUnlockAllFlavors]){
//            return 4;
//        }
//    }else if([dataKeyPath isEqualToString:kDataKeyPathIcing]){
//        if(![self productHasAlreadyBeenBought:kProductIdUnlockAllFlavors]){
//            return 4;
//        }
//    }
//    
//    return 1000;
//}




@end
