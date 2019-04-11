//
//  FileUnitCell.h
//  FileOperator
//
//  Created by YJ Huang on 2019/4/7.
//  Copyright © 2019 YJ Huang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
FOUNDATION_EXPORT NSString * const fileUnitCellId;

@interface FileUnitCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *fileTypeImage;
@property (weak, nonatomic) IBOutlet UILabel *fileName;
@end

NS_ASSUME_NONNULL_END
