//
//  FileListCell.h
//  FileOperator
//
//  Created by YJ Huang on 2019/4/7.
//  Copyright © 2019 YJ Huang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXPORT NSString * const fileListCellId;

@interface FileListCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *fileTypeImageView;
@property (weak, nonatomic) IBOutlet UILabel *fileName;
@end

NS_ASSUME_NONNULL_END
