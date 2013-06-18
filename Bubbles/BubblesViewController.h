//
//  BubblesViewController.h
//  Bubbles
//
//  Created by Jason Michels on 3/29/13.
//  Copyright (c) 2013 Jason Michels. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "BubblesModel.h"

#define FRAME_INTERVAL 100

@interface BubblesViewController : UIViewController{
    BubblesModel *bubbleModel;
    CADisplayLink *gameTimer;
    CADisplayLink *addBubbleTimer;
}

@property BubblesModel *bubbleModel;

-(void)updateDisplay:(CADisplayLink*)sender;
-(void)endGame;
-(void)addBubble;

@end
