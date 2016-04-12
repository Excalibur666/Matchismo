//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by 王敏超 on 16/3/10.
//  Copyright © 2016年 Chao's Awesome App House. All rights reserved.
//
// 用于声明卡牌匹配游戏的各种方法
#import "Game.h"

@interface CardMatchingGame : Game

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSInteger scoreChange;
@property (nonatomic, readwrite) NSUInteger numberOfCardsPlaying;
@property (nonatomic, readwrite) NSUInteger numberOfCardsWhenBegin;
@end
