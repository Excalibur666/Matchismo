//
//  GameViewController.h
//  Matchismo
//
//  Created by 王敏超 on 16/3/15.
//  Copyright © 2016年 Chao's Awesome App House. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Game.h"
#import "Deck.h"
#import "Grid.h"
#import "CardView.h"

@interface GameViewController : UIViewController


@property (nonatomic, strong) Game *game;
@property (nonatomic, strong) Grid *grid;
@property (nonatomic, strong) CardView *currentCardView;
@property (nonatomic, strong) CardView *otherCardView;
@property (nonatomic) CGRect cardRect;
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) NSMutableArray *buttonViews;
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (weak, nonatomic) IBOutlet UIView *allButtonsView;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIButton *addButton;


- (IBAction)resetButton:(UIButton *)sender;
- (IBAction)addCard:(UIButton *)sender;
- (IBAction)dragPile:(UIPanGestureRecognizer *)sender;

- (Deck*)createDeck;

- (void)updateUI;

@end
