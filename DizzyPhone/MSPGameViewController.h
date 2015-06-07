//
//  MSPGameViewController.h
//  DizzyPhone
//
//  Created by Pedro Flores on 10/5/14.
//  Copyright (c) 2014 MSP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSPGameViewController : UIViewController {
    NSTimer* timer;
    NSTimer* gameOverTimer;
    #define defaultSliderValue 1.0
    #define defaultUserName @"Player1"
    #define PORTRAIT 0
    #define LANDSCAPE 1
}

@end
