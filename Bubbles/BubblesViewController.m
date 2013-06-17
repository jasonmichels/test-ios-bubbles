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
@synthesize bubblesArray, score;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.score = 0;
    
    srandom(time(NULL));
    
    bubblesArray = [[NSMutableArray alloc]init];
    
    [self addBubble];
    
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(addBubble) userInfo:nil repeats:YES];

    // Set up the CADisplayLink for the animation
    gameTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateDisplay:)];
    // Add the display link to the current run loop
    [gameTimer addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
}

-(void)updateDisplay:(CADisplayLink *)sender
{
    if ([bubblesArray count] == 0) {
        NSLog(@"Won the game");
        //        [self endGameWithMessage:@"You destroyed all of the blocks"];
    }
    
    //Draw more bubbles
    [self drawBubbles];
}

- (void)addBubble
{
    //Add another bubble
    BubbleView *bubble = [[BubbleView alloc] initWithImage:[UIImage imageNamed:@"bubblet.png"]];
    [bubble setFrame:CGRectMake((random() % 220), -100, 100, 100)];
    bubble.userInteractionEnabled = YES;
    
    // Add bubble to array of bubbles
    [bubblesArray addObject:bubble];
    
    [self.view addSubview:bubble];
}

-(void)drawBubbles
{

    for (BubbleView *bv in bubblesArray) {
        
        // Change bubble position based on velocity
        CGPoint center = bv.center;
        center.x = center.x + 0;
        center.y = center.y + 1;
        
        bv.center = center;
        
        if(bv.frame.origin.y >= self.view.bounds.size.height){
            NSLog(@"You let a bubble get away");
            [bubblesArray removeObject:bv];
        }
    }
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
