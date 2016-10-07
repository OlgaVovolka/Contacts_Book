
#import <Foundation/Foundation.h>
#import <UIKIt/UIKit.h>

@interface Users : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *imageName;
@property (strong, nonatomic) UIImage *image;


-(instancetype)initWithName:(NSString*)name lastName:(NSString*)lastName imageName:(NSString*)imageName;
-(instancetype)initWithName:(NSString*)name lastName:(NSString*)lastName image:(UIImage*)image;

@end
