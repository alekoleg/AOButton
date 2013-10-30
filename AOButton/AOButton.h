//
//  AOButton.h
//  AOButton
//
//  Created by Alekseenko Oleg on 30.07.13.
//  Copyright (c) 2013 alekoleg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AOButton : UIControl


- (void)setImage:(UIImage *)image forState:(UIControlState)state;

- (void)setGradientColors:(NSArray *)colors forState:(UIControlState)state;

- (void)setBackgroundImage:(UIImage *)image;

@end
