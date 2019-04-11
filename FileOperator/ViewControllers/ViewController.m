//
//  ViewController.m
//  FileOperator
//
//  Created by YJ Huang on 2019/4/7.
//  Copyright © 2019 YJ Huang. All rights reserved.
//

#import "ViewController.h"
#import "ReaderViewcontroller.h"
#import "FileUnitCell.h"
#import "FileListCell.h"
@import DevEnhance;


typedef NS_ENUM(NSInteger, FileDisplayMode) {
    ListMode,
    CollectionMode
};

@import DevEnhance;
@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UIViewControllerPreviewingDelegate>
@property (weak, nonatomic) IBOutlet UICollectionView *fileCollectionView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *disPlayModSegment;
@property (assign, nonatomic) FileDisplayMode displayMode;
@property (strong, nonatomic) NSMutableArray<FileUnit*> *fileList;
@property (strong, nonatomic) UICollectionViewFlowLayout *collectionlayout;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib
//    NSLog(@"%@",[[NSFileManager defaultManager]documentDirectory]);
    //Data
    [self getFileListWithContentDirectory];
    
    //UI
    [self setupSegment];
    [self setupCollectionView];
    
}

- (void)setupSegment {
    
    UIImage *listImg =  [UIImage imageNamed:@"listMode"];
    [self.disPlayModSegment setImage:listImg forSegmentAtIndex:0];
    UIImage *collectionImg = [UIImage imageNamed:@"collectionMode"];
    [self.disPlayModSegment setImage:collectionImg forSegmentAtIndex:1];
    self.disPlayModSegment.tintColor = [UIColor darkGrayColor];
    [self.disPlayModSegment addTarget:self action:@selector(fileModeSegmentDidClicked:) forControlEvents:UIControlEventValueChanged];
    
    //defult mode
    self.displayMode = ListMode;
    
}

- (void)viewDidLayoutSubviews {
    
}

- (void)getFileListWithContentDirectory {
    
    NSString *jsonFile = [[NSBundle mainBundle] pathForResource:@"FileList" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:jsonFile];
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
    NSArray *fileList = json[@"FileList"];
    
    self.fileList = [[NSMutableArray alloc]init];
    for(NSDictionary * fileInfo in fileList) {
        NSString *filePath = [[NSBundle mainBundle] pathForResource:fileInfo[@"FileName"] ofType:fileInfo[@"type"]];
        FileUnit *fileUnit = [[FileUnit alloc]initWithContentsOfPath:filePath];
        [self.fileList addObject:fileUnit];
    }
}

- (void)fileModeSegmentDidClicked:(UISegmentedControl*)sender {
    
    switch (sender.selectedSegmentIndex) {
        case 0:
            self.displayMode = ListMode;
            
            break;
        case 1:
            self.displayMode = CollectionMode;
            break;
        default:
            break;
    }
    [self.fileCollectionView reloadData];
}

- (void)setupCollectionView {
    
    self.fileCollectionView.delegate = self;
    self.fileCollectionView.dataSource = self;
    
    self.collectionlayout = [[UICollectionViewFlowLayout alloc]init];
    self.collectionlayout.minimumInteritemSpacing = 3;
    
    self.fileCollectionView.collectionViewLayout = self.collectionlayout;
    
    [self.fileCollectionView registerNib:[UINib nibWithNibName:@"FileUnitCell" bundle:nil] forCellWithReuseIdentifier:fileUnitCellId];
    [self.fileCollectionView registerNib:[UINib nibWithNibName:@"FileListCell" bundle:nil] forCellWithReuseIdentifier:fileListCellId];
}

- (NSArray*)getFileExtenWithFilderPath:(NSArray<FileUnit*>*)paths {
    NSMutableArray * fileNams = [[NSMutableArray alloc]init];
    for (FileUnit *fileUnit in paths) {
        NSString *name = fileUnit.name;
        if(name) {
            [fileNams addObject:name];
        }
    }
    return [NSArray arrayWithArray:fileNams];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.fileList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if(self.displayMode == ListMode) {
        
       FileListCell * listCell = [collectionView dequeueReusableCellWithReuseIdentifier:fileListCellId forIndexPath:indexPath];
        NSArray *fileName = [self getFileExtenWithFilderPath:self.fileList];
        listCell.fileTypeImageView.image = [self getcurrentFileImageWithFileName:fileName[indexPath.row]];
        listCell.fileName.text = fileName[indexPath.row];
        [self switchModeAnimation:listCell];
        return listCell;
    }
    else {
        FileUnitCell* unitCell = [collectionView dequeueReusableCellWithReuseIdentifier:fileUnitCellId forIndexPath:indexPath];
        NSArray *fileName = [self getFileExtenWithFilderPath:self.fileList];
        unitCell.fileName.text = fileName[indexPath.row];
        unitCell.fileTypeImage.image = [self getcurrentFileImageWithFileName:fileName[indexPath.row]];
        [self switchModeAnimation:unitCell];
        return unitCell;
    }
    return [[UICollectionViewCell alloc]init];
}

- (void)switchModeAnimation:(UICollectionViewCell*)cell {
    
    if(self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
        [self registerForPreviewingWithDelegate:self sourceView:cell];
    }
    
    cell.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        cell.alpha = 1;
    }];
}
- (UIImage*)getcurrentFileImageWithFileName:(NSString*)name {
    NSString *fileExten = name.pathExtension;
    return [UIImage imageNamed:[fileExten lowercaseString]];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {

    
    
    
    NSLog(@"select index %ld",(long)indexPath.row);
}

//每个单元格的大小size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = self.fileCollectionView.frame.size.width;
    
    if(self.displayMode == ListMode)
    {
        self.collectionlayout.minimumLineSpacing = 0;
        return CGSizeMake(width, width/10);
    }
    else
    {
        self.collectionlayout.minimumLineSpacing = 5;
        return CGSizeMake((width - 20)/3, (width - 20)/3);
        
    }
    return CGSizeZero;
}

//MARK: UIViewControllerPreviewingDelegate
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    
    location = [self.fileCollectionView convertPoint:location fromView:[previewingContext sourceView]];
    NSIndexPath *collectionIndex = [self.fileCollectionView indexPathForItemAtPoint:location];
    FileUnit *fileUnit = self.fileList[collectionIndex.row];
    
    ReaderViewcontroller *readerVC = [[ReaderViewcontroller alloc]init];
    readerVC.fileUnit = fileUnit;
    return readerVC;
}

- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    [self.navigationController pushViewController:viewControllerToCommit animated:YES];
}



@end
