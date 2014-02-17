//
//  BubblesModel.h
//  Bubbles
//
//  Created by Jason Michels on 6/18/13.
//  Copyright (c) 2013 Jason Michels. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BubbleView.h"

#define BUBBLE_SIZE 100
#define GAME_OVER_MISSED_BUBBLES 2
#define GRAVITY 2
#define GRAVITY_SECOND_LEVEL 3
#define GRAVITY_THIRD_LEVEL 4
#define SECOND_LEVEL 30
#define THIRD_LEVEL 50

@interface BubblesModel : NSObject

@property NSInteger startingYPosition;
@property (nonatomic)NSUInteger offSet;
@property (nonatomic)NSUInteger bubbleWidth;
@property (nonatomic)NSUInteger bubbleHeight;
@property (strong, nonatomic)NSString *endGameMessage;
@property (nonatomic)NSUInteger gameOver;
@property (nonatomic)NSUInteger score;
@property float screenWidth;
@property float screenHeight;
@property (strong, nonatomic) NSMutableArray *bubbles;
// Bubbles dropped off bottom of screen
@property (nonatomic)NSInteger missedBubbles;
@property (nonatomic)NSInteger gravity;


-(BubbleView*)addBubble;
-(void)drawBubbles;
-(void)popBubble: (BubbleView*)bubble;
-(void)clearBubbles;

@end
