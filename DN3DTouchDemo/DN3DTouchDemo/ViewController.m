//
//  ViewController.m
//  DN3DTouchDemo
//
//  Created by mainone on 16/5/4.
//  Copyright © 2016年 wjn. All rights reserved.
//

#import "ViewController.h"
#import "TouchViewController.h"
#import "DrawViewController.h"

@interface ViewController () <UITableViewDataSource,UITableViewDelegate,UIViewControllerPreviewingDelegate>
{
    NSArray *cellArr;
    UITableView *tbView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initTableView];
//    [self check3DTouch];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initTableView
{
    
    cellArr = [[NSArray alloc]initWithObjects:@"使劲按我吧",@"使劲按也没用", nil];
    tbView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    tbView.dataSource = self;
    tbView.delegate = self;
    tbView.showsHorizontalScrollIndicator = NO;
    tbView.showsVerticalScrollIndicator = NO;
    tbView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:tbView];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return cellArr.count;
    
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * ID = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    if (indexPath.row == 0) {//注册3D touch
        [self registerForPreviewingWithDelegate:self sourceView:cell];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = cellArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        DrawViewController *vc = [[DrawViewController alloc] initWithNibName:@"DrawViewController" bundle:nil];
        [self.navigationController pushViewController:vc animated:YES];
    }
}


-(void)check3DTouch
{
    if(self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable)
    {
        //ok
    }
    else{
        //notok
    }
}


#pragma mark - UIViewControllerPreviewingDelegate

- (UIViewController *)previewingContext:(id)context viewControllerForLocation:(CGPoint) point {
    
    TouchViewController *childVC = [[TouchViewController alloc] initWithNibName:@"TouchViewController" bundle:nil];
    childVC.preferredContentSize = CGSizeMake(0.0f,600.f);
    return childVC;
}

- (void)previewingContext:(id <UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    [self showViewController:viewControllerToCommit sender:self];
}

@end
