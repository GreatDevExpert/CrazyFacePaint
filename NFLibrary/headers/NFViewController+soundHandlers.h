//
//  NFViewController+soundHandlers.h
//  Pods
//
//  Created by William Locke on 6/21/14.
//
//

#import "NFViewController.h"

@interface NFViewController (soundHandlers)

/**
 * Sound names for looped sound played when a draggable image is being dragged.
 * Sound name convention: <identifier>_loop.caf. E.g. 'ointment_rashes_loop.caf'
 * Draggable view identifiers are taken from enclosing image folder name for image(s) used for draggable item (e.g. ointment_rashes/).
 */
-(NSString *)loopSoundNameForDraggableView:(NFDraggableView *)draggableView;

/**
 * Sound name for sound played when a draggable item is placed.
 * Sound name convention: <identifier>_placed.caf. E.g. 'hammer_placed.caf'
 */
-(NSString *)placedSoundNameForDraggableView:(NFDraggableView *)draggableView;

/**
 * Sound name for looped sound when a draggable image is placed and an item is animating (for example).
 * Sound name convention: <identifier>_placed_loop.caf. E.g. 'electrocardiogram_placed_loop.caf'
 */
-(NSString *)placedLoopSoundNameForDraggableView:(NFDraggableView *)draggableView;

/**
 * Sound name for sound played when a view loads.
 * Sound name convention: <view controller name>.caf. E.g. 'choose_a_mommy.caf'
 */
-(NSString *)viewDidLoadSoundName;


-(void)playPlacedLoopedSoundForObject:(id)object inFunction:(SEL)function;
-(void)stopPlacedLoopedSoundForObject:(id)object inFunction:(SEL)function;

-(void)playLoopedSoundForObject:(id)object inFunction:(SEL)function;
-(void)stopLoopedSoundForObject:(id)object inFunction:(SEL)function;


-(void)playClickSoundForFunction:(SEL)function;
-(void)playClickSoundForObject:(id)object inFunction:(SEL)function;
-(void)playClickSoundForIdentifier:(NSString *)identifier;

-(void)playPlacedSoundForObject:(id)object inFunction:(SEL)function;

-(void)playVoiceoverSoundForFunction:(SEL)function;
-(void)playSoundEffectForFunction:(SEL)function;
-(void)playNumberVoiceoverForNumber:(int)number;

-(void)playCongratulationSound;
-(void)playTryAgainSound;
-(void)playCameraClickSound;

-(void)soundButtonPressed:(id)sender;
-(void)updateSoundButton:(UIButton *)soundButton;
-(void)playBackgroundMusic;
@end
