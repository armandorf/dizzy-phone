//
//  MSPGameViewController.m
//  DizzyPhone
//
//  Created by Pedro Flores on 10/5/14.
//  Copyright (c) 2014 MSP. All rights reserved.
//

#import "MSPGameViewController.h"

@interface MSPGameViewController ()

@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *highScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *livesLabel;
@property (weak, nonatomic) IBOutlet UILabel *rotateOrientLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerFeedbackLabel;
@property (weak, nonatomic) IBOutlet UIButton *imThereButton;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *playAgainButton;

@property float sliderTime;
@property int lives;
@property int currentScore;
@property int highScore;
@property NSString* playerName;
@property UIInterfaceOrientation interfaceOrientation;

@end


@implementation MSPGameViewController

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

    [self loadUserSettings];
    _imThereButton.enabled = NO;
    _lives = 3;
    _scoreLabel.text = @"0";
    _highScoreLabel.text = [NSString stringWithFormat:@"%d", _highScore];
    _livesLabel.text = [NSString stringWithFormat:@"%d", _lives];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)displayOrientationToTap:(int)orientation {
    switch (orientation) {
        case PORTRAIT:
            _rotateOrientLabel.text = @"Portrait";
            break;
        case LANDSCAPE:
            _rotateOrientLabel.text = @"Landscape";
            break;
    }
}

- (IBAction)imThereButtonPressed:(id)sender {

    // get current orientation
    _interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];

    // compare for Portrait orientation
    if (_interfaceOrientation == UIInterfaceOrientationPortrait
        && [_rotateOrientLabel.text isEqualToString:@"Portrait"]) {

        self.playerFeedbackLabel.text = @"Great job!";
        [timer invalidate]; // stop timer

        _imThereButton.enabled = NO;
        _playAgainButton.enabled = YES;

        // UPDATE SCORE AND HIGH SCORE
        [self updateScores];
    }
    // compare for Landscape orientation
    else if ((_interfaceOrientation == UIInterfaceOrientationLandscapeLeft || _interfaceOrientation == UIInterfaceOrientationLandscapeRight) &&
             [_rotateOrientLabel.text isEqualToString:@"Landscape"]){
        self.playerFeedbackLabel.text = @"Great job!";

        [timer invalidate]; // stop timer
        _imThereButton.enabled = NO;
        _playAgainButton.enabled = YES;
        [self updateScores];
    }
    else {
        [timer invalidate];
        [self updateLivesCounter];
    }

}

- (void)updateScores {
    _currentScore++;
    if (_currentScore > _highScore) {
        _highScore++;
    }
    _scoreLabel.text = [NSString stringWithFormat:@"%d", _currentScore];
    _highScoreLabel.text = [NSString stringWithFormat:@"%d", _highScore];
}


- (void)updateLivesCounter {
    _playerFeedbackLabel.text = @"Try again";
    _lives--;
    _livesLabel.text = [NSString stringWithFormat:@"%d", _lives];
    _imThereButton.enabled = NO;
    _playAgainButton.enabled = YES;
    if (!_lives) {
        [self showGameOverMessage];
    }
}

- (IBAction)playAgainButtonPressed:(id)sender {
    _playAgainButton.enabled = NO;

    timer = [NSTimer scheduledTimerWithTimeInterval:_sliderTime target:self selector:@selector(gameTimerCalled) userInfo:nil repeats:NO];
    _rotateOrientLabel.text = @"%@",[self displayOrientationToTap:[self produceRandomOrientation]];

    _imThereButton.enabled = YES;
}

// this method is called when the user doesn't manage to press the "I'm There!"
// button on time
-(void)gameTimerCalled
{
    [self updateLivesCounter];
}

-(int)produceRandomOrientation {
    return arc4random() % 2;
}

-(void)showGameOverMessage {
    [self saveUserSettings];

    _playerFeedbackLabel.text = [NSString stringWithFormat:@"Game Over for player %@", _playerName];
    [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(gameOverTimerCalled) userInfo:nil repeats:NO];
    _imThereButton.enabled = NO;
    _playAgainButton.enabled = NO;
    _backButton.enabled = NO;
}

// go back to main view
-(void)gameOverTimerCalled {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex != [actionSheet cancelButtonIndex]) {
        [self dismissViewControllerAnimated:NO completion:nil];
        [self saveUserSettings];
    }
}

- (IBAction)backButtonPressed {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Do you really want to go back?"
                                  delegate:self
                                  cancelButtonTitle:@"No"
                                  destructiveButtonTitle:@"Yes"
                                  otherButtonTitles:nil];
    [actionSheet showInView:self.view];
}

- (void)loadUserSettings {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    _playerName = [userDefaults objectForKey:@"nameField"];
    _sliderTime = [userDefaults floatForKey:@"sliderValue"];
    _highScore = [userDefaults integerForKey:@"highScore"];

    [userDefaults synchronize];
}

- (void)saveUserSettings {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    [userDefaults setInteger:_highScore forKey:@"highScore"];

    [userDefaults synchronize];
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


