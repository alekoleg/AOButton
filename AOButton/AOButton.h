//
//  AOButton.h
//  AOButton
//
//  Created by Alekseenko Oleg on 30.07.13.
//  Copyright (c) 2013 alekoleg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AOButton : UIControl


@property (nonatomic, strong) UIColor *borderColor;


- (void)setImage:(UIImage *)image forState:(UIControlState)state;

- (void)setColor:(UIColor *)color forState:(UIControlState)state;

- (void)setBackgroundImage:(UIImage *)image;

- (void)setBackgroundColor:(UIColor *)backgroundColor;

@end
