//
//  SetGameViewController.m
//  Matchismo
//
//  Created by 王敏超 on 16/3/13.
//  Copyright © 2016年 Chao's Awesome App House. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardGame.h"
#import "SetCardDeck.h"
#import "SetCard.h"
#import "SetCardView.h"

@interface SetGameViewController ()

@end

@implementation SetGameViewController

@synthesize game = _game;
@synthesize currentCardView = _currentCardView;


- (Deck*)createDeck{
    return [[SetCardDeck alloc] init];
}

- (Game*)game{
    if (!_game) {
        _game = [[SetCardGame alloc] initWithCardCount:12 usingDeck:[self createDeck]];
    }
    return _game;
}

- (CardView*)currentCardView{
    if (!_currentCardView) {
        _currentCardView = [[SetCardView alloc] initWithFrame:self.cardRect];
    }
    return _currentCardView;
}

- (void)updateButtons{

    for (int index = 0; index < self.buttons.count; index++) {
        //NSUInteger index = [self.buttons indexOfObject:button];
        UIButton *button = self.buttons[index];
        Card *card = [self.game cardAtIndex:index];
        self.currentCardView = self.buttonViews[index];
        self.currentCardView.card = card;
        
        if (card.isMatched) {
            [self.buttons removeObject:button];
            [self.buttonViews removeObject:self.currentCardView];
            [self.game.cards removeObject:card];
            index--;
            
            //[self.currentCardView removeFromSuperview];
            self.currentCardView.isLastTime = YES;
            //[button removeFromSuperview];
        }
        button.enabled = !card.isMatched;

        if (card.shouldUpdateView) {
            [self.currentCardView setNeedsDisplay];
            card.shouldUpdateView = NO;
        }
    }
   
    
}

- (void)updateOtherButton{
    if (self.game.hasMatch) {
        self.findSetButton.hidden = NO;
        self.addButton.hidden = YES;
    } else {
        self.addButton.hidden = self.game.hasNoMoreCards ? YES : NO;
        self.findSetButton.hidden = YES;
    }
}

- (IBAction)findASet:(UIButton *)sender {
    NSArray *matchArray = self.game.hasMatch;
    for (SetCard *card in matchArray) {
        NSUInteger index = [self.game.cards indexOfObject:card];
        SetCardView *view = self.buttonViews[index];
        view.shouldIndicate = YES;
        [view setNeedsDisplay];
    }
}

- (void)updateScoreLabel{
    SetCardGame *game = (SetCardGame*)self.game;
    self.scoreLabel.text = [NSString stringWithFormat:@"%@ : %@", game.playerScore[0], game.playerScore[1]];
}

- (void)buttonClick:(UIButton*)sender{
    SetCardGame *game = (SetCardGame*)self.game;
    NSUInteger chooseButtonIndex = [self.buttons indexOfObject:sender];
    [game chooseCardAtIndex:chooseButtonIndex byPlayer:self.playerSegmentedControl.selectedSegmentIndex];    // lazy instantiation, instead of init method
    [self updateUI];
    NSLog(@"Click");
}

@end
