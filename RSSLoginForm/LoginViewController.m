//
//  LoginViewController.m
//  RSSLoginForm
//
//  Created by Dmitriy Komar on 7/1/21.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UITextField *loginTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *authorizeButton;

- (IBAction)loginEditingDidBegin:(id)sender;
- (IBAction)passwordEditingDidBegin:(id)sender;




- (IBAction)authorizeButtonAction:(id)sender;
- (void)textFiledStateActive: (id)state;
- (void)textFiledStateError: (IBOutlet)error;
- (void)textFiledStateSuccess: (IBOutlet)success;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *blackCoral = [UIColor colorWithRed: 0.30 green: 0.36 blue: 0.41 alpha: 1.00];
    UIColor *turquoiseGreen = [UIColor colorWithRed: 0.57 green: 0.78 blue: 0.69 alpha: 1.00];
    UIColor *venetioanRed = [UIColor colorWithRed: 0.76 green: 0.00 blue: 0.08 alpha: 1.00];
    UIColor *black = [UIColor colorWithRed: 0.00 green: 0.00 blue: 0.00 alpha: 1.00];
    UIColor *littleBoyBlue = [UIColor colorWithRed: 0.50 green: 0.64 blue: 0.93 alpha: 1.00];

    //setup text label
    self.textLabel.adjustsFontSizeToFitWidth = YES;
    
    
    //setup login textfiled
    self.loginTextFiled.layer.borderColor = blackCoral.CGColor;
    self.loginTextFiled.layer.borderWidth = 1.5;
    self.loginTextFiled.layer.cornerRadius = 5;

    //setup password textfield
    self.passwordTextField.layer.borderColor = blackCoral.CGColor;
    self.passwordTextField.layer.borderWidth = 1.5;
    self.passwordTextField.layer.cornerRadius = 5;

    
    
    
    
    
    //setup button
    //TODO: -need changed border color hex
    [self.authorizeButton setTitle:@"Authorize" forState:UIControlStateNormal];
    [self.authorizeButton setTitleColor:littleBoyBlue forState:UIControlStateNormal];
    self.authorizeButton.titleLabel.layer.borderColor = littleBoyBlue.CGColor;
    self.authorizeButton.layer.borderColor = littleBoyBlue.CGColor;
    self.authorizeButton.layer.borderWidth = 1.5;
    self.authorizeButton.layer.cornerRadius = 5;
    
    
    
    
    
    
    
    
    
}

//method of button action
- (IBAction)authorizeButtonAction:(id)sender {
    
    
    NSString * userName = self.loginTextFiled.text;
    NSString * passwordTextField = self.passwordTextField.text;
    
    
    if ((self.loginTextFiled.text && self.loginTextFiled.text.length > 0) &&
        (self.passwordTextField.text && self.passwordTextField.text.length > 0))
    {
        //if username and password a correct
        if ([userName isEqualToString:@"username"] && [passwordTextField isEqualToString:@"password"]){
            //new contoller should be displayed
            NSLog(@"круто все верно");
        }
        //incorrect login
        else if (![userName isEqualToString:@"username"] && [passwordTextField isEqualToString:@"password"]) {
            self.loginTextFiled.layer.borderColor = [UIColor colorWithRed: 0.76 green: 0.00 blue: 0.08 alpha: 1.00].CGColor;
        }
        //incorrect password
        else if ([userName isEqualToString:@"username"] && ![passwordTextField isEqualToString:@"password"]) {
            self.passwordTextField.layer.borderColor = [UIColor colorWithRed: 0.76 green: 0.00 blue: 0.08 alpha: 1.00].CGColor;
        }
        //both incorrect
        else if (![userName isEqualToString:@"username"] && ![passwordTextField isEqualToString:@"password"])  {
            self.loginTextFiled.layer.borderColor = [UIColor colorWithRed: 0.76 green: 0.00 blue: 0.08 alpha: 1.00].CGColor;
            self.passwordTextField.layer.borderColor = [UIColor colorWithRed: 0.76 green: 0.00 blue: 0.08 alpha: 1.00].CGColor;
        }
        
    }
    //empty login
    else if (!(self.loginTextFiled.text && self.loginTextFiled.text.length > 0) &&
             (self.passwordTextField.text && self.passwordTextField.text.length > 0))
    {
        self.loginTextFiled.layer.borderColor = [UIColor colorWithRed: 0.76 green: 0.00 blue: 0.08 alpha: 1.00].CGColor;
    }
    //empty password
    else if ((self.loginTextFiled.text && self.loginTextFiled.text.length > 0) &&
             !(self.passwordTextField.text && self.passwordTextField.text.length > 0))
    {
    self.passwordTextField.layer.borderColor = [UIColor colorWithRed: 0.76 green: 0.00 blue: 0.08 alpha: 1.00].CGColor;
    }
    //empty both
    else {
        self.loginTextFiled.layer.borderColor = [UIColor colorWithRed: 0.76 green: 0.00 blue: 0.08 alpha: 1.00].CGColor;
        self.passwordTextField.layer.borderColor = [UIColor colorWithRed: 0.76 green: 0.00 blue: 0.08 alpha: 1.00].CGColor;
    }
//create method for action or take it from top
    
}

- (IBAction)passwordEditingDidBegin:(id)sender {
    self.passwordTextField.layer.borderColor = [UIColor colorWithRed: 0.30 green: 0.36 blue: 0.41 alpha: 1.00].CGColor;
    self.passwordTextField.text = @"";
}

- (IBAction)loginEditingDidBegin:(id)sender {
    self.loginTextFiled.layer.borderColor = [UIColor colorWithRed: 0.30 green: 0.36 blue: 0.41 alpha: 1.00].CGColor;
    self.loginTextFiled.text = @"";
}







@end

