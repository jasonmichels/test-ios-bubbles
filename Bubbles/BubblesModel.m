//
//  BubblesModel.m
//  Bubbles
//
//  Created by Jason Michels on 6/18/13.
//  Copyright (c) 2013 Jason Michels. All rights reserved.
//

#import "BubblesModel.h"

@interface BubblesModel()



@end

@implementation BubblesModel

@synthesize startingYPosition = _startingYPosition;
/**
 Initialize some variables
 */
-(id)init
{
    self = [super init];
    
    if (self) {
        // Seed random time
        srandom(time(NULL));
    }
    return self;
}

-(NSString *)endGameMessage
{
    if (!_endGameMessage) {
        _endGameMessage = @"Sorry :( you missed too many bubbles";
    }
    return _endGameMessage;
}

#pragma mark Missed bubbles getter
-(NSInteger)missedBubbles
{
    if (!_missedBubbles) {
        _missedBubbles = 0;
    }
    return _missedBubbles;
}

#pragma Getter and setter for starting position
-(NSInteger)startingYPosition
{
    if (!_startingYPosition) {
        _startingYPosition = -BUBBLE_SIZE;
    }
    return _startingYPosition;
}

-(void)setStartingYPosition:(NSInteger)startingYPosition
{
    _startingYPosition = startingYPosition;
}

#pragma Initialize score
-(NSUInteger)score
{
    if (!_score) {
        _score = 0;
    }
    return _score;
}

#pragma Initialize bubble variables

-(NSUInteger)offSet
{
    if (!_offSet) {
        _offSet = BUBBLE_SIZE;
    }
    return _offSet;
}

-(NSUInteger)bubbleWidth
{
    if (!_bubbleWidth) {
        _bubbleWidth = BUBBLE_SIZE;
    }
    return _bubbleWidth;
}

-(NSUInteger)bubbleHeight
{
    if (!_bubbleHeight) {
        _bubbleHeight = BUBBLE_SIZE;
    }
    return _bubbleHeight;
}

#pragma Get gravity
-(NSInteger)gravity
{
    if (!_gravity) {
        _gravity = GRAVITY;
    }
    
    if (self.score >= SECOND_LEVEL) {
        _gravity = GRAVITY_SECOND_LEVEL;
    }
    
    if (self.score >= THIRD_LEVEL) {
        _gravity = GRAVITY_THIRD_LEVEL;
    }
    
    return _gravity;
}


#pragma Initialize bubbles array
-(NSMutableArray *)bubbles
{
    if (!_bubbles) {
        _bubbles = [NSMutableArray new];
    }
    return _bubbles;
}

#pragma mark Bubbles actions
/**
 Create new bubble and add to the array
 */
- (BubbleView*)addBubble
{
    // Create a bubble
    BubbleView *bubble = [BubbleView new];
    
    // Set bubble starting point
    [bubble setFrame:CGRectMake((random() % (int)(self.screenWidth - self.offSet)),
                                self.startingYPosition,
                                self.bubbleWidth,
                                self.bubbleHeight)];
    
    // User can interact with bubble
    bubble.userInteractionEnabled = YES;
    
    // Add bubble to array of bubbles
    [self.bubbles addObject:bubble];
    
    return bubble;
}

/**
 Update the bubbles location
 */
-(void)drawBubbles
{
    self.missedBubbles = 0;
    
    for (BubbleView *bubble in self.bubbles) {
        
        // Change bubble position based on velocity
        CGPoint center = bubble.center;
        
        // @todo Need to take into account the device rotated
        if (bubble.frame.origin.x >= self.screenWidth) {
            // Then the image is off the screen after a rotation
            center.x = self.screenWidth - BUBBLE_SIZE;
        }
        
        // Make gravity drop the bubble down lower
        center.y = center.y + self.gravity;
        
        // Set the center of the bubble
        bubble.center = center;
        
        if (bubble.frame.origin.y >= self.screenHeight) {
            self.missedBubbles++;
        }
    }
    
    if (self.missedBubbles == GAME_OVER_MISSED_BUBBLES) {
        self.gameOver = YES;
    }
    
    return;
    
}

/**
 Pop bubble
 */
-(void)popBubble:(BubbleView *)bubble
{
    [self.bubbles removeObject:bubble];
    [bubble pop];
    self.score++;
}

/**
 Pop all the bubbles on the screen and empty the bubbles array
 */
-(void)clearBubbles
{
    for (BubbleView *bubble in self.bubbles) {
        [bubble pop];
    }
    
    self.bubbles = [NSMutableArray new];
}

@end
