//
//  LoginViewController.m
//  RSSLoginForm
//
//  Created by Dmitriy Komar on 7/1/21.
//

#import "LoginViewController.h"
#import "Colors.h"


@interface LoginViewController () <UITextFieldDelegate>


//authorize block
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UITextField *loginTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *authorizeButton;
- (IBAction)authorizeButtonAction:(id)sender;
- (IBAction)loginEditingDidBegin:(id)sender;
- (IBAction)passwordEditingDidBegin:(id)sender;
- (IBAction)touchedDown:(id)sender;


//passcode block
@property (weak, nonatomic) IBOutlet UIView *passcode;
@property (weak, nonatomic) IBOutlet UILabel *passcodeLabel;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *passcodeButtons;
- (IBAction)touchedDownButtonOne:(id)sender;
- (IBAction)touchedDownButtonTwo:(id)sender;
- (IBAction)touchedDownButtonThree:(id)sender;
- (IBAction)oneAction:(id)sender;
- (IBAction)twoAction:(id)sender;
- (IBAction)threeAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *buttonOne;
@property (weak, nonatomic) IBOutlet UIButton *buttonTwo;
@property (weak, nonatomic) IBOutlet UIButton *buttonThree;


//default value
@property (strong, nonatomic) NSString* passcodeString;
@property (strong, nonatomic) NSString* correctUsername;
@property (strong, nonatomic) NSString* correctPassword;
@property (strong, nonatomic) NSString* correctPasscode;



//keyboard
- (void)subscribeOnKeyboardEvents;
- (void)updateTopContraintWith:(CGFloat) constant andBottom:(CGFloat) bottomConstant;
- (void)hideWhenTappedAround;


//additional objects
@property (strong, nonatomic) Colors *color;


@end



// MARK: - Controller implemetation
@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set default value
    _correctUsername = @"login";
    _correctPassword = @"password";
    _passcodeString = @"_";
    _correctPasscode = @"1 3 2";
    
    //create color object
    _color = [[Colors alloc]init];
    
    // Subscrube on keyboard events
    [self subscribeOnKeyboardEvents];
    [self hideWhenTappedAround];
    
    //setup text label
    self.textLabel.adjustsFontSizeToFitWidth = YES;
    
    //setup login textfiled
    self.loginTextFiled.layer.borderColor = _color.blackCoral.CGColor;
    self.loginTextFiled.layer.borderWidth = 1.5;
    self.loginTextFiled.layer.cornerRadius = 5;
    self.loginTextFiled.keyboardType = UIKeyboardTypeASCIICapable;
    
    //setup password textfield
    self.passwordTextField.layer.borderColor = _color.blackCoral.CGColor;
    self.passwordTextField.layer.borderWidth = 1.5;
    self.passwordTextField.layer.cornerRadius = 5;
    self.passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
    
    //setup authorize button
    [self.authorizeButton setTitle:@"Authorize" forState:UIControlStateNormal];
    [self.authorizeButton setTitleColor:_color.littleBoyBlue forState:UIControlStateNormal];
    [self.authorizeButton setTitleColor:_color.littleBoyBlueTouchDownBackgroundText forState:UIControlStateHighlighted];
    self.authorizeButton.titleLabel.layer.borderColor = _color.littleBoyBlue.CGColor;
    self.authorizeButton.layer.borderColor = _color.littleBoyBlue.CGColor;
    self.authorizeButton.layer.borderWidth = 1.5;
    self.authorizeButton.layer.cornerRadius = 10;
    
    //setup passcode view
    self.passcode.layer.borderColor = _color.white.CGColor;
    self.passcode.layer.borderWidth = 1.5;
    self.passcode.layer.cornerRadius = 10;
    self.passcode.hidden = YES;
    
    //setup passcode textLabel
    [self.passcodeLabel setText:_passcodeString];
    
    //setup passcode buttons
    for (UIButton *value in self.passcodeButtons) {
        [value setTitleColor:_color.littleBoyBlue forState:UIControlStateNormal];
        [value setTitleColor:_color.littleBoyBlue forState:UIControlStateHighlighted];
        value.layer.borderColor = _color.littleBoyBlue.CGColor;
        value.layer.borderWidth = 1.5;
        value.layer.cornerRadius = value.frame.size.height/2;
    }
    
    self.loginTextFiled.delegate = self;
    self.passwordTextField.delegate = self;
}



// MARK: - Methods implemetation

//authorize button action implementation
- (IBAction)authorizeButtonAction:(id)sender {
    self.authorizeButton.layer.backgroundColor = _color.white.CGColor;
    NSString *inputtedUsername = self.loginTextFiled.text;
    NSString *inputtedPassword = self.passwordTextField.text;
    
    if ((self.loginTextFiled.text && self.loginTextFiled.text.length >= 0) &&
        (self.passwordTextField.text && self.passwordTextField.text.length >= 0)) {
        //if username and password a correct
        if ([inputtedUsername isEqualToString:_correctUsername] && [inputtedPassword isEqualToString:_correctPassword]){
            self.passcode.hidden = NO;
            self.loginTextFiled.enabled = NO;
            self.authorizeButton.enabled = NO;
            self.authorizeButton.layer.opacity = 0.5;
            self.loginTextFiled.layer.borderColor = _color.turquoiseGreen.CGColor;
            self.loginTextFiled.layer.opacity = 0.5;
            self.passwordTextField.enabled = NO;
            self.passwordTextField.layer.borderColor = _color.turquoiseGreen.CGColor;
            self.passwordTextField.layer.opacity = 0.5;
            [self.view endEditing:YES];
        }
        //incorrect login
        else if (![inputtedUsername isEqualToString:_correctUsername] &&
                 [inputtedPassword isEqualToString:_correctPassword]) {
            self.loginTextFiled.layer.borderColor = _color.venetioanRed.CGColor;
        }
        //incorrect password
        else if ([inputtedUsername isEqualToString:_correctUsername] &&
                 ![inputtedPassword isEqualToString:_correctPassword]) {
            self.passwordTextField.layer.borderColor = _color.venetioanRed.CGColor;
        }
        //both incorrect
        else if (![inputtedUsername isEqualToString:_correctUsername] &&
                 ![inputtedPassword isEqualToString:_correctPassword])  {
            self.loginTextFiled.layer.borderColor = _color.venetioanRed.CGColor;
            self.passwordTextField.layer.borderColor = _color.venetioanRed.CGColor;
        }
        
    }
    //empty login
    else if (!(self.loginTextFiled.text && self.loginTextFiled.text.length > 0) &&
             (self.passwordTextField.text && self.passwordTextField.text.length > 0))
    {
        self.loginTextFiled.layer.borderColor = _color.venetioanRed.CGColor;
    }
    //empty password
    else if ((self.loginTextFiled.text && self.loginTextFiled.text.length > 0) &&
             !(self.passwordTextField.text && self.passwordTextField.text.length > 0))
    {
        self.passwordTextField.layer.borderColor = _color.venetioanRed.CGColor;
    }
    //empty both
    else {
        self.loginTextFiled.layer.borderColor = _color.venetioanRed.CGColor;
        self.passwordTextField.layer.borderColor = _color.venetioanRed.CGColor;
    }
}

- (IBAction)touchedDown:(id)sender {
    self.authorizeButton.layer.backgroundColor = _color.littleBoyBlueTouchDownBackgroundButton.CGColor;
}

//passcode button implementation
- (IBAction)threeAction:(id)sender {
    self.buttonThree.layer.backgroundColor = _color.white.CGColor;
    [self checkPasscodeLogic:@"3"];
}

- (IBAction)twoAction:(id)sender {
    self.buttonTwo.layer.backgroundColor = _color.white.CGColor;
    [self checkPasscodeLogic:@"2"];
}

- (IBAction)oneAction:(id)sender {
    self.buttonOne.layer.backgroundColor = _color.white.CGColor;
    [self checkPasscodeLogic:@"1"];
}

- (IBAction)touchedDownButtonThree:(id)sender {
    self.buttonThree.layer.backgroundColor = _color.littleBoyBlueTouchDownBackgroundButton.CGColor;
}

- (IBAction)touchedDownButtonTwo:(id)sender {
    self.buttonTwo.layer.backgroundColor = _color.littleBoyBlueTouchDownBackgroundButton.CGColor;
}

- (IBAction)touchedDownButtonOne:(id)sender {
    self.buttonOne.layer.backgroundColor = _color.littleBoyBlueTouchDownBackgroundButton.CGColor;
}




- (IBAction)passwordEditingDidBegin:(id)sender {
    self.passwordTextField.layer.borderColor = _color.blackCoral.CGColor;
    self.passwordTextField.text = @"";
}

- (IBAction)loginEditingDidBegin:(id)sender {
    self.loginTextFiled.layer.borderColor = _color.blackCoral.CGColor;
    self.loginTextFiled.text = @"";
}

-(void)InformativeAlertWithmsg
{
    UIAlertController *alertvc = [UIAlertController alertControllerWithTitle: @"Welcome" message: @"You are successfuly authorized!" preferredStyle: UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle: @"Refresh" style: UIAlertActionStyleDefault handler: ^(UIAlertAction * action) {
        
        //should rewrite logic of refresh
        self.passcode.hidden = YES;
        self.loginTextFiled.enabled = YES;
        self.authorizeButton.enabled = YES;
        self.authorizeButton.layer.opacity = 1.0;
        self.loginTextFiled.layer.borderColor = self->_color.blackCoral.CGColor;
        self.loginTextFiled.layer.opacity = 1.0;
        self.passwordTextField.enabled = YES;
        self.passwordTextField.layer.borderColor = self->_color.blackCoral.CGColor;
        self.passwordTextField.layer.opacity = 1.0;
        self.passwordTextField.text = @"";
        self.loginTextFiled.text = @"";
        for (UIButton *value in self.passcodeButtons) {
            value.enabled = YES;
        }
        [self.view endEditing:NO];
        [self viewDidLoad];
    }];
    alertvc.view.tintColor = [UIColor redColor];
    [alertvc addAction: action];
    [self presentViewController: alertvc animated: true completion: nil];
}

//method lable declaration
- (void)checkPasscodeLogic:(NSString*) buttomValue {
    
    NSString *textFromLabel = [self.passcodeLabel text];
    NSLog(@"%@", [textFromLabel substringToIndex:1]);
    
    if ([textFromLabel hasPrefix:@"_"]){
        textFromLabel = buttomValue;
        self.passcodeString = textFromLabel;
        [self.passcodeLabel setText:self.passcodeString];
    } else {
        if ([self.passcodeString length] < [_correctPasscode length]){
            self.passcodeString = [NSString stringWithFormat:@"%@ %@", self.passcodeString, buttomValue];
            [self.passcodeLabel setText:self.passcodeString];
            if (([self.passcodeString isEqual:_correctPasscode]) && ([self.passcodeString length] == [_correctPasscode length])){
                for (UIButton *value in self.passcodeButtons)
                {
                    value.enabled = NO;
                }
                self.passcode.layer.borderColor = _color.turquoiseGreen.CGColor;
                [self InformativeAlertWithmsg];
            } else if (([self.passcodeString length] == [_correctPasscode length]) && ![self.passcodeString isEqual:_correctPasscode]){
                self.passcode.layer.borderColor = _color.venetioanRed.CGColor;
                self.passcodeString = @"_";
                [self.passcodeLabel setText:self.passcodeString];
            }
        }
    }
}

//UITextField delegate methods
- (void)textFieldShouldReturn:(UITextField *)anyTextField {
    [self.view endEditing:true];
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
    UITapGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [self.view addGestureRecognizer:gesture];
}

- (void)hide {
    [self.view endEditing:true];
}

- (void)keybaordWillShow:(NSNotification *)notification {
}

- (void)keybaordWillHide:(NSNotification *)notification {
}

- (void)updateTopContraintWith:(CGFloat) constant andBottom:(CGFloat) bottomConstant {
}

@end

