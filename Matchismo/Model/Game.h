//
//  Game.h
//  Matchismo
//
//  Created by 王敏超 on 16/3/15.
//  Copyright © 2016年 Chao's Awesome App House. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
#import "Deck.h"

@interface Game : NSObject

@property (nonatomic, strong) NSMutableArray *history;
@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, readonly) NSInteger scoreChange;
@property (nonatomic, strong) NSMutableArray *cardsReadyToBeMatched; //of Card
@property (nonatomic, strong) Card *currentCard;
@property (nonatomic, strong) Deck *deck;
@property (nonatomic, strong) NSMutableArray *cards; // of Card, UI上呈现多少的卡牌
@property (nonatomic, readonly) NSUInteger numberOfCardsToMatch;
@property (nonatomic, readonly) NSUInteger numberOfCardsPlaying;
@property (nonatomic, strong) NSArray* hasMatch; // whether the playing cards have match
@property (nonatomic, readonly) NSUInteger numberNeedAdded; // descripe whether need a add button at UI, if not, zero default
@property (nonatomic, readonly) NSUInteger numberOfCardsWhenBegin;
@property (nonatomic, readonly) BOOL hasNoMoreCards;


- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck*)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card*)cardAtIndex:(NSUInteger)index;
- (Card*)cardWillAdded;
- (void)replaceCardAtIndex:(NSUInteger)index withCard:(Card*)card;


@end
