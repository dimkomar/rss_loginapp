//
//  LoginViewController.m
//  RSSLoginForm
//
//  Created by Dmitriy Komar on 7/1/21.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UIButton *authorizeButton;
@property (weak, nonatomic) IBOutlet UITextField *loginTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

- (IBAction)authorizeButtonAction:(id)sender;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //setup login textfiled
    self.loginTextFiled.layer.borderColor = UIColor.blackColor.CGColor;
    self.loginTextFiled.layer.borderWidth = 1.5;
    self.loginTextFiled.layer.cornerRadius = 5;

    
    
    
    //setup password textfield
    self.passwordTextField.layer.borderColor = UIColor.blackColor.CGColor;
    self.passwordTextField.layer.borderWidth = 1.5;
    self.passwordTextField.layer.cornerRadius = 5;

    
    
    
    
    
    //setup button
    //TODO: -need changed border color hex
    [self.authorizeButton setTitle:@"Authorize" forState:UIControlStateNormal];
    self.authorizeButton.layer.borderColor = UIColor.blackColor.CGColor;
    self.authorizeButton.layer.borderWidth = 1.5;
    self.authorizeButton.layer.cornerRadius = 5;
    
    
    
    
    
}

//method of button action
- (IBAction)authorizeButtonAction:(id)sender {
    
    if (self.loginTextFiled.text && self.loginTextFiled.text.length > 0)
    {
        NSLog(@"чтото есть в поле");
    }
    else
    {
        NSLog(@"ничего нету");
        
    }
    
    
    
}
@end
