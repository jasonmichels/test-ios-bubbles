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
@synthesize bubbleModel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    bubbleModel = [BubblesModel new];
    bubbleModel.screenWidth = self.view.bounds.size.width;
    bubbleModel.screenHeight = self.view.bounds.size.height;

    // Add bubble timer
    addBubbleTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(addBubble)];
    addBubbleTimer.frameInterval = FRAME_INTERVAL;
    [addBubbleTimer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];

    // Set up the CADisplayLink for the animation & Add the display link to the current run loop
    gameTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateDisplay:)];
    [gameTimer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
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
        [bubbleModel drawBubbles];
//    }
}

/**
 End the game
 */
-(void)endGame
{
    [gameTimer invalidate];
    [addBubbleTimer invalidate];
    [bubbleModel clearBubbles];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over" message:bubbleModel.endGameMessage delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    
    [alert show];
}

#pragma mark Add Bubble
/**
 Get a bubble from the model and add to the view
 */
- (void)addBubble
{    
    [self.view addSubview:bubbleModel.addBubble];
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
        [bubbleModel popBubble:bv];

    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    bubbleModel.screenWidth = self.view.bounds.size.width;
    bubbleModel.screenHeight = self.view.bounds.size.height;
}

@end
