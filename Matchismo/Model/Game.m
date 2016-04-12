//
//  Game.m
//  Matchismo
//
//  Created by 王敏超 on 16/3/15.
//  Copyright © 2016年 Chao's Awesome App House. All rights reserved.
//

#import "Game.h"


@interface Game ()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, readwrite) NSInteger scoreChange;
@property (nonatomic, readwrite) NSUInteger numberOfCardsPlaying;
@property (nonatomic, readwrite) BOOL hasNoMoreCards;
@end



@implementation Game

- (BOOL)hasNoMoreCards{
    return self.deck.hasNoMoreCards;
}

- (NSMutableArray*)history{
    if (!_history) {
        _history = [[NSMutableArray alloc] init];
    }
    return _history;
}


- (NSMutableArray*)cards{
    if (!_cards) {
        _cards
        = [[NSMutableArray alloc] init];
    }
    return _cards;
}


- (NSMutableArray*)cardsReadyToBeMatched{
    if (!_cardsReadyToBeMatched) {
        _cardsReadyToBeMatched = [[NSMutableArray alloc] init];
    }
    return _cardsReadyToBeMatched;
}


- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck{
    self.deck = deck;
    self.numberOfCardsPlaying = count;
    
    if ((self = [super init])) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard]; // different cards
            if (card){
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    return self;
}

- (Card*)cardAtIndex:(NSUInteger)index{
    return (index < self.cards.count) ? self.cards[index] : nil;
}

- (void)chooseCardAtIndex:(NSUInteger)index{
    if (!self.currentCard.isMatched) {
        if (self.currentCard.isChosen) {
            // chosen card
            self.currentCard.chosen = NO;
        } else {
            self.currentCard.chosen = YES;
        }
    }

}


- (Card*)cardWillAdded{
    Card *card = [self.deck drawRandomCard];
    if (card) {
        self.numberOfCardsPlaying += 1;
    }
    
    return card ? card : nil;
}


- (void)replaceCardAtIndex:(NSUInteger)index withCard:(Card *)card{
    [self.cards replaceObjectAtIndex:index withObject:card];
}



@end
