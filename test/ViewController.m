
#import "ViewController.h"
#import "TableAndColectionViewController.h"

typedef enum{
    EmptyLogin,
    EmptyPassword,
    BothFieldsEmpty,
    ShortLoginOrPassword,
    FirstLetterInLoginIsSmall,
    NoAtLeastOneBigLetterAndNumberInPassword,
    IncorectLogin,
    IncorectPassword
}LoginError;

NSString *kValidLogin = @"Cherrry";
NSString *kValidPassword = @"DoubleCherry7";

@interface ViewController ()<UITextFieldDelegate>
//@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
//@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (weak, nonatomic) TableAndColectionViewController *tableAndColectionViewContr;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end


@implementation ViewController
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.navigationController.navigationBarHidden = YES;

    self.loginBtn.layer.cornerRadius = 10;
    self.loginBtn.layer.masksToBounds = YES;
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Kosmos.jpeg"]]];
    self.errorLabel.hidden = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tap];
}

#pragma mark return realisation
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if (self.loginTextField.text.length < 5 ||
        ![self firstLetter:self.loginTextField.text]) {
        return NO;
    }
    [self.passwordTextField becomeFirstResponder];
    return YES;
}
#pragma mark go to button
- (IBAction)actionBtn:(id)sender {
    if ([self loginOrPasswordFailed]) {
        TableAndColectionViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"TableViewAndColectionView"];
        [self.navigationController pushViewController:secondViewController animated:YES];
    }
}


#pragma marl - Checking Login and password

-(BOOL)loginOrPasswordFailed{
    if (!self.loginTextField.text.length) {
        self.errorLabel.text = [self loginErrorToString:EmptyLogin];
        return NO;
    }
    if (!self.passwordTextField.text.length) {
        self.errorLabel.text = [self loginErrorToString:EmptyPassword];
        return NO;
    }
    if (self.loginTextField.text.length == 0 &&
        self.passwordTextField.text.length == 0) {
        self.errorLabel.text = [self loginErrorToString:BothFieldsEmpty];
        return NO;
    }
    if (self.loginTextField.text.length < 5 ||
        self.passwordTextField.text.length < 8) {
        self.errorLabel.text = [self loginErrorToString:ShortLoginOrPassword];
        return NO;
    }
    if (![self firstLetter:self.loginTextField.text]) {
        self.errorLabel.text = [self loginErrorToString:FirstLetterInLoginIsSmall];
        return NO;
    }
    if ([self counOfNumbersInString:self.passwordTextField.text] < 1 ||
        [self allBigLetters:self.passwordTextField.text] < 1) {
        self.errorLabel.text = [self loginErrorToString:NoAtLeastOneBigLetterAndNumberInPassword];
        return NO;
    }
    if (![self.loginTextField.text isEqualToString:kValidLogin])  {
        self.errorLabel.text = [self loginErrorToString:IncorectLogin];
        return NO;
    }
    if (![self.passwordTextField.text isEqualToString:kValidPassword]) {
        self.errorLabel.text = [self loginErrorToString:IncorectPassword];
        return NO;
    }
    return YES;

}

#pragma mark NSCharacterSet
- (NSUInteger)counOfNumbersInString:(NSString *)string
{
    NSUInteger count = 0;
    NSCharacterSet *decimalCharacterSet = [NSCharacterSet decimalDigitCharacterSet];
    for (NSUInteger i = 0; i < string.length; i++)
    {
        BOOL isUppercase = [decimalCharacterSet characterIsMember:[string characterAtIndex:i]];
        count += (int)isUppercase;
    }
    return count;
}

- (NSUInteger)allBigLetters:(NSString *)string
{
    NSUInteger count = 0;
    NSCharacterSet *uppercaseLetter = [NSCharacterSet uppercaseLetterCharacterSet];
    for (NSUInteger i = 0; i < string.length;i++)
    {
        
        BOOL isUppercase = [uppercaseLetter characterIsMember:[string characterAtIndex:i]];
        count += (int)isUppercase;
    }
    return count;
}
- (NSUInteger)firstLetter:(NSString *)string
{
    NSUInteger count = 0;
    NSCharacterSet *uppercaseLetter = [NSCharacterSet uppercaseLetterCharacterSet];
    if ([string characterAtIndex:0]) {
        
        BOOL isUppercase = [uppercaseLetter characterIsMember:[string characterAtIndex:0]];
        count += (int)isUppercase;
    }
    return count;
}

#pragma mark enum to string
-(NSString *)loginErrorToString:(LoginError)loginError{
    NSString *string = nil;
    self.errorLabel.hidden = NO;
    switch (loginError) {
            
        case EmptyLogin:
            string = @"Login is empty.Please, enter the login.";
            break;
        case EmptyPassword:
            string = @"Password is empty.Please, enter the password.";
            break;
        case BothFieldsEmpty:
            string = @"Please, enter login and password.";
            break;
        case ShortLoginOrPassword:
            string = @"Please, make login or password longer.";
            break;
        case FirstLetterInLoginIsSmall:
            string = @"Please, make the first letter in login big.";
            break;
        case NoAtLeastOneBigLetterAndNumberInPassword:
            string = @"Please, use at least one big letter and one number in password.";
            break;
        case IncorectLogin:
            string = @"Invalid login. Please enter valid login";
        break;
        case IncorectPassword:
            string = @"Invalid password. Please enter valid password";
        break;
    }
    return string;
}

#pragma mark TAP
- (void)tapAction:(UITapGestureRecognizer *)sender
{
    [self.loginTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
}

@end


