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

@property (strong, nonatomic) NSMutableString* passcodeString;

- (IBAction)loginEditingDidBegin:(id)sender;
- (IBAction)passwordEditingDidBegin:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *passcode;

@property (weak, nonatomic) IBOutlet UILabel *passcodeLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *passcodeButtons;
- (IBAction)oneAction:(id)sender;
- (IBAction)twoAction:(id)sender;
- (IBAction)threeAction:(id)sender;


- (IBAction)authorizeButtonAction:(id)sender;
- (void)textFiledStateActive: (id)state;
- (void)textFiledStateError: (IBOutlet)error;
- (void)textFiledStateSuccess: (IBOutlet)success;

//keyboard
- (void)subscribeOnKeyboardEvents;
- (void)updateTopContraintWith:(CGFloat) constant andBottom:(CGFloat) bottomConstant;
- (void)hideWhenTappedAround;

@end



// MARK: - Controller implemetation

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Subscrube on keyboard events
    [self subscribeOnKeyboardEvents];
    [self hideWhenTappedAround];
    
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
    [self.authorizeButton setTitle:@"Authorize" forState:UIControlStateNormal];
    [self.authorizeButton setTitleColor:littleBoyBlue forState:UIControlStateNormal];
    self.authorizeButton.titleLabel.layer.borderColor = littleBoyBlue.CGColor;
    self.authorizeButton.layer.borderColor = littleBoyBlue.CGColor;
    self.authorizeButton.layer.borderWidth = 1.5;
    self.authorizeButton.layer.cornerRadius = 5;
    
    //setup passcode view
    self.passcode.layer.borderColor = blackCoral.CGColor;
    self.passcode.layer.borderWidth = 1.5;
    self.passcode.layer.cornerRadius = 5;
    self.passcode.hidden = YES;
    
    //setup passcode textLabel
    self.passcodeString = @"_";
    [self.passcodeLabel setText:_passcodeString];
    
    //setup passcode buttons
    for (UIButton *value in self.passcodeButtons)
    {
        [value setTitleColor:littleBoyBlue forState:UIControlStateNormal];
        [value setTitleColor:littleBoyBlue forState:UIControlStateNormal];
        value.layer.borderColor = littleBoyBlue.CGColor;
        value.layer.borderWidth = 1.5;
        value.layer.cornerRadius = value.frame.size.height/2;
        value.layer.masksToBounds = true;
    }
 
    

    
    
    
}

//method of button action
- (IBAction)authorizeButtonAction:(id)sender {
    
    
    NSString * userName = self.loginTextFiled.text;
    NSString * passwordTextField = self.passwordTextField.text;
    
    
    if ((self.loginTextFiled.text && self.loginTextFiled.text.length > 0) &&
        (self.passwordTextField.text && self.passwordTextField.text.length > 0))
    {
        //if username and password a correct
        if ([userName isEqualToString:@" "] && [passwordTextField isEqualToString:@" "]){

            self.passcode.hidden = NO;
            self.loginTextFiled.enabled = NO;
            self.authorizeButton.enabled = NO;
            self.authorizeButton.layer.opacity = 0.5;
            self.loginTextFiled.layer.borderColor = [UIColor colorWithRed: 0.57 green: 0.78 blue: 0.69 alpha: 1.00].CGColor;
            self.loginTextFiled.layer.opacity = 0.5;
            self.passwordTextField.enabled = NO;
            self.passwordTextField.layer.borderColor = [UIColor colorWithRed: 0.57 green: 0.78 blue: 0.69 alpha: 1.00].CGColor;
            self.passwordTextField.layer.opacity = 0.5;
            [self.view endEditing:YES];
            
            

            
            
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
}

- (IBAction)threeAction:(id)sender {
    [self checkPasscodeLogic:@"3"];
}

- (IBAction)twoAction:(id)sender {
    [self checkPasscodeLogic:@"2"];
}

- (IBAction)oneAction:(id)sender {
    [self checkPasscodeLogic:@"1"];
}


//check textfield and password field
- (IBAction)passwordEditingDidBegin:(id)sender {
    self.passwordTextField.layer.borderColor = [UIColor colorWithRed: 0.30 green: 0.36 blue: 0.41 alpha: 1.00].CGColor;
    self.passwordTextField.text = @"";
}

- (IBAction)loginEditingDidBegin:(id)sender {
    self.loginTextFiled.layer.borderColor = [UIColor colorWithRed: 0.30 green: 0.36 blue: 0.41 alpha: 1.00].CGColor;
    self.loginTextFiled.text = @"";
}

-(void)InformativeAlertWithmsg
{
    UIAlertController * alertvc = [UIAlertController alertControllerWithTitle: @ "Welcome!"
                                    message: nil preferredStyle: UIAlertControllerStyleAlert
                                   ];
     UIAlertAction * action = [UIAlertAction actionWithTitle: @ "Refresh"
                               style: UIAlertActionStyleDefault handler: ^ (UIAlertAction * _Nonnull action) {
                                 NSLog(@ "Refresh Tapped");
                               }
                              ];
    alertvc.view.tintColor = [UIColor redColor];
     [alertvc addAction: action];
     [self presentViewController: alertvc animated: true completion: nil];
}

//method lable declaration
- (void)checkPasscodeLogic:(NSString*) buttomValue {
    NSString *correctPasscode = @"132";
    NSString *textFromLabel = [self.passcodeLabel text];
    NSLog(@"%@", [textFromLabel substringToIndex:1]);

    if ([textFromLabel hasPrefix:@"_"]){
        textFromLabel = buttomValue;
        self.passcodeString = textFromLabel;
        [self.passcodeLabel setText:self.passcodeString];
    } else {
        if ([self.passcodeString length] < 3){
            self.passcodeString = [NSString stringWithFormat:@"%@%@", self.passcodeString, buttomValue];
            [self.passcodeLabel setText:self.passcodeString];
            if (([self.passcodeString isEqual:correctPasscode]) && ([self.passcodeString length] == 3)){
                for (UIButton *value in self.passcodeButtons)
                {
                     value.enabled = NO;
                }
                NSLog(@"WIN");
                [self InformativeAlertWithmsg];
            } else if (([self.passcodeString length] == 3) && ![self.passcodeString isEqual:correctPasscode]){
                self.passcodeString = @"_";
                [self.passcodeLabel setText:self.passcodeString];
                NSLog(@"END");
            }
        }
        
    }

    
}




@end







// MARK: - Keyboard category

@implementation LoginViewController (KeyboardHandling)

- (void)subscribeOnKeyboardEvents {
    // Keyboard will show
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(keybaordWillShow:)
                                               name:UIKeyboardWillShowNotification
                                             object:nil];
    // Keyboard will hide
    [NSNotificationCenter.defaultCenter addObserver:self
                                           selector:@selector(keybaordWillHide:)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];
}

- (void)hideWhenTappedAround {
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                               action:@selector(hide)];
    [self.view addGestureRecognizer:gesture];
}

- (void)hide {
    [self.view endEditing:true];
}

- (void)keybaordWillShow:(NSNotification *)notification {
    CGRect rect = [(NSValue *)notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

    [self updateTopContraintWith:15.0 andBottom:rect.size.height - self.view.safeAreaInsets.bottom + 15.0];
}

- (void)keybaordWillHide:(NSNotification *)notification {
    [self updateTopContraintWith:200.0 andBottom:0.0];
}

- (void)updateTopContraintWith:(CGFloat) constant andBottom:(CGFloat) bottomConstant {
    // Change your constraint constants
   // self.topConstraint.constant = constant;
   // self.saveButtonBottomConstraint.constant = bottomConstant;
    [UIView animateWithDuration:0.2 animations:^{
        [self.view layoutIfNeeded];
    }];
    

}

@end

