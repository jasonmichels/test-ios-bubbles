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
#define GAME_OVER_MISSED_BUBBLES 25

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
// Bubbles user missed with finger
@property (nonatomic)NSUInteger missedBubbles;
// Bubbles dropped off bottom of screen
@property (nonatomic)NSInteger droppedBubbles;
@property (nonatomic)NSInteger totalMissedBubbles;


-(BubbleView*)addBubble;
-(void)drawBubbles;
-(void)popBubble: (BubbleView*)bubble;
-(void)clearBubbles;

@end
