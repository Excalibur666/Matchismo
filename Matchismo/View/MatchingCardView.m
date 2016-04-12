//
//  MatchingCardView.m
//  Matchismo
//
//  Created by 王敏超 on 16/3/15.
//  Copyright © 2016年 Chao's Awesome App House. All rights reserved.
//

#import "MatchingCardView.h"
#import "PlayingCard.h"

@implementation MatchingCardView{
    BOOL _rankIsTen;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha = 0.0;
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    UIImage *image = [self backgroundImageForCard:self.card];
    NSAttributedString *title = [self titleForCard:self.card];
    
    if (self.isLastTime) {
        [self animateRemoveCardView];
    }
    
    if (self.oldCardView) {
        //  this is necessary, we only want to do this for one time, and we should not put nil to
        //  oldCardView after animateReplaceOldCardView method, as we can't not flip card at that time.
        self.oldCardView = nil;
        [self animateReplaceOldCardView];
        
    } else if (!self.isOverTime){
        if (self.card.shouldUpdateView) {
            [self flipCardForImage:image andTitle:title inRect:rect];
            self.card.shouldUpdateView = NO;
        } else {
            [self normalDraw:image andTitle:title inRect:rect];
        }
        
    }
    
    if (self.isFirstTime) {
        [image drawInRect:rect];
        if (_rankIsTen) {
            [title drawAtPoint:CGPointMake(0.1 * rect.size.width, 0.3 * rect.size.height)];
        } else {
            [title drawAtPoint:CGPointMake(0.2 * rect.size.width, 0.3 * rect.size.height)];
        }
        [self animateShowCardView];
        self.isFirstTime = NO;
    }
    
    if (self.isOverTime) {
        [self animateOverCardView];
    }
    
    
}

- (void)normalDraw:(UIImage*)image andTitle:(NSAttributedString*)title inRect:(CGRect)rect{

    [UIView transitionWithView:self duration:0.3 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        [image drawInRect:rect];
        if (_rankIsTen) {
            [title drawAtPoint:CGPointMake(0.1 * rect.size.width, 0.3 * rect.size.height)];
        } else {
            [title drawAtPoint:CGPointMake(0.2 * rect.size.width, 0.3 * rect.size.height)];
        }
    }completion:nil];
}

- (void)flipCardForImage:(UIImage*)image andTitle:(NSAttributedString*)title inRect:(CGRect)rect{
    
    //  Though there is a old(matched) card, we need to show what it draws first.
    [UIView transitionWithView:self duration:0.3 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        [image drawInRect:rect];
        if (_rankIsTen) {
            [title drawAtPoint:CGPointMake(0.1 * rect.size.width, 0.3 * rect.size.height)];
        } else {
            [title drawAtPoint:CGPointMake(0.2 * rect.size.width, 0.3 * rect.size.height)];
        }
    }completion:nil];
}

- (void)animateReplaceOldCardView{
    [UIView animateWithDuration:1 delay:1 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.alpha = 1.0;
    }completion:^(BOOL finish){
        [UIView transitionFromView:self.oldCardView toView:self duration:0.5 options:UIViewAnimationOptionShowHideTransitionViews completion:nil];
        
    }];
}

- (void)takeAnotherCardWithImage:(UIImage*)image andTitle:(NSAttributedString*)title inRect:(CGRect)rect{
    [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        self.oldCardView.alpha = 0;     // let the old card fade out
    }completion:^(BOOL finish){
        if (self.oldCardView != self) {
        [UIView transitionFromView:self.oldCardView toView:self duration:1 options:UIViewAnimationOptionShowHideTransitionViews completion:^(BOOL finish){
            // now the new card cover the old one.
            
                [UIView animateWithDuration:1 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
                    self.alpha = 1;         // let the new card fade in
                }completion:nil];
            
        }];
        }
        self.oldCardView = nil;
    }];
}

- (NSAttributedString*)titleForCard:(Card*)card{

    return card.isChosen ? [self getAttributesForCard:card] : [[NSAttributedString alloc] initWithString:@""];
}

- (UIImage*)backgroundImageForCard:(Card*)card{

    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (NSMutableAttributedString*)getAttributesForCard:(Card*)card{
    PlayingCard *playingCard = (PlayingCard*)card;
    _rankIsTen = (playingCard.rank == 10) ? YES : NO;

    NSString *string = card.contents;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange range = {0, string.length}; // only one character here
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];

    // color
    UIColor *color;
    if ([playingCard.suit isEqualToString:@"♠︎"] || [playingCard.suit isEqualToString:@"♣︎"]) {
        color = [UIColor blackColor];
    } else {
        color = [UIColor redColor];
    }

    [attributes addEntriesFromDictionary:@{NSForegroundColorAttributeName : [color colorWithAlphaComponent:1], NSFontAttributeName : [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline]}];


    [attributedString addAttributes:attributes range:range];
    return attributedString;
}


@end
