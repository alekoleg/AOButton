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
//    [b setImage:[UIImage imageNamed:@"rock1"] forState:UIControlStateNormal];
//    [b setImage:[UIImage imageNamed:@"rock2"] forState:UIControlStateSelected];
    
//    [b setGradientColors:@[[UIColor redColor], [UIColor lightTextColor]] forState:UIControlStateSelected];
//    [b setGradientColors:@[[UIColor blueColor], [UIColor greenColor]] forState:UIControlStateNormal];
    
    [b setBackgroundImage:[UIImage imageNamed:@"mouses"]];
    [self.view addSubview:b];
    
    [UIView animateWithDuration:1 delay:2 usingSpringWithDamping:5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveLinear animations:^{
        
        b.frame = ({
            CGRect frame = b.frame;
            frame.origin.y += 200;
            frame;
        });
    }completion:NULL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
