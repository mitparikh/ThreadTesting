//
//  ViewController.m
//  ThreadTestWithGCD
//
//  Created by Mit Parikh on 3/29/14.
//  Copyright (c) 2014 Mit Parikh. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    dispatch_queue_t myQueue;
    dispatch_queue_t newQueue;
}
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if(!myQueue){
        myQueue = dispatch_queue_create("com.example.gcdTestQueue", NULL);
        newQueue = dispatch_queue_create("com.example.gcdTestQueue2", NULL);
    }
    
    dispatch_async(myQueue, ^{[self counterTask];});
    dispatch_async(newQueue, ^{[self colorPicker];});
    
    //dispatch_queue
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)applyBGColor1:(id)sender {
   // [self colorPicker];
    [self.view setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:204.0/255.0 blue:102.0/255.0 alpha:1.0]];
    
}



- (IBAction)applyBGColor2:(id)sender {
    [self.view setBackgroundColor:[UIColor colorWithRed:204.0/255.0 green:255.0/255.0 blue:102.0/255.0 alpha:1.0]];
}

- (IBAction)applyBGColor3:(id)sender {
    [self.view setBackgroundColor:[UIColor whiteColor]];
}


-(void) colorPicker{
    
    UIColor *customColor;

    for (int i=0; i<500; i++) {
        
        float redVal = (arc4random()%100) * .01;
        float greenVal = (arc4random()%100) * .01;
        float blueVal = (arc4random()%100) * .01;
    
        customColor = [[UIColor alloc]initWithRed:(redVal) green:greenVal blue:blueVal alpha:1.0];
        
        //Change the background color of the app
        dispatch_async(dispatch_get_main_queue(), ^{[_label2 setBackgroundColor:customColor];});
        
        //display the values of the colors
        dispatch_async(dispatch_get_main_queue(), ^{[_label3 setText:[NSString stringWithFormat:@"Red: %.2f\nGreen: %.2f\nBlue: %.2f\n#Iteration: %d",redVal,greenVal,blueVal,i]];});
        
        
        
        
        [NSThread sleepForTimeInterval: 0.35];
    
    }
    [_label3 performSelectorOnMainThread:@selector(setText:) withObject:@"Thread #2 has finished." waitUntilDone:YES];
    
    
}

-(void) counterTask{
 
    for(int i =0; i<100000000; i++){
        if (i%100 ==0) {
            
            [_label1 performSelectorOnMainThread:@selector(setText:) withObject:[NSString stringWithFormat:@"%d",i] waitUntilDone:(YES)];
        }
    }
    // When the loop gets finished then just display a message.
    [_label1 setText:@"Thread #1 has finished."];
}

@end
