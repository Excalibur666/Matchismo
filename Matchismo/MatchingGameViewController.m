//
//  ViewController.m
//  Matchismo
//
//  Created by 王敏超 on 16/3/9.
//  Copyright © 2016年 Chao's Awesome App House. All rights reserved.
//

#import "MatchingGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "MatchingCardView.h"

@implementation MatchingGameViewController

@synthesize game = _game;
@synthesize currentCardView = _currentCardView;
@synthesize otherCardView = _otherCardView;

- (Game*)game{
    if (!_game) {
        _game = [[CardMatchingGame alloc] initWithCardCount:30 usingDeck:[self createDeck]];
    }
    return _game;
}


- (Deck*)createDeck{
    return [[PlayingCardDeck alloc] init];
}

- (CardView*)currentCardView{
    if (!_currentCardView) {
        _currentCardView = [[MatchingCardView alloc] initWithFrame:self.cardRect];
    }
    return _currentCardView;
}

- (CardView*)otherCardView{
    if (!_otherCardView) {
        _otherCardView = [[MatchingCardView alloc] initWithFrame:self.cardRect];
    }
    return _otherCardView;
}

- (void)updateButtons{
    for (UIButton *button in self.buttons) {
        NSUInteger index = [self.buttons indexOfObject:button];
        Card *card = [self.game cardAtIndex:index];
        self.currentCardView = self.buttonViews[index];
        self.currentCardView.card = card;
        
        if (card.isMatched) {
            if ((self.otherCardView.card = [self.game cardWillAdded])) {        //  if there is not card, get out
                
                self.otherCardView.oldCardView = self.currentCardView;
                self.otherCardView.userInteractionEnabled = NO;
                [button addSubview:self.otherCardView];
                
                [self.buttonViews replaceObjectAtIndex:index withObject:self.otherCardView];
                [self.game replaceCardAtIndex:index withCard:self.otherCardView.card];
                
                self.currentCardView.isLastTime = YES;
                [self.currentCardView setNeedsDisplay];         // We want the old card show itself before disapear
                self.currentCardView = self.otherCardView;
                self.currentCardView.isFirstTime = YES;
                
                card = self.currentCardView.card;
                self.otherCardView = nil;
            } else {
                //self.currentCardView.oldCardView = self.currentCardView;
                self.currentCardView.isLastTime = YES;
            }
        }
        button.enabled = !card.isMatched;
        
        if (card.shouldUpdateView) {
            [self.currentCardView setNeedsDisplay];
            
        }
    }
    
}

@end
