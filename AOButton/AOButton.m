//
//  AOButton.m
//  AOButton
//
//  Created by Alekseenko Oleg on 30.07.13.
//  Copyright (c) 2013 alekoleg. All rights reserved.
//

#import "AOButton.h"
#import <QuartzCore/QuartzCore.h>

@interface AOButton () {
    @private
    
    CALayer *_backgroundLayer;
    CALayer *_borderLayer;
    CAGradientLayer *_contenLayer;
    CALayer *_imageLayer;
    
    
    UIColor *_borderColor;
    UIColor *_fillColorSelected;
    UIColor *_fillColorNormal;
    

    NSMutableDictionary *_images;
    NSMutableDictionary *_colors;
    
}

@end

@implementation AOButton


-(id)init{
    if (self = [super init]) {
        [self awakeFromNib];
    }
    return self;
}


- (id)initWithFrame:(CGRect)frame
{

    if (self = [super initWithFrame:frame]) {
        [self awakeFromNib];
        // Initialization code

    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    
    _images = [NSMutableDictionary dictionary];
    _colors = [NSMutableDictionary dictionary];
    self.backgroundColor = [UIColor clearColor];
    
    _borderLayer = [CALayer new];
    [self.layer addSublayer:_borderLayer];

    _backgroundLayer = [[CALayer alloc]init];
    [self.layer addSublayer:_backgroundLayer];
    
    _contenLayer = [CAGradientLayer new];
    [self.layer addSublayer:_contenLayer];
    
    _imageLayer = [CALayer new];
    [self.layer addSublayer:_imageLayer];
    
    _borderColor = [UIColor colorWithRed:0.16 green:0.74 blue:0.91 alpha:1];

    _fillColorNormal = [UIColor blueColor];
    _fillColorSelected = [UIColor redColor];
    
    UIColor *c = [UIColor colorWithRed:(42/255) green:(189/255) blue:(233/255) alpha:1];
    

}



-(void)layoutSubviews{
    
    CGSize size = self.frame.size;
    
    
    _borderLayer.frame = CGRectMake(0, 0, size.width, size.height);
    _borderLayer.backgroundColor = _borderColor.CGColor;
    _borderLayer.cornerRadius = size.width * 0.5;
    _borderLayer.masksToBounds = YES;
    
    CGFloat borderWidth = size.width / 100 + 0.5;
    _backgroundLayer.frame = CGRectMake(borderWidth,borderWidth, size.width - 2*borderWidth, size.height - 2*borderWidth);
    _backgroundLayer.backgroundColor = [UIColor whiteColor].CGColor;
    _backgroundLayer.cornerRadius = _backgroundLayer.frame.size.width/2;
    
    
    _contenLayer.frame = _backgroundLayer.frame;
    _contenLayer.backgroundColor = [self _fillContenLayerColor];
    _contenLayer.cornerRadius = _backgroundLayer.cornerRadius;
    
    _imageLayer.frame = _backgroundLayer.frame;
    _imageLayer.cornerRadius = _backgroundLayer.cornerRadius;
    _imageLayer.contentsGravity = kCAGravityCenter;
    
}


#pragma mark - Access Private Property

-(CGColorRef)_fillContenLayerColor{
    if (self.selected) {
        return _fillColorSelected.CGColor;
    }
    return _fillColorNormal.CGColor;
}

-(CGColorRef)_unFillContenLayerColor{
    if (!self.selected) {
        return _fillColorSelected.CGColor;
    }
    return _fillColorNormal.CGColor;
}

-(UIControlState)_controlstate{
    if (self.selected) return UIControlStateSelected;
    return UIControlStateNormal;
}

#pragma mark - Touch Methods

-(BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    [self animateToHighlightedState];
    return [super beginTrackingWithTouch:touch withEvent:event];
}

-(BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{

    return [super continueTrackingWithTouch:touch withEvent:event];
}

-(void)cancelTrackingWithEvent:(UIEvent *)event{
    [self animateToNormalStateState];
    [super cancelTrackingWithEvent:event];
}

-(void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event{
    
        self.selected = !self.selected;
    
    [self animateToNormalStateState];
    [self updateColors];
    if (_images.count > 1) {
        [self updateImageLayer];
    }

    [super endTrackingWithTouch:touch withEvent:event];
}

#pragma mark - Animation Methods
-(void)animateToHighlightedState{
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
        animation.fromValue = [NSValue valueWithCATransform3D:_contenLayer.transform];
        animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.85, 0.85, 1)];
        animation.duration = 0.3;
        animation.delegate = self;
        animation.fillMode = kCAFillModeForwards;
        animation.removedOnCompletion = NO;
        [_contenLayer addAnimation:animation forKey:@"scale"];
}

-(void)animateToNormalStateState{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.duration = 0.3;
    animation.delegate = self;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [_contenLayer addAnimation:animation forKey:@"scaleBack"];
}

-(void)updateColors{
    if (_colors.count > 1) {
        [self updateSelectedStateForGradient];
    }else{
        [self updateSelectedStateForBackground];
    }
}

-(void)updateSelectedStateForBackground{

    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
    anim.fromValue = (id)[self _unFillContenLayerColor];
    anim.toValue = (id)[self _fillContenLayerColor];
    anim.duration = 0.3;
    anim.fillMode= kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    [_contenLayer addAnimation:anim forKey:@"backcolor"];
    
}

-(void)updateSelectedStateForGradient{
    CABasicAnimation *anim = [CABasicAnimation animationWithKeyPath:@"contents"];
    anim.fromValue = (id)_contenLayer.contents;
    anim.toValue = (id)[self _gradientForContent];;
    anim.duration = 0.3;
    anim.fillMode= kCAFillModeForwards;
    anim.removedOnCompletion = NO;
    [_contenLayer addAnimation:anim forKey:@"gradient"];
    
    _contenLayer.contents = (id)[self _gradientForContent];
    
}

-(void)updateImageLayer{
    UIImage *image = [_images objectForKey:@([self _controlstate])];
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

#pragma mark - Public API

-(void)setImage:(UIImage *)image forState:(UIControlState)state{
    if (image) {
        [_images setObject:image forKey:@(state)];
    }else{
        [_images removeObjectForKey:@(state)];
    }
    [self updateImageLayer];
}

-(void)setGradientColors:(NSArray *)colors forState:(UIControlState)state{
    if (colors.count > 1) {
        [_colors setObject:colors forKey:@(state)];
    }
    [self updateColors];
}

- (void)setBackgroundImage:(UIImage *)image {
    _contenLayer.contents = (id)image.CGImage;
}

#pragma mark - Gradient

-(CGImageRef)_gradientForContent{

   UIGraphicsBeginImageContextWithOptions(_imageLayer.frame.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext()  ;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    
    NSArray *colors = _colors[@([self _controlstate])];
    NSMutableArray *colorsRef = [NSMutableArray arrayWithCapacity:colors.count] ;
    for (int i = 0; i < colors.count; i++) {
        UIColor *color = [colors objectAtIndex:i];
        [colorsRef addObject:(id)color.CGColor];
    }
    CGFloat glossLocations[] = {0.0, 0.5};
//    CFArrayRef colorsArray =  CFArrayCreate(NULL, (__bridge CFArrayRef)colorsRef, sizeof(colorsRef)/sizeof(CGColorRef), &kCFTypeArrayCallBacks);

    CGGradientRef gradient =  CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colorsRef, glossLocations);
    CGContextDrawRadialGradient(context, gradient, CGPointMake(_imageLayer.frame.size.width * 0.5, _imageLayer.frame.size.width * 0.5), 0, CGPointMake(_imageLayer.frame.size.width * 0.5, _imageLayer.frame.size.width * 0.5), _imageLayer.frame.size.width *  0.5, 0);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    NSData *data = UIImagePNGRepresentation(image);
    [data writeToFile:@"/Users/AlekOleg/Desktop/1.png" atomically:YES];
    UIGraphicsEndImageContext();
    return image.CGImage;
    
}
@end
