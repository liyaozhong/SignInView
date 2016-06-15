//
//  ViewController.m
//  SignInView
//
//  Created by joshuali on 16/6/15.
//  Copyright © 2016年 joshuali. All rights reserved.
//

#import "ViewController.h"
#import "SignInView.h"

@interface ViewController ()
@property (nonatomic, weak) IBOutlet SignInView * signInView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onReset:(id)sender
{
    [self.signInView reset];
}

@end
