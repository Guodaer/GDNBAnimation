//
//  GDAnimationModel.m
//  GDNBAnimation
//
//  Created by xiaoyu on 16/3/25.
//  Copyright © 2016年 Guoda. All rights reserved.
//

#import "GDAnimationModel.h"

@interface GDAnimationModel ()

@property (nonatomic, strong) UIView *GD_backView;

@property (nonatomic, strong) UIView *subView1;

@property (nonatomic, strong) UIView *subView2;



@end

@implementation GDAnimationModel
+ (instancetype)shareInstance {
    static GDAnimationModel *model = nil;
    static dispatch_once_t hello;
    dispatch_once(&hello, ^{
        model = [[self alloc] init];
    });
    return model;
}
#pragma mark - 接口1  初始化创建

- (void)CreateAmazing_AnimationWithSuperView:(UIView *)SuperView {
    
    self.GD_backView = [[UIView alloc] initWithFrame:SuperView.frame];
    self.GD_backView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    [SuperView addSubview:self.GD_backView];
    [self performSelector:@selector(setup_InitView) withObject:nil afterDelay:0.5];
    
}
- (void)setup_InitView{
    _subView1 = [[UIView alloc] initWithFrame:CGRectMake(50, 100, 100, 100)];
    _subView1.backgroundColor = [self randomColor];
    [self.GD_backView addSubview:_subView1];
    _subView2 = [[UIView alloc] initWithFrame:CGRectMake(SCREENWIDTH-150, 100, 100, 100)];
    _subView2.backgroundColor = [self randomColor];
    [self.GD_backView addSubview:_subView2];
    [self Animation_1_step];
}
- (void)Animation_1_step {

    CATransform3D rotationTransform  = CATransform3DMakeRotation(M_PI, 0, 0,100);
    CABasicAnimation* animation;
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue= [NSValue valueWithCATransform3D:rotationTransform];
    animation.duration= 0.01;
    animation.autoreverses= NO;
    animation.cumulative= YES;
    animation.removedOnCompletion=NO;
    animation.fillMode=kCAFillModeForwards;
    animation.repeatCount= 100;
    [_subView1.layer addAnimation:animation forKey:nil];
    CABasicAnimation *anim1 = [self SetCornerRadiusWithDuration:1 FromValue:0 ToValue:50 Count:1];
    [_subView1.layer addAnimation:anim1 forKey:nil];
    
    CABasicAnimation* animation2;
    animation2 = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation2.toValue= [NSValue valueWithCATransform3D:rotationTransform];
    animation2.duration= 0.01;
    animation2.autoreverses= NO;
    animation2.cumulative= YES;
    animation2.removedOnCompletion=NO;
    animation2.fillMode=kCAFillModeForwards;
    animation2.repeatCount= 100;
    [_subView2.layer addAnimation:animation2 forKey:nil];
    CABasicAnimation *anim2 = [self SetCornerRadiusWithDuration:1 FromValue:0 ToValue:50 Count:1];
    [_subView2.layer addAnimation:anim2 forKey:nil];
    
    //step_2
    [self performSelector:@selector(Animation_2_step) withObject:nil afterDelay:1];
}
- (void)Animation_2_step {
    
    [UIView animateWithDuration:1 animations:^{
        
        _subView1.frame = CGRectMake(0, 0, 100, 100);
        _subView1.center = CGPointMake(SCREENWIDTH/2, SCREENHEIGHT/2);
        
        _subView2.frame = CGRectMake(0, 0, 100, 100);
        _subView2.center = CGPointMake(SCREENWIDTH/2, SCREENHEIGHT/2);

    } completion:^(BOOL finished) {
        
        [self performSelector:@selector(Animation_3_step) withObject:nil afterDelay:0];
    }];
    
}
static float num_corner = 0;

- (void)Animation_3_step {
    [UIView animateWithDuration:0.1 animations:^{
        _subView1.layer.cornerRadius = num_corner;
        _subView2.layer.cornerRadius = num_corner;
    } completion:^(BOOL finished) {
        num_corner = num_corner + 0.5;
        if (num_corner < 50) {
            [self performSelector:@selector(Animation_3_step) withObject:nil afterDelay:0];
        }
        else{
            num_corner = 0;
            
            [self Animation_4_step];
        }
    }];
    
}
- (void)Animation_4_step {

    [UIView animateWithDuration:0.5 animations:^{

        _subView1.alpha = 0;
        _subView2.alpha = 0;

    } completion:^(BOOL finished) {

        [_subView1 removeFromSuperview];
        [_subView2 removeFromSuperview];
        _subView1 = nil;
        _subView2 = nil;
        [self Animation_5_step];
    }];
    
    
}
- (void)Animation_5_step {
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    label.text = @"哈哈，好好工作呢";
    label.center = CGPointMake(SCREENWIDTH/2, SCREENHEIGHT/2);
    label.textAlignment = NSTextAlignmentCenter;
    [self.GD_backView addSubview:label];
    label.alpha = 0;
    [UIView animateWithDuration:1 animations:^{
        label.alpha = 1;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.8 animations:^{
            self.GD_backView.alpha = 0;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
            [self.GD_backView removeFromSuperview];

        }];
        
        
    }];
}
#pragma mark - cornerRadius  边角动画
- (CABasicAnimation *)SetCornerRadiusWithDuration:(int)duration FromValue:(CGFloat)fromvalue ToValue:(CGFloat)tovalue Count:(CGFloat)count{
    
    CABasicAnimation *anim2 = [CABasicAnimation animationWithKeyPath:@"cornerRadius"];
    anim2.duration = duration;
    anim2.fromValue = [NSNumber numberWithFloat:fromvalue];
    anim2.toValue = [NSNumber numberWithFloat:tovalue];
    anim2.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault];
    anim2.repeatCount = count;
    anim2.removedOnCompletion=YES;
    anim2.autoreverses = YES;
    anim2.fillMode = kCAFillModeBoth;
    anim2.delegate = self;
    return anim2;
}


#pragma mark - 随机颜色
- (UIColor *) randomColor {
    CGFloat hue = ( arc4random() % 256 / 256.0 ); //0.0 to 1.0
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5; // 0.5 to 1.0,away from white
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5; //0.5 to 1.0,away from black
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
}
@end
