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

#pragma Getter and setter for starting position
-(NSInteger)startingYPosition
{
    if (!_startingYPosition) {
        _startingYPosition = -100;
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

#pragma Initialize bubbles array
-(NSMutableArray *)bubbles
{
    if (!_bubbles) {
        _bubbles = [NSMutableArray new];
    }
    return _bubbles;
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
        center.y = center.y + 2;
        
        // Set the center of the bubble
        bubble.center = center;
        
        if (bubble.frame.origin.y >= self.screenHeight) {
            self.missedBubbles++;
            //This is a bug. Need to make second array of objects to remove
            // http://stackoverflow.com/questions/8834031/objective-c-nsmutablearray-mutated-while-being-enumerated
//            [self.bubbles removeObject:bubble];
        }
    }
    
    NSLog(@"Total missed bubbles: %d", self.missedBubbles);
    
//    if (self.missedBubbles == GAME_OVER_MISSED_BUBBLES) {
//        self.gameOver = YES;
//        self.endGameMessage = @"Sorry you missed too many bubbles";
//    }
    
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
