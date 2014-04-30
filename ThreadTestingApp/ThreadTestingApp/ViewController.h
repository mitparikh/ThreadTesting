//
//  ViewController.h
//  ThreadTestingApp
//
//  Created by Mit Parikh on 3/29/14.
//  Copyright (c) 2014 Mit Parikh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    NSOperationQueue *operationQueue;
}
@property (weak, nonatomic) IBOutlet UILabel *label1;
@property (weak, nonatomic) IBOutlet UILabel *label2;
@property (weak, nonatomic) IBOutlet UILabel *label3;

- (IBAction)applyBackgroundColor1:(id)sender;
- (IBAction)applyBackgroundColor2:(id)sender;
- (IBAction)applyBackgroundColor3:(id)sender;

-(void)counterTask;
-(void)colorRotatorTask;

@end
