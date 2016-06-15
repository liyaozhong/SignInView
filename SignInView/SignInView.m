//
//  SignInView.m
//  SignInView
//
//  Created by joshuali on 16/6/15.
//  Copyright © 2016年 joshuali. All rights reserved.
//

#import "SignInView.h"

#define BTN_WIDTH  102
#define PRESSING_LINE_WIDTH  8
#define PRESSING_DURATION  3
#define PRESSING_TIMER_INTERVAL  0.1
#define ANIMATION_DURATION  1.5f

typedef NS_ENUM(NSInteger, SignInStatus) {
    SignInStatusIdle = 0,
    SignInStatusPressing = 1,
    SignInStatusDone = 2,
};

@interface SignInView ()
{
    NSUInteger counter;
    SignInStatus status;
    CAShapeLayer * pressingLayer;
}
@property (nonatomic, strong) NSTimer * timer;
@end

@implementation SignInView


- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetShouldAntialias(context, YES);
    CGContextClearRect(context, rect);
    UIImage * image;
    if(status == SignInStatusIdle){
        image = [UIImage imageNamed:@"sign_in_btn"];
    }else if(status == SignInStatusPressing){
        image = [UIImage imageNamed:@"sign_in_pressing"];
    }else if(status == SignInStatusDone){
        image = [UIImage imageNamed:@"sign_in_done"];
    }
    [image drawInRect:rect];
    
    if(status == SignInStatusPressing){
        if(!pressingLayer){
            pressingLayer = [CAShapeLayer new];
            [self.layer addSublayer:pressingLayer];
            pressingLayer.path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(rect.size.width/2, rect.size.height/2) radius:(BTN_WIDTH-PRESSING_LINE_WIDTH)/2 startAngle:-M_PI_2 endAngle:M_PI * 2 - M_PI_2 clockwise:YES].CGPath;
            pressingLayer.fillColor = [UIColor clearColor].CGColor;
            pressingLayer.strokeColor = [UIColor colorWithRed:126.0f/255 green:218.0f/255 blue:255.0f/255 alpha:1].CGColor;
            pressingLayer.lineWidth = PRESSING_LINE_WIDTH;
        }
        pressingLayer.strokeStart = 0;
        pressingLayer.strokeEnd = (CGFloat)counter/(PRESSING_DURATION/PRESSING_TIMER_INTERVAL);
    }else{
        for(CALayer * layer in self.layer.sublayers){
            [layer removeFromSuperlayer];
        }
        pressingLayer = nil;
    }
}

- (void) reset
{
    status = SignInStatusIdle;
    [_timer invalidate];
    _timer = nil;
    counter = 0;
    [self setNeedsDisplay];
}

- (void) onPressing
{
    if(counter == PRESSING_DURATION/PRESSING_TIMER_INTERVAL){
        [_timer invalidate];
        _timer = nil;
        counter = 0;
        status = SignInStatusDone;
        CGRect bounds = self.bounds;
        self.bounds = CGRectMake(0, 0, bounds.size.width/2, bounds.size.height/2);
        [UIView animateWithDuration:ANIMATION_DURATION delay:0 usingSpringWithDamping:0.15f initialSpringVelocity:5 options:0 animations:^{
            self.bounds = bounds;
        } completion:nil];
    }else{
        counter ++;
    }
    [self setNeedsDisplay];
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    status = SignInStatusPressing;
    if(!_timer){
        _timer = [NSTimer timerWithTimeInterval:PRESSING_TIMER_INTERVAL target:self selector:@selector(onPressing) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    [self setNeedsDisplay];
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(status == SignInStatusPressing){
        status = SignInStatusIdle;
        [_timer invalidate];
        _timer = nil;
        counter = 0;
    }
    [self setNeedsDisplay];
}

- (void) touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if(status == SignInStatusPressing){
        status = SignInStatusIdle;
        [_timer invalidate];
        _timer = nil;
        counter = 0;
    }
    [self setNeedsDisplay];
}

@end
