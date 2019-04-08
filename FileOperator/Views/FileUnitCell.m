//
//  FileUnitCell.m
//  FileOperator
//
//  Created by YJ Huang on 2019/4/7.
//  Copyright © 2019 YJ Huang. All rights reserved.
//

#import "FileUnitCell.h"
NSString * const fileUnitCellId = @"fileUnitCellId";
@implementation FileUnitCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization cod    
}

- (void)setSelected:(BOOL)selected {
    NSLog(@"didSelect");
    if (selected) {
        self.backgroundColor = [UIColor darkGrayColor];
    } else {
        self.backgroundColor = [UIColor whiteColor];
    }
}

- (void)setHighlighted:(BOOL)highlighted {
    NSLog(@"setHighlighted");
    if (highlighted) {
        self.alpha = 0.8;
    } else {
        [UIView animateWithDuration:0.1 delay:0.1 options:UIViewAnimationOptionCurveEaseOut animations:^{
            self.backgroundColor = [UIColor whiteColor];
        } completion:nil];
    }
}

@end
