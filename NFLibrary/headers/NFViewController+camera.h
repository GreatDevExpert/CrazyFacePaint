//
//  ViewController+camera.h
//  PrincessFashionResort
//
//  Created by William Locke on 6/19/14.
//  Copyright (c) 2014 Ninjafish Studios. All rights reserved.
//

#import "NFViewController.h"

@interface NFViewController (camera)

-(void)handleCameraButtonPressed:(UIButton *)cameraButton setNonPhotographicElementsHiddenHandler:(void (^ )(BOOL hidden))setNonPhotographicElementsHiddenHandler ;

@end
