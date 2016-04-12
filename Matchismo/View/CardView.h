//
//  cardView.h
//  Matchismo
//
//  Created by 王敏超 on 16/3/15.
//  Copyright © 2016年 Chao's Awesome App House. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Card;




@interface CardView : UIView

@property (nonatomic, strong) Card *card;
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, strong) CardView *oldCardView;
@property (nonatomic) BOOL isFirstTime;
@property (nonatomic) BOOL isLastTime;
@property (nonatomic) BOOL isOverTime;




- (void)removeCard;
- (void)flipCard;
- (void)animateRemoveCardView;
- (void)animateShowCardView;
- (void)animateOverCardView;


@end
