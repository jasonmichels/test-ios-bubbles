//
//  BubblesModel.h
//  Bubbles
//
//  Created by Jason Michels on 6/18/13.
//  Copyright (c) 2013 Jason Michels. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BubbleView.h"

@interface BubblesModel : NSObject
{
    NSMutableArray *bubbles;
    
    int startingYPosition;
    int offSet;
    int bubbleWidth;
    int bubbleHeight;
    
    int missedBubbles;
    int score;
    
    float screenWidth;
    float screenHeight;
    
    int gameOver;
    NSString *endGameMessage;
}

@property int startingYPosition;
@property int offSet;
@property int bubbleWidth;
@property int bubbleHeight;
@property NSString *endGameMessage;
@property int gameOver;
@property int score;
@property int missedBubbles;
@property float screenWidth;
@property float screenHeight;
@property (nonatomic, retain) NSMutableArray *bubbles;


-(BubbleView*)addBubble;
-(void)drawBubbles;
-(void)popBubble: (BubbleView*)bubble;
-(void)clearBubbles;

@end
