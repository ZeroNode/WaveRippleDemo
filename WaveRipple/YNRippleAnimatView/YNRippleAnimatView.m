//
//  YNRippleAnimatView.m
//  YNCircleAnimation
//
//  Created by 李艳楠 on 16/12/12.
//  Copyright © 2016年 Jessica. All rights reserved.
//

#import "YNRippleAnimatView.h"

@interface YNRippleAnimatView ()

@property (nonatomic, assign) CGFloat minRadius;
@property (nonatomic, assign) CGFloat maxRadius;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) CALayer *animationLayer;

@end
@implementation YNRippleAnimatView


-(instancetype) initMinRadius:(CGFloat)minRadius maxRadius:(CGFloat)maxRadius {
    self = [super init];
    if (self) {
        
        _minRadius = minRadius;
        _maxRadius = maxRadius;
        
        _rippleCount = 5;
        _rippleDuration = 3;
    }
    
    return self;
}

- (void)startAnimation {
    _animationLayer = [CALayer layer];
    for (int i = 0; i<_rippleCount; i++) {
        CALayer * pulsingLayer = [CALayer layer];
        pulsingLayer.frame = CGRectMake(0, 0, _maxRadius*2, _maxRadius*2);
        pulsingLayer.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.width/2);
        if (!_rippleColor) {
            _rippleColor = [UIColor colorWithWhite:1 alpha:0.7];
        }
        pulsingLayer.backgroundColor = [_rippleColor CGColor];
        pulsingLayer.cornerRadius = _maxRadius;
        pulsingLayer.borderColor = [_borderColor CGColor];
        pulsingLayer.borderWidth = _borderWidth;
        
        CAMediaTimingFunction * defaultCurve = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
        
        CAAnimationGroup * animationGroup = [CAAnimationGroup animation];
        animationGroup.fillMode = kCAFillModeBackwards;
        animationGroup.beginTime = CACurrentMediaTime() + i * _rippleDuration / _rippleCount;
        animationGroup.duration = _rippleDuration;
        animationGroup.repeatCount = HUGE;
        animationGroup.timingFunction = defaultCurve;
        
        CABasicAnimation * scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
        scaleAnimation.fromValue = @(_minRadius / _maxRadius);
        scaleAnimation.toValue = @1.0;
        
        CAKeyframeAnimation * opacityAnimation = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
        opacityAnimation.values = @[@1, @0.9, @0.8, @0.7, @0.6, @0.5, @0.4, @0.3, @0.2, @0.1, @0];
        opacityAnimation.keyTimes = @[@0, @0.1, @0.2, @0.3, @0.4, @0.5, @0.6, @0.7, @0.8, @0.9, @1];
        
        animationGroup.animations = @[scaleAnimation, opacityAnimation];
        [pulsingLayer addAnimation:animationGroup forKey:@"plulsing"];
        [_animationLayer addSublayer:pulsingLayer];
        
    }
    [self.layer addSublayer:_animationLayer];
    [self addSubview:[self imageView]];
    [self addSubview:[self textlabel]];
    [self addSubview:[self timelabel]];
}


- (void)stopAnimation {
    if (_animationLayer) {
        if (_animationLayer == self.layer.sublayers[0]){
            [self.layer.sublayers[0] removeFromSuperlayer ];
        }
    }
}


- (UIImageView*)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = self.backgroundColor;
        _imageView.layer.masksToBounds = YES;
    }
    
    return _imageView;
}

- (UILabel*)textlabel {
    if (!_textlabel) {
        _textlabel = [[UILabel alloc] init];
        _textlabel.backgroundColor = [UIColor clearColor];
    }
    
    return _textlabel;
}

- (UILabel*)timelabel {
    if (!_timelabel) {
        _timelabel = [[UILabel alloc] init];
        _timelabel.backgroundColor = [UIColor clearColor];
    }
    
    return _timelabel;
}


- (void)setImage:(UIImage *)image {
    UIImageView *tmpImgView = [self imageView];
    [tmpImgView setImage:image];
    tmpImgView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    tmpImgView.layer.cornerRadius = image.size.width / 2;
}

- (void)setImageSize:(CGSize)imageSize {
    CGRect newFrame = CGRectMake(0, 0, imageSize.width, imageSize.height);
    UIImageView *tmpImgView = [self imageView];
    tmpImgView.frame = newFrame;
    tmpImgView.layer.cornerRadius = imageSize.width / 2;
    
    UILabel *textlabel = [self textlabel];
    textlabel.frame = newFrame;
    textlabel.textAlignment = NSTextAlignmentCenter;
    textlabel.textColor = [UIColor whiteColor];
    
    UILabel *timelabel = [self timelabel];
    timelabel.frame = CGRectMake(0, 0, imageSize.width, imageSize.height + imageSize.height/2.5);
    timelabel.textAlignment = NSTextAlignmentCenter;
    timelabel.textColor = [UIColor whiteColor];
}



- (void) setFrame:(CGRect)frame {
    [super setFrame:frame];
    self.layer.cornerRadius = self.bounds.size.width / 2;
}


@end
