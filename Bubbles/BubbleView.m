//
//  BubbleView.m
//  Bubbles
//
//  Created by Jason Michels on 6/17/13.
//  Copyright (c) 2013 Jason Michels. All rights reserved.
//

#import "BubbleView.h"

@implementation BubbleView

#pragma mark Custom initializer
-(id)init
{
    self = [super initWithImage:[UIImage imageNamed:@"bubblet.png"]];
    if (self) {
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)pop
{
    [self removeFromSuperview];
    return;
}

@end
