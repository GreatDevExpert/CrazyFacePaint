//
//  ChooseCharacterViewController.m
//  HighSchoolMakeover
//
//  Created by William Locke on 9/23/13.
//  Copyright (c) 2013 Ninjafish Studios. All rights reserved.
//

#import "ChooseCharacterViewController.h"
#import "FacepaintViewController.h"
#import "MakeUpViewController.h"

@interface ChooseCharacterViewController ()<NFProductDisplayerView>{

}

@end

@implementation ChooseCharacterViewController

- (id)initWithNib
{
    self = [super initWithNib];
    if (self) {
        // Custom initialization
        self.nextViewControllerClass = [FacepaintViewController class];
        
//        self.nextViewControllerClass = [MakeUpViewController class];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self layout];
    
    [self adjustLayoutForIPhone5];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark iPhone 5
-(void)layout{
    [self layoutCharacters];

    
}

-(void)layoutCharacters{
    [super layoutCharacters];
    for (UIButton *characterButton in self.characterButtons){
        characterButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        characterButton.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    for(KSLabel *label in self.characterNameLabels){
        [self styleLabel:label];
    }
    
}

-(void)styleLabel:(KSLabel *)label{
    [label setDrawOutline:YES];
    [label setOutlineColor:[UIColor whiteColor]];
    [label setDrawGradient:YES];
    UIColor *topColor = [UIColor redColor];
    //    topColor = [UIColor colorWithRed:184/255.0 green:100/255.0 blue:239/255.0 alpha:1.0];
    topColor = [UIColor darkGrayColor];
    const float* colorComponents = CGColorGetComponents( topColor.CGColor );
    CGFloat colors [] = {
        0.1, 0, 0, 1.0,
        0.2, 0, 0, 1.0,
    };
    [label setGradientColors:colors];
    
    [label setTextColor:[UIColor redColor]];
    
    label.numberOfLines = 3;
    label.outlineWidth = NFGeometryUniversalDistance(3);
    //    label.font = [UIFont fontWithName:@"Marker Felt" size:label.font.pointSize];
    [label setDrawDropShadow:YES];
}



#pragma mark IBAction
-(IBAction)moreGamesButtonPressed:(id)sender{
    
    [[NFAdDisplayer sharedInstance] showMoreApps];
    
    
}



-(void)releaseImages{
    
}


-(void)adjustLayoutForIPhone5{
    
    if([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad){
        for(KSLabel *label in self.characterNameLabels){
            label.font = [UIFont fontWithName:@"Chalkduster" size:label.font.pointSize * 2.0];
        }
    }
}

@end
