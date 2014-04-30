//
//  ViewController.m
//  ThreadTestingApp
//
//  Created by Mit Parikh on 3/29/14.
//  Copyright (c) 2014 Mit Parikh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //creating operationQueue instance
    operationQueue = [NSOperationQueue new];
    
    
    //creating NSInvocationOperation instance
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(counterTask) object:nil];
    [operationQueue addOperation:operation];
    
    operation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(colorRotatorTask) object:nil];
    
    [operationQueue addOperation:operation];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (IBAction)applyBackgroundColor1:(id)sender {
    
    [self.view setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:102.0/255.0 alpha:1.0]];
}

- (IBAction)applyBackgroundColor2:(id)sender {
    [self.view setBackgroundColor:[UIColor colorWithRed:204.0/255.0 green:255.0/255.0 blue:102.0/255.0 alpha:1.0]];
}

- (IBAction)applyBackgroundColor3:(id)sender {
    [self.view setBackgroundColor:[UIColor whiteColor]];
}

-(void) colorRotatorTask{
    
    // We need a custom color to work with.
    UIColor *customColor;
    
    // Run a loop with 500 iterations.
    for (int i=0; i<500; i++) {
        // Create three float random numbers with values from 0.0 to 1.0.
        float redColorValue = (arc4random() % 100) * 1.0 / 100;
        float greenColorValue = (arc4random() % 100) * 1.0 / 100;
        float blueColorValue = (arc4random() % 100) * 1.0 / 100;
        
        // Create our custom color. Keep the alpha value to 1.0.
        customColor = [UIColor colorWithRed:redColorValue green:greenColorValue blue:blueColorValue alpha:1.0];
        
        // Change the label2 UILabel's background color.
        [_label2 performSelectorOnMainThread:@selector(setBackgroundColor:) withObject:customColor waitUntilDone:YES];
        
        // Set the r, g, b and iteration number values on label3.
        [_label3 performSelectorOnMainThread:@selector(setText:)
                                 withObject:[NSString stringWithFormat:@"Red: %.2f Green: %.2f Blue: %.2f Iteration #: %d", redColorValue, greenColorValue, blueColorValue, i]
                              waitUntilDone:YES];
        
        // Put the thread to sleep for a while to let us see the color rotation easily.
        [NSThread sleepForTimeInterval:0.5];
    }
    
    // Show a message when the loop is over.
    [_label3 performSelectorOnMainThread:@selector(setText:) withObject:@"Thread #2 has finished." waitUntilDone:NO];
    
    
}

-(void) counterTask {
    for(int i =0; i<10000000; i++){
        if (i%100 ==0) {
            [_label1 performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%d",i] waitUntilDone:(YES)];
        }
    }
    // When the loop gets finished then just display a message.
    [_label1 performSelectorOnMainThread:@selector(setText:) withObject:@"Thread #1 has finished." waitUntilDone:NO];
    
}



@end
