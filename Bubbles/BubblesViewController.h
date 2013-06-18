//
//  BubblesViewController.h
//  Bubbles
//
//  Created by Jason Michels on 3/29/13.
//  Copyright (c) 2013 Jason Michels. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "BubbleView.h"

@interface BubblesViewController : UIViewController{
    NSMutableArray *bubblesArray;
    CADisplayLink *gameTimer;
    CADisplayLink *addBubbleTimer;
    int missedBubbles;
    int score;
}

@property int score;
@property int missedBubbles;
@property (nonatomic, retain) NSMutableArray *bubblesArray;

-(void)updateDisplay:(CADisplayLink*)sender;

@end
