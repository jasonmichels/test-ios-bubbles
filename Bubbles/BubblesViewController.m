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
@synthesize bubblesArray, score, missedBubbles;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.score = 0;
    
    srandom(time(NULL));
    
    bubblesArray = [NSMutableArray new];

    // Add bubble timer
    addBubbleTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(addBubble)];
    addBubbleTimer.frameInterval = 100;
    [addBubbleTimer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];

    // Set up the CADisplayLink for the animation & Add the display link to the current run loop
    gameTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateDisplay:)];
    [gameTimer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

-(void)updateDisplay:(CADisplayLink *)sender
{
    if (missedBubbles == 10) {
        NSLog(@"Game over");
        [self endGameWithMessage:@"You missed 10 bubbles"];
    }
    
    //Draw more bubbles
    [self drawBubbles];
}

-(void)endGameWithMessage:(NSString*)message
{
    [gameTimer invalidate];
    [addBubbleTimer invalidate];
    [self clearScreen];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Game Over" message:message delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    
    [alert show];
}

- (void)addBubble
{
    //Add another bubble
    BubbleView *bubble = [BubbleView new];
    
    // Get screen width minus one bubble
    float screenWidth = (self.view.bounds.size.width - 100.0);
    [bubble setFrame:CGRectMake((random() % (int)screenWidth), -100, 100, 100)];
    bubble.userInteractionEnabled = YES;
    
    // Add bubble to array of bubbles
    [bubblesArray addObject:bubble];
    
    [self.view addSubview:bubble];
}

-(void)clearScreen
{
    for (BubbleView *bv in bubblesArray) {
        [bv removeFromSuperview];
    }
    
    bubblesArray = [NSMutableArray new];
}

-(void)drawBubbles
{
    missedBubbles = 0;
    
    for (BubbleView *bv in bubblesArray) {
        
        // Change bubble position based on velocity
        CGPoint center = bv.center;
        center.x = center.x + 0;
        center.y = center.y + 1;
        
        bv.center = center;
        
        if (bv.frame.origin.y >= self.view.bounds.size.height) {
            missedBubbles++;
        }
    }
    
    NSLog(@"Missed bubbles %i", missedBubbles);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Get any touch
    UITouch *t = [touches anyObject];
     
    if ([t.view class] == [BubbleView class]) {
        // Get the shape view
        BubbleView *bv = (BubbleView*)t.view;
        
        //user has scored a point now remove the bubble
        [bubblesArray removeObject:bv];
        [bv removeFromSuperview];
        self.score += 1;

    }
    
    NSLog(@"%i", self.score);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
