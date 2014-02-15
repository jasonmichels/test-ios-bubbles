//
//  BubblesViewController.m
//  Bubbles
//
//  Created by Jason Michels on 3/29/13.
//  Copyright (c) 2013 Jason Michels. All rights reserved.
//

#import "BubblesViewController.h"

@interface BubblesViewController ()

@end

@implementation BubblesViewController

// Override getter for bubble model
- (BubblesModel *)bubbleModel
{
    if (!_bubbleModel) {
        _bubbleModel = [BubblesModel new];
        _bubbleModel.screenWidth = self.view.bounds.size.width;
        _bubbleModel.screenHeight = self.view.bounds.size.height;
    }
    
    return _bubbleModel;
}

- (CADisplayLink*)addBubbleTimer
{
    if (!_addBubbleTimer) {
        _addBubbleTimer = [CADisplayLink displayLinkWithTarget:self
                                                      selector:@selector(addBubble)];
        _addBubbleTimer.frameInterval = FRAME_INTERVAL;
    }
    
    return _addBubbleTimer;
}

- (CADisplayLink *)gameTimer
{
    if (!_gameTimer) {
        _gameTimer = [CADisplayLink displayLinkWithTarget:self
                                                 selector:@selector(updateDisplay:)];
    }
    
    return _gameTimer;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    // Add bubble timer
    [self.addBubbleTimer addToRunLoop:[NSRunLoop currentRunLoop]
                              forMode:NSDefaultRunLoopMode];

    // Set up the CADisplayLink for the animation & Add the display link to the current run loop
    [self.gameTimer addToRunLoop:[NSRunLoop currentRunLoop]
                         forMode:NSDefaultRunLoopMode];
}

/**
 Update the display every frame and check if game ended
 */
-(void)updateDisplay:(CADisplayLink *)sender
{
//    if (bubbleModel.gameOver) {
//        [self endGame];
//    } else {
        //Draw more bubbles
        [self.bubbleModel drawBubbles];
//    }
}

/**
 End the game
 */
-(void)endGame
{
    [self.gameTimer invalidate];
    [self.addBubbleTimer invalidate];
    [self.bubbleModel clearBubbles];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over" message:self.bubbleModel.endGameMessage delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    
    [alert show];
}

#pragma mark Add Bubble
/**
 Get a bubble from the model and add to the view
 */
- (void)addBubble
{    
    [self.view addSubview:[self.bubbleModel addBubble]];
}

/**
 Get user touches to see if they popped any bubbles
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Get any touch
    UITouch *t = [touches anyObject];
     
    if ([t.view class] == [BubbleView class]) {
        // Get the shape view
        BubbleView *bv = (BubbleView*)t.view;
        
        //user has scored a point now remove the bubble
        [self.bubbleModel popBubble:bv];

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    self.bubbleModel.screenWidth = self.view.bounds.size.width;
    self.bubbleModel.screenHeight = self.view.bounds.size.height;
}

@end
