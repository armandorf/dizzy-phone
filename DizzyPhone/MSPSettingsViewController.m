//
//  MSPSettingsViewController.m
//  DizzyPhone
//
//  Created by Pedro Flores on 10/5/14.
//  Copyright (c) 2014 MSP. All rights reserved.
//

#import "MSPSettingsViewController.h"

@interface MSPSettingsViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UILabel *sliderLabel;
@property (weak, nonatomic) IBOutlet UISlider *slider;

@end


@implementation MSPSettingsViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (IBAction)sliderChanged:(UISlider *)sender {
    self.sliderLabel.text = [NSString stringWithFormat:@"%.2f", sender.value] ;
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {

    if (buttonIndex != [actionSheet cancelButtonIndex]) {
        [self saveUserSettings];
    }
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (IBAction)backButtonPressed {
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"Save current settings?"
                                  delegate:self
                                  cancelButtonTitle:@"No"
                                  destructiveButtonTitle:@"Yes"
                                  otherButtonTitles:nil];
    [actionSheet showInView:self.view];
}

- (IBAction)textFieldDoneEditing:(id)sender {
    [sender resignFirstResponder];
}

- (IBAction)backgroundTap:(id)sender {
    [self.nameField resignFirstResponder];
}

- (void)loadUserSettings {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    _nameField.text = [userDefaults objectForKey:@"nameField"];
    _slider.value = [userDefaults floatForKey:@"sliderValue"];
    _sliderLabel.text = [NSString stringWithFormat:@"%.2f", _slider.value];

    [userDefaults synchronize];
}

- (void)saveUserSettings {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];

    if(_nameField.text)
        [userDefaults setObject:_nameField.text forKey:@"nameField"];
    else
        [userDefaults setObject:_nameField.text forKey:@""];
    [userDefaults setFloat:_slider.value forKey:@"sliderValue"];

    [userDefaults synchronize];
}

// Settings view only supports Portrait orientation
- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}
@end