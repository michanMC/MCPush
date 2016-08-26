//
//  View3Controller.m
//  MCPush
//
//  Created by MC on 16/8/24.
//  Copyright © 2016年 MC. All rights reserved.
//
#define cellheightForHeader    10// RGBCOLOR(240, 243, 244);//

#import "View3Controller.h"
#import "MCIucencyView.h"
@interface View3Controller ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    
    MCIucencyView * _bgLucencyView;
    UIScrollView * _bgView;
    UITableView * _tableView;
    UIImageView * imgview;
    UIView *_toolsView;
    
}

@end

@implementation View3Controller
static void *HHHorizontalPagingViewScrollContext = &HHHorizontalPagingViewScrollContext;

- (void)dealloc
{
    [_tableView removeObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset)) context:nil];
    [_bgView removeObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset)) context:&HHHorizontalPagingViewScrollContext];

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity,1,1);

    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(actionBack)];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *pictureName= [NSString stringWithFormat:@"screenShow_%d.png",3];
    NSString *savedImagePath = [documentsDirectory stringByAppendingPathComponent:pictureName];
    if (savedImagePath) {
        imgview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:savedImagePath];
        imgview.image = savedImage;
        [self.view addSubview:imgview];
        imgview.transform = CGAffineTransformScale(CGAffineTransformIdentity,0.9,0.9);
    }
    _bgLucencyView = [[MCIucencyView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:_bgLucencyView];
    [_bgLucencyView setBgViewAlpha:0.5];
    _viewCell = [[UIView alloc]initWithFrame:_rect];
    _viewCell.backgroundColor =  AppMCBgCOLOR;
        [_bgLucencyView addSubview:_viewCell];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [UIView animateWithDuration:0.35 animations:^{
            _viewCell.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
            
        } completion:^(BOOL finished) {
            [_viewCell removeFromSuperview];
            _bgView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64,self.view.frame.size.width, self.view.frame.size.height - 64)];
            _bgView.backgroundColor = [UIColor clearColor];
            _bgView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height-64+1);
            _bgView.scrollEnabled = NO;
            _bgView.delegate = self;
            [_bgView addObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset)) options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:&HHHorizontalPagingViewScrollContext];

           [_bgLucencyView addSubview:_bgView];

            _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,self.view.frame.size.width, _bgView.frame.size.height - 40 )];
            _tableView.delegate =self;
            _tableView.dataSource = self;
            _tableView.backgroundColor = AppMCBgCOLOR;
       //     _tableView.bounces = NO;
           [_bgView addSubview:_tableView];
            [_tableView addObserver:self forKeyPath:NSStringFromSelector(@selector(contentOffset)) options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];

            _toolsView = [self toolView];//[[UIView alloc]initWithFrame:CGRectMake(0, _bgView.frame.size.height - 40, self.view.frame.size.width, 40)];
            _toolsView.backgroundColor = [UIColor redColor];
            [_bgView addSubview:_toolsView];

            
        }];
        
    });

    // Do any additional setup after loading the view.
}
-(UIView*)toolView{
    UIView *toolsView = [[UIView alloc]initWithFrame:CGRectMake(0, _bgView.frame.size.height - 40, self.view.frame.size.width, 40)];
    toolsView.backgroundColor = [UIColor redColor];
 
    return toolsView;
    
}
-(void)actionBack{
    [UIView animateWithDuration:0.35 animations:^{
        _bgView.frame = CGRectMake(0,_bgView.frame.size.height, _bgView.frame.size.width, _bgView.frame.size.height);
        [_bgLucencyView setBgViewAlpha:0];
        
        imgview.transform = CGAffineTransformScale(CGAffineTransformIdentity,1,1);
        
    } completion:^(BOOL finished) {
        
        [self.navigationController popViewControllerAnimated:NO];
    }];

    
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    
    CGFloat oldOffsetY          = [change[NSKeyValueChangeOldKey] CGPointValue].y;
    CGFloat newOffsetY          = [change[NSKeyValueChangeNewKey] CGPointValue].y;
    CGFloat deltaY              = newOffsetY - oldOffsetY;
    
    if (context == &HHHorizontalPagingViewScrollContext) {
        
        NSLog(@"newOffsetY===%f",newOffsetY);
        
        if (newOffsetY>=80) {
            [UIView animateWithDuration:0.35 animations:^{
                _bgView.frame = CGRectMake(0,- _bgView.frame.size.height, _bgView.frame.size.width, _bgView.frame.size.height);
                [_bgLucencyView setBgViewAlpha:0];

                imgview.transform = CGAffineTransformScale(CGAffineTransformIdentity,1,1);
                
            } completion:^(BOOL finished) {
            
                [self.navigationController popViewControllerAnimated:NO];
            }];
        }
        
    }
    else
    {

    if(deltaY >= 0) {    //向上滚动
        NSLog(@"向上滚动");
        _tableView.bounces = NO;
        _bgView.scrollEnabled = YES;

        
    }else {            //向下滚动
        NSLog(@"向下滚动");
        _tableView.bounces = YES;
        _bgView.scrollEnabled = NO;

    }
    
    }
    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView == _bgView) {
        
        _bgView.contentOffset = CGPointMake(0, 0);
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 15;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return cellheightForHeader;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[UITableViewCell alloc]init];
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
