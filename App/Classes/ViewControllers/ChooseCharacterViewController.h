//
//  ChooseCharacterViewController.h
//  HighSchoolMakeover
//
//  Created by William Locke on 9/23/13.
//  Copyright (c) 2013 Ninjafish Studios. All rights reserved.
//

#import "NFChooseCharacterViewController.h"
#import "NFPopupViewController.h"
#import "KSLabel.h"

@interface ChooseCharacterViewController : NFChooseCharacterViewController

@property (nonatomic, strong) IBOutletCollection(KSLabel) NSArray *characterNameLabels;
@property (nonatomic, strong) IBOutlet UIButton *moreGamesButton;

@end
