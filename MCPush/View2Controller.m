//
//  View2Controller.m
//  MCPush
//
//  Created by MC on 16/8/24.
//  Copyright © 2016年 MC. All rights reserved.
//

#import "View2Controller.h"
#import "View3Controller.h"
#import "TableViewCell.h"
@interface View2Controller ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView * _tableView;
}


@end

@implementation View2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = AppMCBgCOLOR;
    
     _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    _tableView.delegate =self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = AppMCBgCOLOR;
    [self.view addSubview:_tableView];
    // Do any additional setup after loading the view.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 10;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"mc"];
    if (!cell) {
        cell = [[TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"mc"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell prepareUI1];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [self ScreenShot];
    CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
    CGRect rect = [tableView convertRect:rectInTableView toView:[tableView superview]];

    NSLog(@"========%f",rect.origin.y);
    View3Controller * testVC = [[View3Controller alloc]init];
    testVC.rect = rect;
    testVC.hidesBottomBarWhenPushed = YES;
    [UIView animateWithDuration:0.35 animations:^{
        self.tabBarController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.9,0.9);
        
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.3 animations:^{
        }completion:^(BOOL finished) {
            [self.navigationController pushViewController:testVC animated:NO];
        }];
        
    }];

}
-(void)ScreenShot{
    
    
    CGSize imageSize = [[UIScreen mainScreen] bounds].size;
   
    if (NULL != &UIGraphicsBeginImageContextWithOptions) {
        UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0);
    }
    else
    {
        UIGraphicsBeginImageContext(imageSize);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    for (UIWindow * window in [[UIApplication sharedApplication] windows]) {
        if (![window respondsToSelector:@selector(screen)] || [window screen] == [UIScreen mainScreen]) {
            CGContextSaveGState(context);
            CGContextTranslateCTM(context, [window center].x, [window center].y);
            CGContextConcatCTM(context, [window transform]);
            CGContextTranslateCTM(context, -[window bounds].size.width*[[window layer] anchorPoint].x, -[window bounds].size.height*[[window layer] anchorPoint].y);
            [[window layer] renderInContext:context];
            
            CGContextRestoreGState(context);
        }
    }
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
//    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);//保存图片到照片库
        NSData *imageViewData = UIImagePNGRepresentation(image);

        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
    
        NSString *pictureName= [NSString stringWithFormat:@"screenShow_%d.png",3];
        NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:pictureName];
    
        NSLog(@"截屏路径打印: %@", savedImagePath);
    
         [imageViewData writeToFile:savedImagePath atomically:YES];//保存照片到沙盒目录
//         CGImageRelease(imageRefRect);

    
    
    NSLog(@"Suceeded!");


}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
