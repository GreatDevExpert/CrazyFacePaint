//
//  Sounds.h
//  NinjafishStudiosApp
//
//  Created by William Locke on 11/21/12.
//  Copyright (c) 2012 William Locke. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NFSounds.h"

// Constants created with ninjafish gem
//#NFConstantsBegin

extern NSString * const kSoundNameBackChime;
extern NSString * const kSoundNamebackground_loop;
extern NSString * const kSoundNamebackground_loop_christmas;
extern NSString * const kSoundNamebackground_loop_frozen;
extern NSString * const kSoundNamebackground_loop_santa;
extern NSString * const kSoundNamebackground_loop_scary;
extern NSString * const kSoundNamebackground_loop_snowman;
extern NSString * const kSoundNamebackground_loop_witch;
extern NSString * const kSoundNameBackgroundMusicLoop;
extern NSString * const kSoundNameBackgroundMusicLoop_Facepaint;
extern NSString * const kSoundNameclick;
extern NSString * const kSoundNameclick_camera;
extern NSString * const kSoundNameclick_design;
extern NSString * const kSoundNameclick_paint_container;
extern NSString * const kSoundNameclick_theme;
extern NSString * const kSoundNameEvilMaleLaughter;
extern NSString * const kSoundNameGoodIdeaSound3;
extern NSString * const kSoundNameSelectChime;
extern NSString * const kSoundNameSelectDecoration;
extern NSString * const kSoundNameSlideBack;
extern NSString * const kSoundNameSlideForward;
extern NSString * const kSoundNameSoundTricksCuteBackgroundLoop2;
extern NSString * const kSoundNameWolfHowl02;
//#NFConstantsEnd

@interface Sounds : NFSounds

+(Sounds *)sharedInstance;

@end
