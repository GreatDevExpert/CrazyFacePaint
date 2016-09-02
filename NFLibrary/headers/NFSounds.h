//
//  NFSounds.h
//
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
#import "NFData.h"

@class NFSounds;
@protocol NFSoundsDelegate <NSObject>
@required
-(void)audioRecorderBlowingDidBegin:(NFSounds *)audio;
@optional
-(void)audioRecorderBlowingDidEnd:(NFSounds *)audio;
@end


@protocol NFSoundSettings <NSObject>

-(BOOL)soundsOn;

@end


enum NFSoundCategories {
    NFSoundCategorySoundEffect = 0,
    NFSoundCategoryMusic = 1
};

/** Class for handling playback and sounds.
 
 
 Dependencies:
    - NFLibrary/NFData
 
 TODO: move to NFAudio. 
 TODO: add NFSoundSettings
 */
@interface NFSounds : NSObject {
	NSMutableDictionary *sounds;
	BOOL locked;
    AVAudioSession *audioSession;
    
    NSMutableDictionary *loopedSounds;
    
    
    AVAudioRecorder *_audioRecorder;
    double _lowPassResults;
    NSTimer *_listenForBlowingTimer;
}

@property (nonatomic, unsafe_unretained) id <NFSoundSettings> settings;
@property (nonatomic, unsafe_unretained) id <NFSoundsDelegate> delegate;
@property (nonatomic, retain) NSMutableDictionary *sounds;


- (id) init;
+(NFSounds *)sharedInstance;
-(void)preLoadSounds:(NSArray *)preLoadedSounds;

-(void)playSound:(NSString *)fileName;
-(void)stopSound:(NSString *)fileName;
-(void)stopPlayback:(AVAudioPlayer *)audioPlayer;
-(void)closeSession;

-(void)playLoopedSound:(NSString *)fileName soundCategory:(int)soundCategory;
-(void)playLoopedSound:(NSString *)fileName;
-(void)stopLoopedSound:(NSString *)fileName;
-(void)previewLoopedSound:(NSString *)fileName;

-(void)stopAllSoundEffects;
-(void)stopAllMusic;
-(void)stopAllSounds;
-(void)stopAllLoopedSoundsExcept:(NSArray *)soundNames;

-(void)playShortSound:(NSString *)fileName;

-(void)adjustVolumeForLoopedSound:(NSString *)fileName volume:(float)volume;

+(void)click;




@end
