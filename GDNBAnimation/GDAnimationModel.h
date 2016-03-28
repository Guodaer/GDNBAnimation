//
//  GDAnimationModel.h
//  GDNBAnimation
//
//  Created by xiaoyu on 16/3/25.
//  Copyright © 2016年 Guoda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

@interface GDAnimationModel : NSObject

+ (instancetype) shareInstance;
- (void)CreateAmazing_AnimationWithSuperView:(UIView *)SuperView;


@end
