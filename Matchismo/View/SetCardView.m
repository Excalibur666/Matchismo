//
//  SetCardView.m
//  Matchismo
//
//  Created by 王敏超 on 16/3/15.
//  Copyright © 2016年 Chao's Awesome App House. All rights reserved.
//

#import "SetCardView.h"
#import "SetCard.h"

@implementation SetCardView{
    CGFloat _ratio;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha = 0;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIImage *image = [self backgroundImageForCard:self.card];
    
    [image drawInRect:rect];
    [self updateViewForCard:self.card inRect:rect withContext:context];
    if (self.shouldIndicate) {
        [self drawStar:rect];
        self.shouldIndicate = NO;
    }
    
    if (self.isFirstTime) {
        [self animateShowCardView];
        self.isFirstTime = NO;
    }
    if (self.isLastTime) {
        [self animateRemoveCardView];
    }
}


- (void)drawStar:(CGRect)rect{
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    [attributes addEntriesFromDictionary:@{
                                          NSFontAttributeName : [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline],
                                          NSForegroundColorAttributeName : [UIColor  cyanColor]
                                          }];
    NSAttributedString *star = [[NSAttributedString alloc] initWithString:@"☆" attributes:attributes];
    [star drawInRect:rect];
}

- (UIImage*)backgroundImageForCard:(Card*)card{
    return self.card.isChosen ? [UIImage imageNamed:@"yellowbg"] : [UIImage imageNamed:@"greybg"];
}


- (void)updateViewForCard:(Card*)card inRect:(CGRect)rect withContext:(CGContextRef)context{
    CGContextSaveGState(context);
    
    SetCard *setCard = (SetCard*)card;
    
    UIBezierPath *path = [[UIBezierPath alloc] init];
    
    // let's draw
    path.lineWidth = 1.5;
    if (setCard.number == 1) {
        if ([setCard.symbol isEqualToString:@"squiggle"]) {
            // this is the middle one
            [path moveToPoint:CGPointMake(0.230 * rect.size.width, 0.597 * rect.size.height)];
            [path addCurveToPoint:CGPointMake(0.348 * rect.size.width, 0.383 * rect.size.height) controlPoint1:CGPointMake(0.041 * rect.size.width, 0.665 * rect.size.height) controlPoint2:CGPointMake(0.009 * rect.size.width, 0.410 * rect.size.height)];
            
            [path addCurveToPoint:CGPointMake(0.716 * rect.size.width, 0.405 * rect.size.height) controlPoint1:CGPointMake(0.581 * rect.size.width, 0.381 * rect.size.height) controlPoint2:CGPointMake(0.434 * rect.size.width, 0.509 * rect.size.height)];
            
            [path addCurveToPoint:CGPointMake(0.609 *rect.size.width, 0.608 * rect.size.height) controlPoint1:CGPointMake(0.992 * rect.size.width, 0.295 * rect.size.height) controlPoint2:CGPointMake(0.889 * rect.size.width, 0.590 * rect.size.height)];
            
            [path addCurveToPoint:CGPointMake(0.230 * rect.size.width, 0.597 * rect.size.height) controlPoint1:CGPointMake(0.427 * rect.size.width, 0.619 * rect.size.height) controlPoint2:CGPointMake(0.508 * rect.size.width, 0.490 * rect.size.height)];
        } else if ([setCard.symbol isEqualToString:@"diamond"]) {
            [path moveToPoint:CGPointMake(0.2 * rect.size.width, 0.5 * rect.size.height)];
            [path addLineToPoint:CGPointMake(0.5 * rect.size.width, 0.4 * rect.size.height)];
            [path addLineToPoint:CGPointMake(0.8 * rect.size.width, 0.5 * rect.size.height)];
            [path addLineToPoint:CGPointMake(0.5 * rect.size.width, 0.6 * rect.size.height)];
            [path closePath];
        } else {
            path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.1 * rect.size.width, 0.4 * rect.size.height, 0.8 * rect.size.width, 0.2 * rect.size.height) cornerRadius:0.1 * rect.size.width];
        }
    } else if (setCard.number == 2) {
        _ratio = 0.15;
        if ([setCard.symbol isEqualToString:@"squiggle"]) {
            
            [path moveToPoint:CGPointMake(0.230 * rect.size.width, (0.597 - _ratio) * rect.size.height)];
            [path addCurveToPoint:CGPointMake(0.348 * rect.size.width, (0.383 - _ratio) * rect.size.height) controlPoint1:CGPointMake(0.041 * rect.size.width, (0.665 - _ratio) * rect.size.height) controlPoint2:CGPointMake(0.009 * rect.size.width, (0.410 - _ratio) * rect.size.height)];
            
            [path addCurveToPoint:CGPointMake(0.716 * rect.size.width, (0.405 - _ratio) * rect.size.height) controlPoint1:CGPointMake(0.581 * rect.size.width, (0.381 - _ratio) * rect.size.height) controlPoint2:CGPointMake(0.434 * rect.size.width, (0.509 - _ratio) * rect.size.height)];
            
            [path addCurveToPoint:CGPointMake(0.609 *rect.size.width, (0.608 - _ratio) * rect.size.height) controlPoint1:CGPointMake(0.992 * rect.size.width, (0.295 - _ratio) * rect.size.height) controlPoint2:CGPointMake(0.889 * rect.size.width, (0.590 - _ratio) * rect.size.height)];
            
            [path addCurveToPoint:CGPointMake(0.230 * rect.size.width, (0.597 - _ratio) * rect.size.height) controlPoint1:CGPointMake(0.427 * rect.size.width, (0.619 - _ratio) * rect.size.height) controlPoint2:CGPointMake(0.508 * rect.size.width, (0.490 - _ratio) * rect.size.height)];
            
            _ratio = -_ratio;
            [path moveToPoint:CGPointMake(0.230 * rect.size.width, (0.597 - _ratio) * rect.size.height)];
            [path addCurveToPoint:CGPointMake(0.348 * rect.size.width, (0.383 - _ratio) * rect.size.height) controlPoint1:CGPointMake(0.041 * rect.size.width, (0.665 - _ratio) * rect.size.height) controlPoint2:CGPointMake(0.009 * rect.size.width, (0.410 - _ratio) * rect.size.height)];
            
            [path addCurveToPoint:CGPointMake(0.716 * rect.size.width, (0.405 - _ratio) * rect.size.height) controlPoint1:CGPointMake(0.581 * rect.size.width, (0.381 - _ratio) * rect.size.height) controlPoint2:CGPointMake(0.434 * rect.size.width, (0.509 - _ratio) * rect.size.height)];
            
            [path addCurveToPoint:CGPointMake(0.609 *rect.size.width, (0.608 - _ratio) * rect.size.height) controlPoint1:CGPointMake(0.992 * rect.size.width, (0.295 - _ratio) * rect.size.height) controlPoint2:CGPointMake(0.889 * rect.size.width, (0.590 - _ratio) * rect.size.height)];
            
            [path addCurveToPoint:CGPointMake(0.230 * rect.size.width, (0.597 - _ratio) * rect.size.height) controlPoint1:CGPointMake(0.427 * rect.size.width, (0.619 - _ratio) * rect.size.height) controlPoint2:CGPointMake(0.508 * rect.size.width, (0.490 - _ratio) * rect.size.height)];

        } else if ([setCard.symbol isEqualToString:@"diamond"]) {
            [path moveToPoint:CGPointMake(0.2 * rect.size.width, (0.5 - _ratio) * rect.size.height)];
            [path addLineToPoint:CGPointMake(0.5 * rect.size.width, (0.4 - _ratio) * rect.size.height)];
            [path addLineToPoint:CGPointMake(0.8 * rect.size.width, (0.5 - _ratio) * rect.size.height)];
            [path addLineToPoint:CGPointMake(0.5 * rect.size.width, (0.6 - _ratio) * rect.size.height)];
            [path closePath];
            
            _ratio = -_ratio;
            [path moveToPoint:CGPointMake(0.2 * rect.size.width, (0.5 - _ratio) * rect.size.height)];
            [path addLineToPoint:CGPointMake(0.5 * rect.size.width, (0.4 - _ratio) * rect.size.height)];
            [path addLineToPoint:CGPointMake(0.8 * rect.size.width, (0.5 - _ratio) * rect.size.height)];
            [path addLineToPoint:CGPointMake(0.5 * rect.size.width, (0.6 - _ratio) * rect.size.height)];
            [path closePath];
        } else {
            path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.1 * rect.size.width, (0.4 - _ratio) * rect.size.height, 0.8 * rect.size.width, 0.2 * rect.size.height) cornerRadius:0.1 * rect.size.width];
            
            _ratio = -_ratio;
            [path appendPath:[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.1 * rect.size.width, (0.4 - _ratio) * rect.size.height, 0.8 * rect.size.width, 0.2 * rect.size.height) cornerRadius:0.1 * rect.size.width]];
        }
    } else {
        _ratio = 0.25;
        if ([setCard.symbol isEqualToString:@"squiggle"]) {
            [path moveToPoint:CGPointMake(0.230 * rect.size.width, (0.597 - _ratio) * rect.size.height)];
            [path addCurveToPoint:CGPointMake(0.348 * rect.size.width, (0.383 - _ratio) * rect.size.height) controlPoint1:CGPointMake(0.041 * rect.size.width, (0.665 - _ratio) * rect.size.height) controlPoint2:CGPointMake(0.009 * rect.size.width, (0.410 - _ratio) * rect.size.height)];
            
            [path addCurveToPoint:CGPointMake(0.716 * rect.size.width, (0.405 - _ratio) * rect.size.height) controlPoint1:CGPointMake(0.581 * rect.size.width, (0.381 - _ratio) * rect.size.height) controlPoint2:CGPointMake(0.434 * rect.size.width, (0.509 - _ratio) * rect.size.height)];
            
            [path addCurveToPoint:CGPointMake(0.609 *rect.size.width, (0.608 - _ratio) * rect.size.height) controlPoint1:CGPointMake(0.992 * rect.size.width, (0.295 - _ratio) * rect.size.height) controlPoint2:CGPointMake(0.889 * rect.size.width, (0.590 - _ratio) * rect.size.height)];
            
            [path addCurveToPoint:CGPointMake(0.230 * rect.size.width, (0.597 - _ratio) * rect.size.height) controlPoint1:CGPointMake(0.427 * rect.size.width, (0.619 - _ratio) * rect.size.height) controlPoint2:CGPointMake(0.508 * rect.size.width, (0.490 - _ratio) * rect.size.height)];
            
            _ratio = -_ratio;
            [path moveToPoint:CGPointMake(0.230 * rect.size.width, (0.597 - _ratio) * rect.size.height)];
            [path addCurveToPoint:CGPointMake(0.348 * rect.size.width, (0.383 - _ratio) * rect.size.height) controlPoint1:CGPointMake(0.041 * rect.size.width, (0.665 - _ratio) * rect.size.height) controlPoint2:CGPointMake(0.009 * rect.size.width, (0.410 - _ratio) * rect.size.height)];
            
            [path addCurveToPoint:CGPointMake(0.716 * rect.size.width, (0.405 - _ratio) * rect.size.height) controlPoint1:CGPointMake(0.581 * rect.size.width, (0.381 - _ratio) * rect.size.height) controlPoint2:CGPointMake(0.434 * rect.size.width, (0.509 - _ratio) * rect.size.height)];
            
            [path addCurveToPoint:CGPointMake(0.609 *rect.size.width, (0.608 - _ratio) * rect.size.height) controlPoint1:CGPointMake(0.992 * rect.size.width, (0.295 - _ratio) * rect.size.height) controlPoint2:CGPointMake(0.889 * rect.size.width, (0.590 - _ratio) * rect.size.height)];
            
            [path addCurveToPoint:CGPointMake(0.230 * rect.size.width, (0.597 - _ratio) * rect.size.height) controlPoint1:CGPointMake(0.427 * rect.size.width, (0.619 - _ratio) * rect.size.height) controlPoint2:CGPointMake(0.508 * rect.size.width, (0.490 - _ratio) * rect.size.height)];
            
            _ratio = 0;
            [path moveToPoint:CGPointMake(0.230 * rect.size.width, (0.597 - _ratio) * rect.size.height)];
            [path addCurveToPoint:CGPointMake(0.348 * rect.size.width, (0.383 - _ratio) * rect.size.height) controlPoint1:CGPointMake(0.041 * rect.size.width, (0.665 - _ratio) * rect.size.height) controlPoint2:CGPointMake(0.009 * rect.size.width, (0.410 - _ratio) * rect.size.height)];
            
            [path addCurveToPoint:CGPointMake(0.716 * rect.size.width, (0.405 - _ratio) * rect.size.height) controlPoint1:CGPointMake(0.581 * rect.size.width, (0.381 - _ratio) * rect.size.height) controlPoint2:CGPointMake(0.434 * rect.size.width, (0.509 - _ratio) * rect.size.height)];
            
            [path addCurveToPoint:CGPointMake(0.609 *rect.size.width, (0.608 - _ratio) * rect.size.height) controlPoint1:CGPointMake(0.992 * rect.size.width, (0.295 - _ratio) * rect.size.height) controlPoint2:CGPointMake(0.889 * rect.size.width, (0.590 - _ratio) * rect.size.height)];
            
            [path addCurveToPoint:CGPointMake(0.230 * rect.size.width, (0.597 - _ratio) * rect.size.height) controlPoint1:CGPointMake(0.427 * rect.size.width, (0.619 - _ratio) * rect.size.height) controlPoint2:CGPointMake(0.508 * rect.size.width, (0.490 - _ratio) * rect.size.height)];
            
            
        } else if ([setCard.symbol isEqualToString:@"diamond"]) {
            [path moveToPoint:CGPointMake(0.2 * rect.size.width, (0.5 - _ratio) * rect.size.height)];
            [path addLineToPoint:CGPointMake(0.5 * rect.size.width, (0.4 - _ratio) * rect.size.height)];
            [path addLineToPoint:CGPointMake(0.8 * rect.size.width, (0.5 - _ratio) * rect.size.height)];
            [path addLineToPoint:CGPointMake(0.5 * rect.size.width, (0.6 - _ratio) * rect.size.height)];
            [path closePath];
            
            _ratio = -_ratio;
            [path moveToPoint:CGPointMake(0.2 * rect.size.width, (0.5 - _ratio) * rect.size.height)];
            [path addLineToPoint:CGPointMake(0.5 * rect.size.width, (0.4 - _ratio) * rect.size.height)];
            [path addLineToPoint:CGPointMake(0.8 * rect.size.width, (0.5 - _ratio) * rect.size.height)];
            [path addLineToPoint:CGPointMake(0.5 * rect.size.width, (0.6 - _ratio) * rect.size.height)];
            [path closePath];

            _ratio = 0;
            [path moveToPoint:CGPointMake(0.2 * rect.size.width, (0.5 - _ratio) * rect.size.height)];
            [path addLineToPoint:CGPointMake(0.5 * rect.size.width, (0.4 - _ratio) * rect.size.height)];
            [path addLineToPoint:CGPointMake(0.8 * rect.size.width, (0.5 - _ratio) * rect.size.height)];
            [path addLineToPoint:CGPointMake(0.5 * rect.size.width, (0.6 - _ratio) * rect.size.height)];
            [path closePath];
        } else {
            path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.1 * rect.size.width, (0.4 - _ratio) * rect.size.height, 0.8 * rect.size.width, 0.2 * rect.size.height) cornerRadius:0.1 * rect.size.width];
            
            _ratio = -_ratio;
            [path appendPath:[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.1 * rect.size.width, (0.4 - _ratio) * rect.size.height, 0.8 * rect.size.width, 0.2 * rect.size.height) cornerRadius:0.1 * rect.size.width]];
            
            _ratio = 0;
            [path appendPath:[UIBezierPath bezierPathWithRoundedRect:CGRectMake(0.1 * rect.size.width, (0.4 - _ratio) * rect.size.height, 0.8 * rect.size.width, 0.2 * rect.size.height) cornerRadius:0.1 * rect.size.width]];
        }
    }
    
    if ([setCard.color isEqualToString:@"brown"]) {
        [[UIColor brownColor] setStroke];
    } else if ([setCard.color isEqualToString:@"red"]) {
        [[UIColor redColor] setStroke];
    } else {
        [[UIColor purpleColor] setStroke];
    }
    [path stroke];
    
    if ([setCard.shaping isEqualToString:@"striped"]) {
        path.lineWidth = 0.1;
        for (CGFloat i = 0; i < rect.size.width; i += 0.007 * rect.size.width) {
            [path moveToPoint:CGPointMake(i, 0)];
            [path addLineToPoint:CGPointMake(i, rect.size.height)];
        }
        [path addClip];
    } else if ([setCard.shaping isEqualToString:@"solid"]) {
        if ([setCard.color isEqualToString:@"brown"]) {
            [[UIColor brownColor] setFill];
        } else if ([setCard.color isEqualToString:@"red"]) {
            [[UIColor redColor] setFill];
        } else {
            [[UIColor purpleColor] setFill];
        }
        [path fill];
    }

    [path stroke];
    
    CGContextRestoreGState(context);
}


// 根据给定的card和方向返回对应的NSMutableAttributedString，由于卡牌为竖向，因此对应的长度不一样
- (NSMutableAttributedString*)getAttributesForCard:(Card*)card isProtrait:(BOOL)isProtrait{
    SetCard *setCard = (SetCard*)card;
    
    // symbol with numbers
    NSString *string;
    if (isProtrait) {
        if (setCard.number == 1) {
            string = setCard.symbol;
        } else if (setCard.number == 2) {
            string = [setCard.symbol stringByAppendingString:[NSString stringWithFormat:@"\n%@", setCard.symbol]];
        } else {
            string = [setCard.symbol stringByAppendingString:[NSString stringWithFormat:@"\n%@\n%@", setCard.symbol, setCard.symbol]];
        }
    } else {
        if (setCard.number == 1) {
            string = setCard.symbol;
        } else if (setCard.number == 2) {
            string = [setCard.symbol stringByAppendingString:setCard.symbol];
        } else {
            string = [setCard.symbol stringByAppendingString:[NSString stringWithFormat:@"%@%@", setCard.symbol, setCard.symbol]];
        }
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    NSRange range = {0, string.length}; // only one character here
    NSMutableDictionary *attributes = [[NSMutableDictionary alloc] init];
    
    // color
    UIColor *color;
    if ([setCard.color isEqualToString:@"brown"]) {
        color = [UIColor brownColor];
    } else if ([setCard.color isEqualToString:@"purple"]){
        color = [UIColor purpleColor];
    } else {
        color = [UIColor redColor];
    }
    
    // shaping
    if ([setCard.shaping isEqualToString:@"solid"]) {
        [attributes addEntriesFromDictionary:@{NSForegroundColorAttributeName : [color colorWithAlphaComponent:1], NSStrokeWidthAttributeName : @-10, NSStrokeColorAttributeName  : color}];
    } else if ([setCard.shaping isEqualToString:@"striped"]) {
        [attributes addEntriesFromDictionary:@{NSForegroundColorAttributeName : [color colorWithAlphaComponent:0.3], NSStrokeWidthAttributeName : @-10, NSStrokeColorAttributeName : color}];
    } else if ([setCard.shaping isEqualToString:@"open"]){
        [attributes addEntriesFromDictionary:@{NSForegroundColorAttributeName : [color colorWithAlphaComponent:0], NSStrokeWidthAttributeName : @-10, NSStrokeColorAttributeName  : color}];
    }
    
    [attributedString addAttributes:attributes range:range];
    return attributedString;
}


- (NSAttributedString*)updateViewForCard:(Card*)card{
    return [self getAttributesForCard:card isProtrait:YES];
}


@end
