//
//  cardView.m
//  Matchismo
//
//  Created by 王敏超 on 16/3/15.
//  Copyright © 2016年 Chao's Awesome App House. All rights reserved.
//

#import "CardView.h"

@implementation CardView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.opaque = NO;
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect {
    // Drawing code
//}


- (void)animateRemoveCardView{
    if (self.alpha == 1.0) {
        [UIView animateWithDuration:1.0 delay:0.5 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.alpha = 0.0;
        }completion:^(BOOL finish){
            //[self removeFromSuperview];
        }];
    }
}

- (void)animateShowCardView{
    if (self.alpha == 0.0) {
        [UIView animateWithDuration:1.0 delay:0.7 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.alpha = 1.0;
        }completion:nil];
    }
}

- (void)animateOverCardView{
    if (self.alpha == 1.0) {
        [UIView animateWithDuration:1.0 delay:0.5 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            self.alpha = 0.0;
        }completion:^(BOOL finish){
            UIButton *button = (UIButton*)self.superview;
            [self removeFromSuperview];
            [button removeFromSuperview];
        }];
    }
}

@end
