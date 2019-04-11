//
//  ReaderViewcontroller.h
//  FileOperator
//
//  Created by YJ Huang on 2019/4/10.
//  Copyright © 2019 YJ Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
@import DevEnhance;
NS_ASSUME_NONNULL_BEGIN

@interface ReaderViewcontroller : UIViewController
@property (nonatomic, strong) FileUnit *fileUnit;
@property (nonatomic, strong) UILabel *fileNameLabel;
@end

NS_ASSUME_NONNULL_END
