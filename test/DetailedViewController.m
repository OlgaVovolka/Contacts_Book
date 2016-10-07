#import "DetailedViewController.h"
#import "Users.h"


@interface DetailedViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UINavigationBar *userInfoBar;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;

@end

@implementation DetailedViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.userInfoBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.userInfoBar.shadowImage = [UIImage new];
    self.userInfoBar.translucent = YES;
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"Kosmos.jpeg"]]];
    self.nameLabel.text = self.user.name;
    self.lastNameLabel.text = self.user.lastName;
    self.imageView.image = self.user.image;
}

- (IBAction)backBtn:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
