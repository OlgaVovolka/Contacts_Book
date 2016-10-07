
#import "AddUserViewController.h"

NSString *const kUserInfoNameKey = @"name";
NSString *const kUserInfoLastNameKey = @"lastname";
NSString *const kUserInfoImageKey = @"avatar";

typedef enum{
    EmptyName,
    EmptyLastName,
    ErrorAvatar,
}UserError;

@interface AddUserViewController ()


@property (weak, nonatomic) IBOutlet UITextField *addUserName;
@property (weak, nonatomic) IBOutlet UITextField *addLastName;
@property (weak, nonatomic) IBOutlet UINavigationBar *addUserBar;
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) UIImage *avatarImage;
@end


@implementation AddUserViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.addUserBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.addUserBar.shadowImage = [UIImage new];
    self.addUserBar.translucent = YES;
    self.addUserName.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.addLastName.clearButtonMode = UITextFieldViewModeWhileEditing;
}

#pragma mark - ActionsButton
- (IBAction)saveUserBtn:(id)sender {
    if ([self checkUserFields]) {
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSDictionary *userDictionary = @{kUserInfoNameKey : self.addUserName.text,
                                     kUserInfoLastNameKey : self.addLastName.text,
                                     kUserInfoImageKey : self.avatarImage};
    if ([self.delegate respondsToSelector:@selector(didFillUserInfo:)]) {
        [self.delegate didFillUserInfo:userDictionary];
    }
    if (self.dismissBlock) {
        self.dismissBlock(userDictionary);
    }
    }
    [self saveImage:self.avatarImage withImageName:@"avatarImage"];
}

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (IBAction)addImage:(id)sender {
    UIImagePickerController *picker = [UIImagePickerController new];
    picker.delegate = self;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIImagePickerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    self.avatarImage = [info objectForKey:UIImagePickerControllerOriginalImage];
    [self.avatarImageView setImage:self.avatarImage];
    [self dismissViewControllerAnimated:YES completion:NULL];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:NULL];
}
- (void)saveImage:(UIImage*)image withImageName:(NSString*)imageName {
    NSData *imageData = UIImagePNGRepresentation(image); //convert image into .png format.
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", imageName]];
    [fileManager createFileAtPath:fullPath contents:imageData attributes:nil];
    //NSLog(@"image saved");
}
- (UIImage*)loadImage:(NSString*)imageName {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", imageName]];
    
    return [UIImage imageWithContentsOfFile:fullPath];
}

#pragma mark - CheckUserFields
-(BOOL)checkUserFields{
    UIAlertController *alertController = [UIAlertController new];
    if (!self.addUserName.text.length) {
        alertController = [self userErrorToAlertController:EmptyName];
        return NO;
    }
    if (!self.addLastName.text.length) {
        alertController = [self userErrorToAlertController:EmptyLastName];
        return NO;
    }
    if (!self.avatarImageView.image) {
        alertController = [self userErrorToAlertController:ErrorAvatar];
        return NO;
    }else
    return YES;
}


-(UIAlertController *)userErrorToAlertController:(UserError)userError{
    UIAlertController *alertController = [UIAlertController new];
    UIAlertAction *alertActions = [UIAlertAction new];
    switch (userError) {
        case EmptyName:
            alertController = [UIAlertController alertControllerWithTitle:@"Empty user name" message:@"Empty user name. Please enter name field" preferredStyle:UIAlertControllerStyleAlert];
            break;
        case EmptyLastName:
            alertController = [UIAlertController alertControllerWithTitle:@"Empty user lastName" message:@"Empty user last name. Please enter last name field" preferredStyle:UIAlertControllerStyleAlert];
            break;
        case ErrorAvatar:
            alertController = [UIAlertController alertControllerWithTitle:@"Empty avatar" message:@"Empty avatar. Please enter avatar" preferredStyle:UIAlertControllerStyleAlert];
            break;
    }
    alertActions =  [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:NULL];
    [alertController addAction:alertActions];
    [self presentViewController:alertController animated:YES completion:NULL];
    return alertController;
}


@end
