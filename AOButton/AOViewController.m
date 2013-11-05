//
//  AOViewController.m
//  AOButton
//
//  Created by Alekseenko Oleg on 30.07.13.
//  Copyright (c) 2013 alekoleg. All rights reserved.
//

#import "AOViewController.h"
#import "AOButton.h"
@interface AOViewController ()

@property (nonatomic, weak) IBOutlet AOButton *firstButton;
@property (nonatomic, weak) IBOutlet AOButton *secondButton;
@property (nonatomic, weak) IBOutlet AOButton *thirdButton;
@property (nonatomic, weak) IBOutlet AOButton *fourthButton;

@end

@implementation AOViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    _firstButton.borderColor = RGBCOLOR(41, 46, 45);
    [_firstButton setColor:RGBCOLOR(80, 89, 101) forState:UIControlStateNormal];
    [_firstButton setColor:RGBCOLOR(188, 189, 208) forState:UIControlStateHighlighted];
    [_firstButton setColor:RGBCOLOR(121, 123, 151) forState:UIControlStateSelected];
    
    _secondButton.borderColor = RGBCOLOR(243, 225, 202);
    [_secondButton setColor:RGBCOLOR(230, 207, 172) forState:UIControlStateNormal];
    [_secondButton setColor:RGBCOLOR(211, 189, 143) forState:UIControlStateHighlighted];
    [_secondButton setColor:RGBCOLOR(169, 160, 143) forState:UIControlStateDisabled];
    [_secondButton setColor:RGBCOLOR(189, 157, 116) forState:UIControlStateSelected];
    
    [_secondButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
    [_secondButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateSelected];
    [_secondButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateDisabled];

//    double delayInSeconds = 2.0;
//    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
//    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
//        b.selected = YES;
//    });
//    
//    
//    
//    double delayInSeconds1 = 8.0;
//    dispatch_time_t popTime1 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds1 * NSEC_PER_SEC));
//    dispatch_after(popTime1, dispatch_get_main_queue(), ^(void){
//        b.selected = NO;
//    });
//    [b setImage:[UIImage imageNamed:@"rock1"] forState:UIControlStateNormal];
//    [b setImage:[UIImage imageNamed:@"rock2"] forState:UIControlStateSelected];
    
//    [b setGradientColors:@[[UIColor redColor], [UIColor lightTextColor]] forState:UIControlStateSelected];
//    [b setGradientColors:@[[UIColor blueColor], [UIColor greenColor]] forState:UIControlStateNormal];
    
//    [b setBackgroundImage:[UIImage imageNamed:@"mouses"]];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//============================================================================================
#pragma mark - Actions -
//--------------------------------------------------------------------------------------------

- (IBAction)enbaleFirst:(UISwitch *)sender {
    _firstButton.enabled = sender.on;
}

- (IBAction)selectFirst:(UISwitch *)sender {
    _firstButton.selected = sender.on;
}

- (IBAction)enbaleSecond:(UISwitch *)sender {
    _secondButton.enabled = sender.on;
}

- (IBAction)selectSecond:(UISwitch *)sender {
    _secondButton.selected = sender.on;
}

- (IBAction)enbaleThird:(UISwitch *)sender {
    _thirdButton.enabled = sender.on;
}

- (IBAction)selectThird:(UISwitch *)sender {
    _thirdButton.selected = sender.on;
}

- (IBAction)enbaleFourth:(UISwitch *)sender {
    _fourthButton.enabled = sender.on;
}

- (IBAction)selectFourth:(UISwitch *)sender {
    _fourthButton.selected = sender.on;
}
@end
