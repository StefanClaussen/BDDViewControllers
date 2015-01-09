//
//  ViewController.m
//  BDDViewControllersDB
//
//  Created by Stefan Claussen on 08/01/2015.
//  Copyright (c) 2015 One foot after the other. All rights reserved.
//

#import "ViewController.h"
#import "LoginService.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

@end

@implementation ViewController

- (IBAction)loginButtonTapped:(UIButton *)sender
{
    [LoginService loginWithUsername:self.usernameTextField.text password:self.passwordTextField.text completion:^(BOOL success) {
        if (success) {
            [self performSegueWithIdentifier:@"ShowWelcomeViewController" sender:self];
        } else {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Error" message:@"Incorrect username or password" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:action];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }];
}

@end
