//
//  Sounds.m
//  NinjafishStudiosApp
//
//  Created by William Locke on 11/21/12.
//  Copyright (c) 2012 William Locke. All rights reserved.
//

#import "Sounds.h"
static Sounds *_sharedInstance;
//#NFConstantsBegin

NSString * const kSoundNameBackChime = @"BackChime.caf";
NSString * const kSoundNamebackground_loop = @"background_loop.caf";
NSString * const kSoundNamebackground_loop_christmas = @"background_loop_christmas.caf";
NSString * const kSoundNamebackground_loop_frozen = @"background_loop_frozen.caf";
NSString * const kSoundNamebackground_loop_santa = @"background_loop_santa.caf";
NSString * const kSoundNamebackground_loop_scary = @"background_loop_scary.caf";
NSString * const kSoundNamebackground_loop_snowman = @"background_loop_snowman.caf";
NSString * const kSoundNamebackground_loop_witch = @"background_loop_witch.caf";
NSString * const kSoundNameBackgroundMusicLoop = @"BackgroundMusicLoop.caf";
NSString * const kSoundNameBackgroundMusicLoop_Facepaint = @"BackgroundMusicLoop_Facepaint.caf";
NSString * const kSoundNameclick = @"click.caf";
NSString * const kSoundNameclick_camera = @"click_camera.caf";
NSString * const kSoundNameclick_design = @"click_design.caf";
NSString * const kSoundNameclick_paint_container = @"click_paint_container.caf";
NSString * const kSoundNameclick_theme = @"click_theme.caf"; 
NSString * const kSoundNameEvilMaleLaughter = @"EvilMaleLaughter.caf";
NSString * const kSoundNameGoodIdeaSound3 = @"GoodIdeaSound3.caf";
NSString * const kSoundNameSelectChime = @"SelectChime.caf";
NSString * const kSoundNameSelectDecoration = @"SelectDecoration.caf";
NSString * const kSoundNameSlideBack = @"SlideBack.caf";
NSString * const kSoundNameSlideForward = @"SlideForward.caf";
NSString * const kSoundNameSoundTricksCuteBackgroundLoop2 = @"SoundTricksCuteBackgroundLoop2.caf";
NSString * const kSoundNameWolfHowl02 = @"WolfHowl02.caf";
//#NFConstantsEnd


@implementation Sounds

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+(Sounds *)sharedInstance{
    if(!_sharedInstance){
        _sharedInstance = (Sounds *)[[Sounds alloc] init];

        NSArray *preLoadedSounds = [NSArray arrayWithObjects:
                                    nil];
        [_sharedInstance preLoadSounds:preLoadedSounds];
    }
    return _sharedInstance;
}

@end
