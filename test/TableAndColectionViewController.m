
#import "TableAndColectionViewController.h"
#import "TableViewCell.h"
#import "ColectionViewCell.h"
#import "DetailedViewController.h"
#import "ViewController.h"
#import "AddUserViewController.h"
#import "Users.h"

NSString *const kUserPlstName = @"Users";
NSString *const kUserPlstType = @"plist";

@implementation TableAndColectionViewController{
    NSArray *array;
}


-(void)viewDidLoad{
    [super viewDidLoad];
    self.navigationController.navigationItem.leftBarButtonItem = nil;
    self.colectionDataBase.hidden = YES;
    [self loadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showDetails"])
    {
        DetailedViewController *detailedViewController = segue.destinationViewController;
        detailedViewController.user = array[self.selectedCellIndex];
    }
    else if ([segue.identifier isEqualToString:@"showAddUser"])
    {
        AddUserViewController *addUser = segue.destinationViewController;
        addUser.delegate = self;
        addUser.dismissBlock = ^(NSDictionary *userInfo){
            Users *user = [[Users alloc] initWithName:userInfo[kUserInfoNameKey] lastName:userInfo[kUserInfoLastNameKey] image:userInfo[kUserInfoImageKey]];
            NSMutableArray *mutableArray = [array mutableCopy];
            [mutableArray addObject:user];
            array = [mutableArray copy];
            [self saveData];
            [self.colectionDataBase reloadData];
            [self.tableDataBase reloadData];
        };
    }
}
-(void)loadData{
    NSString *userusPlist =[[NSBundle mainBundle] pathForResource:kUserPlstName ofType:kUserPlstType];
    NSMutableArray *mutableUsers = [NSMutableArray new];
    NSArray *usersArray = [NSArray arrayWithContentsOfFile:userusPlist];
    for (NSDictionary *usersInfo in usersArray) {
        Users *users = [[Users alloc] initWithName:usersInfo[@"name"] lastName:usersInfo[@"lastname"] imageName:usersInfo[@"avatar"]];
        [mutableUsers addObject:users];
    }
    array = [mutableUsers copy];
}
-(void)saveData{
    NSString *usersPlist = [[NSBundle mainBundle] pathForResource:kUserPlstName ofType:kUserPlstType];
    
    NSMutableArray *user = [NSMutableArray new];
    
    for (Users *users in array)
    {
        NSDictionary *usersInfo = @{@"name" : users.name,
                                    @"lastname" : users.lastName,
                                    @"avatar" : users.image};
        [user addObject:usersInfo];
    }
    [[array copy] writeToFile:usersPlist atomically:NO];
}

- (IBAction)switchColectionAndTableVision:(id)sender {
    self.tableDataBase.alpha = 0;
    self.colectionDataBase.alpha = 0;
    
    if (self.segmentController.selectedSegmentIndex == 0 ){
        self.tableDataBase.hidden = NO;
        self.colectionDataBase.hidden = YES;
        [UIView animateWithDuration:1 animations:^{
            self.tableDataBase.alpha = 1;
        }];
        
        
    }else if (self.segmentController.selectedSegmentIndex == 1){
        self.tableDataBase.hidden = YES;
        self.colectionDataBase.hidden = NO;
        [UIView animateWithDuration:1 animations:^{
            self.colectionDataBase.alpha = 1;
        }];
        
    }
}

#pragma mark - AddUserViewController
-(void)didFillUserInfo:(NSDictionary *)userInfo{

}
#pragma mark - TableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return array.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedCellIndex = [indexPath item];
    [self performSegueWithIdentifier:@"showDetails" sender:self];
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *const kCellIdentifier = @"userTable";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    Users *user = array[indexPath.row];
    cell.userName.text = user.name;
    cell.userLastName.text = user.lastName;
    cell.userImage.image = user.image;
    
    return cell;
}


#pragma mark - ColectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return array.count;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
        self.selectedCellIndex = [indexPath item];
        [self performSegueWithIdentifier:@"showDetails" sender:self];
}



- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *const kCellIdentifier = @"userCollection";
    ColectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellIdentifier forIndexPath:indexPath];
    Users *user = array[indexPath.row];
    cell.userName.text = user.name;
    cell.userLastName.text = user.lastName;
    cell.userImage.image = user.image;
    
    return cell;
}

- (IBAction)addUserBtn:(id)sender {
    [self performSegueWithIdentifier:@"showAddUser" sender:self];
}

@end
