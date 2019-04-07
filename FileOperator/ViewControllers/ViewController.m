//
//  ViewController.m
//  FileOperator
//
//  Created by YJ Huang on 2019/4/7.
//  Copyright © 2019 YJ Huang. All rights reserved.
//

#import "ViewController.h"
typedef NS_ENUM(NSInteger, FileDisplayMode) {
    ListMode,
    CollectionMode
};

@import DevEnhance;
@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *fileCollectionView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *disPlayModSegment;
@property (assign, nonatomic) FileDisplayMode displayMode;
@property (strong, nonatomic) NSArray *fileList;
@property (strong, nonatomic) UICollectionViewFlowLayout *collectionlayout;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib
    
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
    self.fileList = [[NSArray alloc]init];
    self.fileList = [[NSFileManager defaultManager] getFilePathFromContentFolder:[[NSFileManager defaultManager] documentDirectory]];
    NSLog(@"%@",self.fileList);
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
    
    self.fileCollectionView.collectionViewLayout = self.collectionlayout;
    self.collectionlayout.minimumInteritemSpacing = 10;
}


- (void)transfomeFlieDisplayWihtMode:(FileDisplayMode)mode {
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.fileList.count*2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"fileUnit" forIndexPath:indexPath];
    cell.alpha = 0;
    [UIView animateWithDuration:0.5 animations:^{
        cell.alpha = 1;
    }];
    return cell;
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
        return CGSizeMake(width, width/5);
    }
    else
    {
        return CGSizeMake((width - 20)/3, (width - 20)/3);
    }
    
    return CGSizeZero;
}

@end
