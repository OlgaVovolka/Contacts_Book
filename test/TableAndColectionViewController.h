
#import <UIKit/UIKit.h>
#import "AddUserViewController.h"

@interface TableAndColectionViewController : UIViewController<UITableViewDelegate,UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, AddUserViewController>

@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentController;
@property (weak, nonatomic) IBOutlet UITableView *tableDataBase;
@property (weak, nonatomic) IBOutlet UICollectionView *colectionDataBase;
@property (assign, nonatomic) NSUInteger selectedCellIndex;

@end
