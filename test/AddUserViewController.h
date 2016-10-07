
#import "ViewController.h"

extern NSString *const kUserInfoNameKey;
extern NSString *const kUserInfoLastNameKey;
extern NSString *const kUserInfoImageKey;

@protocol AddUserViewController <NSObject>

@optional

-(void)didFillUserInfo:(NSDictionary *)userInfo;

@end

typedef void (^DismissAddUserViewControllerBlock)(NSDictionary *userInfo);

@interface AddUserViewController : ViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) id<AddUserViewController> delegate;
@property (copy, nonatomic) DismissAddUserViewControllerBlock dismissBlock;

@end
