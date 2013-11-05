//
//  AOButton.m
//  AOButton
//
//  Created by Alekseenko Oleg on 30.07.13.
//  Copyright (c) 2013 alekoleg. All rights reserved.
//

#import "AOButton.h"
#import <QuartzCore/QuartzCore.h>

#define AOButtonScaleFactor 0.85
#define AOButtonNormalColor [UIColor white]
#define AOButtonSelectedColor

@interface AOButton () {
    
	CALayer *_backgroundLayer;
	CALayer *_borderLayer;
	CALayer *_contenLayer;
	CALayer *_imageLayer;
    
	NSMutableDictionary *_images;
	NSMutableDictionary *_colors;
    BOOL _isHighlighted;
    BOOL _canAnimate;
    BOOL _scaled;
    UIControlState _currentState;
}

@end

@implementation AOButton


//============================================================================================
#pragma mark - Setup -
//--------------------------------------------------------------------------------------------

- (id)init {
	if (self = [super init]) {
		[self awakeFromNib];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self awakeFromNib];
	}
	return self;
}

- (void)awakeFromNib {
	[super awakeFromNib];
	_images = [NSMutableDictionary dictionary];
    _currentState = self.state;
    _canAnimate = YES;
    
    [self initColors];
    
	self.backgroundColor = [UIColor clearColor];
    
	_borderLayer = [CALayer new];
	[self.layer addSublayer:_borderLayer];
    
	_backgroundLayer = [[CALayer alloc]init];
    _backgroundLayer.contentsScale = [[UIScreen mainScreen]scale];
    _backgroundLayer.backgroundColor = [UIColor whiteColor].CGColor;
	[self.layer addSublayer:_backgroundLayer];
    
	_contenLayer = [CALayer new];
    _contenLayer.contentsScale = [[UIScreen mainScreen]scale];
	[self.layer addSublayer:_contenLayer];
    
	_imageLayer = [CALayer new];
    _imageLayer.contentsScale = [[UIScreen mainScreen]scale];
	[self.layer addSublayer:_imageLayer];
}


- (void)initColors {
    _colors = [NSMutableDictionary dictionary];
    [_colors setObject:[UIColor redColor] forKey:@(UIControlStateNormal)];
    [_colors setObject:[UIColor blueColor] forKey:@(UIControlStateSelected)];
    [_colors setObject:[UIColor grayColor] forKey:@(UIControlStateDisabled)];
    [_colors setObject:[UIColor purpleColor] forKey:@(UIControlStateHighlighted)];
    //border
    _borderColor = [UIColor colorWithRed:0.16 green:0.74 blue:0.91 alpha:1];
}


//============================================================================================
#pragma mark - Layout -
//--------------------------------------------------------------------------------------------


- (void)layoutSubviews {
	CGSize size = self.frame.size;
    
	_borderLayer.frame = CGRectMake(0, 0, size.width, size.height);
	_borderLayer.backgroundColor = _borderColor.CGColor;
	_borderLayer.cornerRadius = size.width * 0.5;
	_borderLayer.masksToBounds = YES;
    
	CGFloat borderWidth = size.width / 100 + 0.5;
	_backgroundLayer.frame = CGRectMake(borderWidth, borderWidth, size.width - 2 * borderWidth, size.height - 2 * borderWidth);
	_backgroundLayer.cornerRadius = _backgroundLayer.frame.size.width / 2;
    
	_contenLayer.frame = _backgroundLayer.frame;
	_contenLayer.backgroundColor = [self colorForCurrentState].CGColor;
	_contenLayer.cornerRadius = _backgroundLayer.cornerRadius;
    
	_imageLayer.frame = _backgroundLayer.frame;
	_imageLayer.cornerRadius = _backgroundLayer.cornerRadius;
	_imageLayer.contentsGravity = kCAGravityCenter;
}

//--------------------------------------------------------------------------------------------
#pragma mark - Animation Methods -
//============================================================================================
- (void)animateToHighlightedState {
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
	animation.fromValue = [NSValue valueWithCATransform3D:_contenLayer.transform];
	animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(AOButtonScaleFactor, AOButtonScaleFactor, 1)];
	animation.duration = 0.3 * _canAnimate;
	animation.delegate = self;
	animation.fillMode = kCAFillModeForwards;
	animation.removedOnCompletion = NO;
	[_contenLayer addAnimation:animation forKey:@"scale"];
    _canAnimate = NO;
    _scaled = YES;
}

- (void)animateToNormalState {
	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
	animation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
	animation.duration = 0.3 * _canAnimate;
	animation.delegate = self;
	animation.fillMode = kCAFillModeForwards;
	animation.removedOnCompletion = NO;
	[_contenLayer addAnimation:animation forKey:@"scaleBack"];
    _canAnimate = NO;
    _scaled = NO;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    _canAnimate = YES;
}

//============================================================================================
#pragma mark - Update -
//--------------------------------------------------------------------------------------------
- (void)updateColors {
	CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
	anim.fromValue = (id)_contenLayer.backgroundColor;
	anim.toValue = (id)[self colorForCurrentState].CGColor;
	anim.duration = 0.3;
	anim.fillMode = kCAFillModeForwards;
	anim.removedOnCompletion = NO;
    _contenLayer.backgroundColor = [self colorForCurrentState].CGColor;
	[_contenLayer addAnimation:anim forKey:@"backcolor"];
}

- (void)updateImages {
	UIImage *image = [self imageForCurrentState];
	if (image) {
		CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"contents"];
		animation.toValue = (id)image.CGImage;
		animation.duration = 0.3;
		animation.fillMode = kCAFillModeForwards;
		animation.removedOnCompletion = NO;
		[_imageLayer addAnimation:animation forKey:@"image"];
	}
	_imageLayer.contents = (id)image.CGImage;
}

//============================================================================================
#pragma mark - Publick API -
//--------------------------------------------------------------------------------------------

- (void)setImage:(UIImage *)image forState:(UIControlState)state {
	if (image) {
		[_images setObject:image forKey:@(state)];
	}
	else {
		[_images removeObjectForKey:@(state)];
	}
	[self updateImages];
}

- (void)setColor:(UIColor *)color forState:(UIControlState)state {
    if (color) {
        [_colors setObject:color forKey:@(state)];
    } else {
        [_colors removeObjectForKey:@(state)];
    }
    [self updateColors];
}

- (void)setBackgroundImage:(UIImage *)image {
	_backgroundLayer.contents = (id)image.CGImage;
}

- (void)setBackgroundColor:(UIColor *)backgroundColor {
	_backgroundLayer.backgroundColor = backgroundColor.CGColor;
}


//============================================================================================
#pragma mark - Helpers -
//--------------------------------------------------------------------------------------------

- (UIColor *)colorForCurrentState {
    if ([_colors objectForKey:@(self.state)]) {
        return [_colors objectForKey:@(self.state)];
    }
    return [_colors objectForKey:@(UIControlStateNormal)];
}


- (UIImage *)imageForCurrentState {
    if ([_images objectForKey:@(self.state)]) {
        return [_images objectForKey:@(self.state)];
    }
    return [_images objectForKey:@(UIControlStateNormal)];
}

//============================================================================================
#pragma mark - State -
//--------------------------------------------------------------------------------------------

- (void)setHighlighted:(BOOL)highlighted {
    [super setHighlighted:highlighted];
    [self updateForState:self.state];
}

- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    [self updateForState:self.state];
}

- (void)setEnabled:(BOOL)enabled {
    [super setEnabled:enabled];
    [self updateForState:self.state];
}

- (UIControlState)state {
    if (!self.enabled) {
        return UIControlStateDisabled;
    }
    
    if (super.state > UIControlStateSelected) {
        return UIControlStateHighlighted;
    }
    return super.state;
}

- (void)updateForState:(UIControlState)state {
    if (_currentState != self.state) {
        _currentState = self.state;
        [self updateColors];
        [self updateImages];
        if (_currentState == UIControlStateHighlighted && !_scaled) {
            [self animateToHighlightedState];
        } else  if (_scaled) {
            [self animateToNormalState];
        }
    }
}
@end
