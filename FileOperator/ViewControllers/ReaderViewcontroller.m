//
//  ReaderViewcontroller.m
//  FileOperator
//
//  Created by YJ Huang on 2019/4/10.
//  Copyright © 2019 YJ Huang. All rights reserved.
//

#import "ReaderViewcontroller.h"

@interface ReaderViewcontroller ()

@end

@implementation ReaderViewcontroller

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    self.fileNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, 30)];
    self.fileNameLabel.center = self.view.center;
    self.fileNameLabel.text = self.fileUnit.name;
    [self.view addSubview:self.fileNameLabel];
    
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    NSLog(@"%2.f,%2.f",touch.force,touch.maximumPossibleForce);
    
    CGFloat radio = touch.force / touch.maximumPossibleForce;
    
    self.view.backgroundColor = [UIColor colorWithRed:radio green:radio blue:radio alpha:1];
}

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    // 生成UIPreviewAction
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"dissmiss" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        
    }];
    
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"Action 2" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Action 2 selected");
    }];
    
    UIPreviewAction *action3 = [UIPreviewAction actionWithTitle:@"Action 3" style:UIPreviewActionStyleSelected handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Action 3 selected");
    }];
    
    // 赛到UIPreviewActionGroup中
    NSArray *actions = @[action1, action2, action3];
    
    UIPreviewActionGroup *group1 = [UIPreviewActionGroup actionGroupWithTitle:@"Action Group" style:UIPreviewActionStyleDefault actions:actions];
    NSArray *group = @[group1];
    return group;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
