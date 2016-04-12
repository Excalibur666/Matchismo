//
//  GameViewController.m
//  Matchismo
//
//  Created by 王敏超 on 16/3/15.
//  Copyright © 2016年 Chao's Awesome App House. All rights reserved.
//

#import "GameViewController.h"
#import "MatchingCardView.h"


@interface GameViewController ()

@end

@implementation GameViewController{
    UIAttachmentBehavior *_attachPoint;
}

#pragma mark override and UI control

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    //[self updateUI];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
    
    [self updateUI];
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self resetGame];
}

- (IBAction)resetButton:(UIButton *)sender {
    [self resetGame];
}

- (IBAction)addCard:(UIButton *)sender {
    for (int i = 0; i < self.game.numberNeedAdded; i++) {
        Card *card = [self.game cardWillAdded];
        if (card) {
            [self.game.cards addObject:card];
        } else {
            break;
        }
        
    }
    [self updateUI];
}




- (void)buttonClick:(UIButton*)sender{
    NSUInteger chooseButtonIndex = [self.buttons indexOfObject:sender];
    [self.game chooseCardAtIndex:chooseButtonIndex];    // lazy instantiation, instead of init method
    [self updateUI];
    NSLog(@"Click");
}


#pragma mark lazy instatiation

- (Deck*)createDeck{
    return [[Deck alloc] init];
}


- (Game*)game{
    if (!_game) {
        _game = [[Game alloc] init];
    }
    return _game;
}

- (NSMutableArray*)buttons{
    if (!_buttons) {
        _buttons = [[NSMutableArray alloc] init];
    }
    return _buttons;
}

- (Grid*)grid{
    if (!_grid) {
        _grid = [[Grid alloc] init];
    }
    return _grid;
}


- (CardView*)currentCardView{
    if (!_currentCardView) {
        _currentCardView = [[CardView alloc] init];
    }
    return _currentCardView;
}

- (NSMutableArray*)buttonViews{
    if (!_buttonViews) {
        _buttonViews = [[NSMutableArray alloc] init];
    }
    return _buttonViews;
}



#pragma mark UI update

- (void)resetGame{

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:0.4];
    [UIView setAnimationDidStopSelector:@selector(removeAllSubViewsAndAddNewSubViews)];
    
    for (CardView *view in self.buttonViews) {
        view.alpha = 0.0;
    }

    [UIView commitAnimations];
}

- (void)removeAllSubViewsAndAddNewSubViews{
    for (CardView *view in self.buttonViews) {              // remove all subviews in container view (UIButton)
        UIButton *button = (UIButton*)view.superview;       // and all subviews in UIButton (CardView)
        [view removeFromSuperview];                         // or the old button and cardview will stay in
        [button removeFromSuperview];                       // container view, the memory will become bigger and
    }                                                       // bigger.
    self.game = nil;
    self.buttons = nil;
    self.buttonViews = nil;
    [self setAllButtonsView];
    [self updateUI];
}

- (void)updateUI{
    [self updateButtons];
    [self updateAllButtonsView];
    [self updateDetailLabel];
    [self updateScoreLabel];
    [self updateOtherButton];
}


- (void)updateDetailLabel{
    //  只有当currentCard不为nil时才能更新detailLabel
    if (self.game.currentCard) {
//        NSAttributedString *string = [self getDetailAttributedString];
//        self.detailLabel.attributedText = string;
    } else {
        self.detailLabel.text = @"";
    }
}

- (void)updateButtons{
    // update buttons in subclass controller
}

- (void)updateScoreLabel{
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %ld", (long)self.game.score];
}


- (void)setAllButtonsView{
    self.grid.cellAspectRatio = 0.667; // width / height
    self.grid.size = self.allButtonsView.bounds.size;
    self.grid.minimumNumberOfCells = self.game.numberOfCardsWhenBegin; // minimum number of cards
    
    //self.allButtonsView.contentMode = UIViewContentModeRedraw;
    
    [self setPinchableView:self.allButtonsView];
    
    for (NSUInteger row = 0; row < self.grid.rowCount; row++) {
        for (NSUInteger column = 0; column < self.grid.columnCount; column++) {
            
            CGRect gridRect = [self.grid frameOfCellAtRow:row inColumn:column];
            CGPoint buttonCenter = [self.grid centerOfCellAtRow:row inColumn:column];
            
            CGRect buttonRect = CGRectMake(buttonCenter.x - roundf(gridRect.size.width / 2.0f * 0.85f), buttonCenter.y - roundf(gridRect.size.height / 2.0f * 0.85f), gridRect.size.width * 0.85f, gridRect.size.height * 0.85f);
            self.cardRect = CGRectMake(0, 0, gridRect.size.width * 0.85f, gridRect.size.height * 0.85f);
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
            button.frame = buttonRect;
            [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            
            
            [self.allButtonsView addSubview:button];
            [button addSubview:self.currentCardView];
            //button.contentMode = UIViewContentModeRedraw;
            self.currentCardView.userInteractionEnabled = NO;
            self.currentCardView.contentMode = UIViewContentModeRedraw;
            self.currentCardView.isFirstTime = YES;
            //[self setPinchableView:self.currentCardView];

            
            [self.buttonViews addObject:self.currentCardView];
            [self.buttons addObject:button];
            self.currentCardView = nil;
        }
    }
}



- (void)updateAllButtonsView{
    self.grid.cellAspectRatio = 0.667;
    self.grid.size = self.allButtonsView.bounds.size;
    self.grid.minimumNumberOfCells = self.game.numberOfCardsPlaying;
    
    if (self.grid.inputsAreValid) {
        for (int row = 0; row < self.grid.rowCount; row++) {
            for (int column = 0; column < self.grid.columnCount; column++) {
                CGRect gridRect = [self.grid frameOfCellAtRow:row inColumn:column];
                CGPoint gridCenter = [self.grid centerOfCellAtRow:row inColumn:column];
                
                CGRect buttonRect = CGRectMake(gridCenter.x - roundf(gridRect.size.width / 2.0f * 0.85f), gridCenter.y - roundf(gridRect.size.height / 2.0f * 0.85f), gridRect.size.width * 0.85f, gridRect.size.height * 0.85f);
                self.cardRect = CGRectMake(0, 0, buttonRect.size.width, buttonRect.size.height);
            
                if ((row * self.grid.columnCount + column) < self.buttons.count) {
                    UIButton *button = self.buttons[row * self.grid.columnCount+ column];
                    CardView *cardView = self.buttonViews[row * self.grid.columnCount + column];
                    
                    [UIView beginAnimations:nil context:nil];
                    [UIView setAnimationDuration:1];
                    [UIView setAnimationDelay:0.5];
                    button.frame = buttonRect;
                    cardView.frame = self.cardRect;
                    [UIView commitAnimations];
                    
                } else if ([self.game cardAtIndex:(row * self.grid.columnCount + column)]){
                    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
                    button.frame = buttonRect;
                    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
                    
                    [self.allButtonsView addSubview:button];
                    [button addSubview:self.currentCardView];
                    //button.contentMode = UIViewContentModeRedraw;
                    self.currentCardView.userInteractionEnabled = NO;
                    self.currentCardView.contentMode = UIViewContentModeRedraw;
                    self.currentCardView.card = [self.game cardAtIndex:(row * self.grid.columnCount + column)];
                    self.currentCardView.isFirstTime = YES;
                    
                    //[self setPinchableView:self.currentCardView];
                    
                    [self.buttonViews addObject:self.currentCardView];
                    [self.buttons addObject:button];
                }
                self.currentCardView = nil;
                
            }
        }
    }
}

- (void)updateOtherButton{
    if (self.game.numberNeedAdded) {
        self.addButton.hidden = NO;
        if (self.game.hasNoMoreCards) {
            self.addButton.enabled = NO;
        } else {
            self.addButton.enabled = !self.game.hasMatch;
        }
    } else {
        self.addButton.hidden = YES;
    }
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    [self updateUI];
}


#pragma mark gestureRecognizer

- (void)setPinchableView:(UIView*)pinchableView{
    UIPinchGestureRecognizer *pinchgr = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinch:)];
    [pinchableView addGestureRecognizer:pinchgr];
}



- (void)pinch:(UIPinchGestureRecognizer*)recognizer{
    if (recognizer.state == UIGestureRecognizerStateRecognized) {
        NSLog(@"pinch");
        
        self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.allButtonsView];
        CGPoint centerPoint = [recognizer locationInView:self.allButtonsView];
        
        CardView *topView = [self.buttonViews lastObject];
        //topView.userInteractionEnabled = YES;
        UIPanGestureRecognizer *pangr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        [topView addGestureRecognizer:pangr];
        
        
        for (CardView *view in self.buttonViews) {
            NSUInteger index = [self.buttonViews indexOfObject:view];
            [UIView animateWithDuration:0.5 animations:^{
                if (index != self.buttonViews.count - 1) {
                    UIAttachmentBehavior *attach = [[UIAttachmentBehavior alloc] initWithItem:view attachedToItem:topView];
                    attach.length = arc4random() % 30;
                    [self.animator addBehavior:attach];
                } else {
                    UIAttachmentBehavior *attach = [[UIAttachmentBehavior alloc] initWithItem:view attachedToAnchor:centerPoint];
                    NSLog(@"%lf %lf", centerPoint.x, centerPoint.y);
                    //attach.length = 0;
                    [self.animator addBehavior:attach];
                }
            }completion:^(BOOL finish){
                
            }];
        }
        NSLog(@"%@", topView.gestureRecognizers);
    }
}




- (void)pan:(UIPanGestureRecognizer*)recognizer{
    NSLog(@"pan");
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        CGPoint touchPoint = [recognizer translationInView:self.allButtonsView];
        _attachPoint = [[UIAttachmentBehavior alloc] initWithItem:[self.buttonViews lastObject] attachedToAnchor:touchPoint];
        [self.animator addBehavior:_attachPoint];
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        NSLog(@"%lf %lf", [recognizer translationInView:self.allButtonsView].x,  [recognizer translationInView:self.allButtonsView].y);
        _attachPoint.anchorPoint = [recognizer translationInView:self.allButtonsView];
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        [self.animator removeBehavior:_attachPoint];
        _attachPoint = nil;
    }
}

- (IBAction)dragPile:(UIPanGestureRecognizer *)sender {
    if ((sender.state == UIGestureRecognizerStateBegan || sender.state == UIGestureRecognizerStateChanged || sender.state == UIGestureRecognizerStateEnded) && self.animator.behaviors) {
        NSLog(@"pan!");
        
        CGPoint touchPoint = [sender translationInView:self.allButtonsView];
        UIAttachmentBehavior *attach = [self.animator.behaviors lastObject];
        attach.anchorPoint = CGPointMake(attach.anchorPoint.x + touchPoint.x, attach.anchorPoint.y + touchPoint.y);
        NSLog(@"%lf, %lf, %lf, %lf", attach.anchorPoint.x, attach.anchorPoint.y, touchPoint.x, touchPoint.y);
        [sender setTranslation:CGPointZero inView:self.allButtonsView];
        
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
