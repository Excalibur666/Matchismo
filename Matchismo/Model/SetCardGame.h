//
//  SetCardGame.h
//  Matchismo
//
//  Created by 王敏超 on 16/3/13.
//  Copyright © 2016年 Chao's Awesome App House. All rights reserved.
//

#import "Game.h"

@interface SetCardGame : Game

@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSInteger scoreChange;
@property (nonatomic, readwrite) NSUInteger numberOfCardsPlaying;
@property (nonatomic, readwrite) NSUInteger numberOfCardsWhenBegin;
@property (nonatomic) NSMutableArray *playerScore;
- (void)chooseCardAtIndex:(NSUInteger)index byPlayer:(NSUInteger)playerIndex;

@end
