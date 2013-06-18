//
//  BubblesModel.m
//  Bubbles
//
//  Created by Jason Michels on 6/18/13.
//  Copyright (c) 2013 Jason Michels. All rights reserved.
//

#import "BubblesModel.h"

@implementation BubblesModel
@synthesize bubbles, score, missedBubbles, screenWidth, screenHeight, gameOver, endGameMessage;
@synthesize startingYPosition, offSet, bubbleHeight, bubbleWidth;

/**
 Initialize some variables
 */
-(id)init
{
    self = [super init];
    
    if (self) {
        // Init score to zero
        self.score = 0;
        
        // Preset some bubble starting positions
        self.startingYPosition = -100;
        self.offSet = 100;
        self.bubbleWidth = 100;
        self.bubbleHeight = 100;
        
        // Seed random time
        srandom(time(NULL));
        
        // Create bubbles array
        self.bubbles = [NSMutableArray new];
    }
    return self;
}

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
            center.x = self.screenWidth - 100;
        }
        
        // Make gravity drop the bubble down lower
        center.y = center.y + 1;
        
        // Set the center of the bubble
        bubble.center = center;
        
        if (bubble.frame.origin.y >= self.screenHeight) {
            self.missedBubbles++;
        }
    }
    
    if (self.missedBubbles == 10) {
        self.gameOver = YES;
        self.endGameMessage = @"Sorry you missed 10 bubbles";
    }
    
    return;
    
}

#pragma mark Clear Bubbles Methods

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
