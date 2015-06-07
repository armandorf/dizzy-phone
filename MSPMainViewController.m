//
//  MSPMainViewController.m
//  DizzyPhone
//
//  Created by Pedro Flores on 10/5/14.
//  Copyright (c) 2014 MSP. All rights reserved.
//

#import "MSPMainViewController.h"

#import "MSPGameViewController.h"
#import "MSPSettingsViewController.h"

@interface MSPMainViewController ()

@end

@implementation MSPMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// log when orientation changes
-(void) willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
        NSLog(@"Portrait");
    } else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
        NSLog(@"Landscape right");
    } else if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
        NSLog(@"Landscape left");
    }
}

@end
