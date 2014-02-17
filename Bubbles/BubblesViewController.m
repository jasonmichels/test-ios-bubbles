//
//  BubblesViewController.m
//  Bubbles
//
//  Created by Jason Michels on 3/29/13.
//  Copyright (c) 2013 Jason Michels. All rights reserved.
//

#import "BubblesViewController.h"

@interface BubblesViewController ()

@property (nonatomic)NSUInteger timePassed;
@property (nonatomic)NSUInteger changeBackgroundTimer;
@property (strong, nonatomic)NSArray *backgroundColors; // of UIColor
@property (weak, nonatomic) IBOutlet UILabel *missedBubbles;
@property (weak, nonatomic) IBOutlet UILabel *poppedBubbles;
@property (weak, nonatomic) IBOutlet UIButton *startGameBtn;

@end

@implementation BubblesViewController

@synthesize timePassed = _timePassed;
@synthesize changeBackgroundTimer = _changeBackgroundTimer;

#pragma mark UpdateDisplay
/**
 Update the display every frame and check if game ended
 */
-(void)updateDisplay:(CADisplayLink *)sender
{
    [self updateBubblesText];
    
    if (self.bubbleModel.gameOver) {
        [self endGame];
    } else {
        //Draw more bubbles
        [self.bubbleModel drawBubbles];
    }
}

#pragma mark Start the game
- (IBAction)startGame:(id)sender {

    [self.startGameBtn setHidden:TRUE];
    
    [self.view setBackgroundColor:[UIColor greenColor]];
    
    // Add bubble timer
    [self.addBubbleTimer addToRunLoop:[NSRunLoop currentRunLoop]
                              forMode:NSDefaultRunLoopMode];
    
    // Set up the CADisplayLink for the animation & Add the display link to the current run loop
    [self.gameTimer addToRunLoop:[NSRunLoop currentRunLoop]
                         forMode:NSDefaultRunLoopMode];
}


#pragma mark End thegame
-(void)endGame
{
    [self.gameTimer invalidate];
    [self.addBubbleTimer invalidate];
    [self.bubbleModel clearBubbles];
    
    self.bubbleModel = Nil;
    self.gameTimer = Nil;
    self.addBubbleTimer = Nil;
    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"GAME OVER" message:self.bubbleModel.endGameMessage delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"GAME OVER"
                                                   message:self.bubbleModel.endGameMessage
                                                  delegate:self
                                         cancelButtonTitle:@"Try Again"
                                         otherButtonTitles:nil, nil];
    
    [alert show];
    
    [self.startGameBtn setHidden:FALSE];
}

#pragma mark Add Bubble
/**
 Get a bubble from the model and add to the view
 */
- (void)addBubble
{
    self.timePassed++;
    [self.view addSubview:[self.bubbleModel addBubble]];
}

#pragma mark Detect touches to pop bubble
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

#pragma mark Getter for bubble model
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

#pragma mark Getter for add bubble time
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



#pragma mark Set time to move faster
-(NSUInteger)timePassed
{
    if (!_timePassed) {
        _timePassed = 0;
    }
    return _timePassed;
}

-(void)setTimePassed:(NSUInteger)timePassed
{
    if (timePassed) {
        _timePassed = timePassed;
    }
    
    self.changeBackgroundTimer++;
    
    if (_timePassed == MOVE_FASTER_INTERVAL && self.addBubbleTimer.frameInterval >= LOWEST_INTERVAL)
    {
        self.addBubbleTimer.frameInterval--;
        _timePassed = 0;
    }
}

#pragma Change Background
-(NSUInteger)changeBackgroundTimer
{
    if (!_changeBackgroundTimer) {
        _changeBackgroundTimer = 0;
    }
    return _changeBackgroundTimer;
}

-(void)setChangeBackgroundTimer:(NSUInteger)changeBackgroundTimer
{
    if (changeBackgroundTimer) {
        _changeBackgroundTimer = changeBackgroundTimer;
    }
    
    if (_changeBackgroundTimer == CHANGE_BACKGROUND_COLOR) {
        unsigned index = arc4random() % self.backgroundColors.count;
        [self.view setBackgroundColor:self.backgroundColors[index]];
        _changeBackgroundTimer = 0;
    }
}

-(NSArray *)backgroundColors
{
    if (!_backgroundColors) {
        _backgroundColors = @[[UIColor redColor], [UIColor blueColor], [UIColor greenColor], [UIColor brownColor], [UIColor yellowColor]];
    }
    return _backgroundColors;
}

#pragma mark Update bubbles text
-(void)updateBubblesText
{
    [self.missedBubbles setText:[NSString
                                 stringWithFormat:@"%d", self.bubbleModel.missedBubbles]];
    
    [self.poppedBubbles setText:[NSString
                                 stringWithFormat:@"%d", self.bubbleModel.score]];
}

#pragma mark Screen rotating
-(void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    self.bubbleModel.screenWidth = self.view.bounds.size.width;
    self.bubbleModel.screenHeight = self.view.bounds.size.height;
}

@end
