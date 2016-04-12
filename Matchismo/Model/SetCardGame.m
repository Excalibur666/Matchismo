//
//  SetCardGame.m
//  Matchismo
//
//  Created by 王敏超 on 16/3/13.
//  Copyright © 2016年 Chao's Awesome App House. All rights reserved.
//

#import "SetCardGame.h"


@interface SetCardGame ()

@end


@implementation SetCardGame
@synthesize score;
@synthesize scoreChange;
@synthesize numberOfCardsPlaying;
@synthesize numberOfCardsWhenBegin;


- (NSMutableArray*)playerScore{
    if (!_playerScore) {
        _playerScore = [[NSMutableArray alloc] initWithObjects:@0, @0, nil];
    }
    return _playerScore;
}

- (NSUInteger)numberOfCardsWhenBegin{
    return 12;
}

- (NSUInteger)numberNeedAdded{
    return 3;
}


- (NSUInteger)numberOfCardsToMatch{
    return 3;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;


- (void)chooseCardAtIndex:(NSUInteger)index byPlayer:(NSUInteger)playerIndex{
    self.currentCard = [self cardAtIndex:index]; // card chosen now
    self.cardsReadyToBeMatched = nil; // clear cardsForSet before
    int countForSet = 2; // there are 2 cards should be put in cardsForSet
    BOOL failToMatchWhenThreeCardsSelected = NO;
    self.scoreChange = 0;
    
    self.currentCard.shouldUpdateView = YES;
    if (self.currentCard.chosen) {
        self.currentCard.chosen = NO;
    } else {
        for (Card *otherCard in self.cards) {
            if (otherCard.isChosen && !otherCard.matched) {
                [self.cardsReadyToBeMatched addObject:otherCard]; // cards chosen before will be added
                countForSet--;
                
                if (!countForSet) {  // 3-cards selected! let's match!
                    int scoreForSet = [self.currentCard match:self.cardsReadyToBeMatched];
                    if (scoreForSet) {
                        for (Card *card in self.cardsReadyToBeMatched) {
                            card.matched = YES;
                            card.shouldUpdateView = YES;
                        }
                        self.currentCard.matched = YES;
                        self.scoreChange += scoreForSet * MATCH_BONUS;
                        self.numberOfCardsPlaying -= self.numberOfCardsToMatch;
                        
                    } else {
                        for (Card *card in self.cardsReadyToBeMatched) {
                            card.chosen = NO;
                            card.shouldUpdateView = YES;
                        }
                        failToMatchWhenThreeCardsSelected = YES;
                        self.scoreChange -= MISMATCH_PENALTY;
                    }
                    break;
                }
            }
            
        }
        if (!failToMatchWhenThreeCardsSelected) {
            self.currentCard.chosen = YES;
        }
        
        NSNumber *pScore = self.playerScore[playerIndex];
        int sc = pScore.intValue;
        sc += self.scoreChange;
        sc -= COST_TO_CHOOSE;
        NSNumber *newsc = [[NSNumber alloc] initWithInt:sc];
        self.playerScore[playerIndex] = newsc;
    }
}


- (NSArray*)hasMatch{
    NSInteger flag;
    NSMutableArray *arrayReadyToMatched = [[NSMutableArray alloc] init];
    for (int i = 0; i < self.cards.count - 2; i++) {
        for (int j = i + 1; j < self.cards.count - 1; j++) {
            for (int k = j + 1; k < self.cards.count; k++) {
                [arrayReadyToMatched addObject:self.cards[j]];
                [arrayReadyToMatched addObject:self.cards[k]];
                flag = [self.cards[i] match:arrayReadyToMatched];
                if (flag) {
                    NSMutableArray *matchArray = [[NSMutableArray alloc] init];
                    [matchArray addObject:self.cards[i]];
                    [matchArray addObjectsFromArray:arrayReadyToMatched];
                    return matchArray;
                }
                [arrayReadyToMatched removeAllObjects];
            }
        }
    }
    
    return nil;
}




@end
