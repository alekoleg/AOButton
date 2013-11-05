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

@end

@implementation AOViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
    AOButton *b = [[AOButton alloc]initWithFrame:CGRectMake(100, 50, 100, 100)];
    [b setBackgroundColor:[UIColor yellowColor]];
    
    double delayInSeconds = 2.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        b.selected = YES;
    });
    
    
    
    double delayInSeconds1 = 8.0;
    dispatch_time_t popTime1 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds1 * NSEC_PER_SEC));
    dispatch_after(popTime1, dispatch_get_main_queue(), ^(void){
        b.selected = NO;
    });
//    [b setImage:[UIImage imageNamed:@"rock1"] forState:UIControlStateNormal];
//    [b setImage:[UIImage imageNamed:@"rock2"] forState:UIControlStateSelected];
    
//    [b setGradientColors:@[[UIColor redColor], [UIColor lightTextColor]] forState:UIControlStateSelected];
//    [b setGradientColors:@[[UIColor blueColor], [UIColor greenColor]] forState:UIControlStateNormal];
    
//    [b setBackgroundImage:[UIImage imageNamed:@"mouses"]];
    
    
    [self.view addSubview:b];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
