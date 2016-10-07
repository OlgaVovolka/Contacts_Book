
#import "Users.h"

@implementation Users

-(instancetype)initWithName:(NSString*)name lastName:(NSString*)lastName imageName:(NSString*)imageName{
    self = [super init];
    if (self) {
        
        self.name = name;
        self.lastName = lastName;
        self.imageName = imageName;
    }
    return self;}

-(instancetype)initWithName:(NSString*)name lastName:(NSString*)lastName image:(UIImage*)image{
    self = [super init];
    if (self) {
        
        self.name = name;
        self.lastName = lastName;
        self.image = image;
    }
    return self;

}
-(UIImage *)image{
    return _image ? _image :[UIImage imageNamed:self.imageName];
}

@end
