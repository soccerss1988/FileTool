//
//  ViewController.m
//  FileOperator
//
//  Created by YJ Huang on 2019/4/7.
//  Copyright © 2019 YJ Huang. All rights reserved.
//

#import "ViewController.h"
#import "FileUnitCell.h"
#import "FileListCell.h"

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
    self.collectionlayout.minimumInteritemSpacing = 3;
    
    self.fileCollectionView.collectionViewLayout = self.collectionlayout;
    
    [self.fileCollectionView registerNib:[UINib nibWithNibName:@"FileUnitCell" bundle:nil] forCellWithReuseIdentifier:fileUnitCellId];
    [self.fileCollectionView registerNib:[UINib nibWithNibName:@"FileListCell" bundle:nil] forCellWithReuseIdentifier:fileListCellId];
}

- (NSArray*)getFileExtenWithFilderPath:(NSArray*)paths {
    NSMutableArray * fileNams = [[NSMutableArray alloc]init];
    for (NSString *path in paths) {
        NSString *name = [path lastPathComponent];
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
        return listCell;
    }
    else {
        FileUnitCell* unitCell = [collectionView dequeueReusableCellWithReuseIdentifier:fileUnitCellId forIndexPath:indexPath];
        NSArray *fileName = [self getFileExtenWithFilderPath:self.fileList];
        unitCell.fileName.text = fileName[indexPath.row];
        unitCell.fileTypeImage.image = [self getcurrentFileImageWithFileName:fileName[indexPath.row]];
        return unitCell;
    }
    return [[UICollectionViewCell alloc]init];
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

@end
