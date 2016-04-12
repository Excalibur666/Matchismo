//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by 王敏超 on 16/3/10.
//  Copyright © 2016年 Chao's Awesome App House. All rights reserved.
//

#import "CardMatchingGame.h"


@interface CardMatchingGame ()

@end



@implementation CardMatchingGame
@synthesize score;
@synthesize scoreChange;
@synthesize numberOfCardsPlaying;
@synthesize numberOfCardsWhenBegin;
@synthesize cards = _cards;

- (NSUInteger)numberOfCardsWhenBegin{
    return 30;
}

- (NSUInteger)numberOfCardsToMatch{
    return 2;
}

- (NSMutableArray*)cards{
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}


static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index{
    
    self.currentCard = [self cardAtIndex:index];
    self.scoreChange = 0;
    self.cardsReadyToBeMatched = nil; // 清空以前的记录
    NSUInteger indexForMatch = 0; // 2-card-mode
    
    self.currentCard.shouldUpdateView = YES;
    if (!self.currentCard.isMatched) {   // 选的没match的牌
        if (self.currentCard.isChosen) {
            // chosen card
            self.currentCard.chosen = NO;
            self.currentCard = nil;
        } else {
            // match against other chosen cards
            // not chosen card
            for (Card *otherCard in self.cards) {
                // match with chosen and not matched card
                if (otherCard.isChosen && !otherCard.isMatched) {
                    [self.cardsReadyToBeMatched addObject:otherCard]; // 把chosen的和not matched的牌加入数组
                    if (!indexForMatch) { // 选的卡数indexForMatch才为0
                        int matchScore = [self.currentCard match:self.cardsReadyToBeMatched];
                        if (matchScore) {
                            self.scoreChange = matchScore * MATCH_BONUS;
                            self.score += matchScore * MATCH_BONUS;
                            self.currentCard.matched = YES;
                            for (Card *cardForMatch in self.cardsReadyToBeMatched) {
                                cardForMatch.matched = YES;
                                cardForMatch.shouldUpdateView = YES;
                            }
                            self.numberOfCardsPlaying -= self.numberOfCardsToMatch;
                        } else {
                            self.scoreChange = -MISMATCH_PENALTY;
                            self.score -= MISMATCH_PENALTY;
                            for (Card *cardForMatch in self.cardsReadyToBeMatched) {
                                cardForMatch.chosen = NO;
                                cardForMatch.shouldUpdateView = YES;
                            }
                        }
                        break; // can only choose 2 cards for now
                    }
                    indexForMatch--;
                }
            }
            self.score -= COST_TO_CHOOSE;
            self.currentCard.chosen = YES;
        }
    }
}




@end
