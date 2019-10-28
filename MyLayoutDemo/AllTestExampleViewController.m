//
//  AllTestExampleViewController.m
//  MyLayoutDemo
//
//  Created by oubaiquan on 2018/8/1.
//  Copyright © 2018年 YoungSoft. All rights reserved.
//

#import "AllTestExampleViewController.h"
#import "MyLayout.h"
#import "CFTool.h"

@interface AllTestExampleViewController ()


@end

@implementation AllTestExampleViewController

- (void)viewDidLoad {
    self.edgesForExtendedLayout = UIRectEdgeNone;  //设置视图控制器中的视图尺寸不延伸到导航条或者工具条下面。您可以注释这句代码看看效果。
    
    [super viewDidLoad];
    self.view.backgroundColor  = [UIColor whiteColor];
    
   // [self example1];
   // [self example2];
    [self example3];
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

-(void)example1
{
    //验证相对布局的其他分支覆盖。
    
    MyRelativeLayout *rootLayout = [MyRelativeLayout new];
    rootLayout.myMargin = 0;
    [self.view addSubview:rootLayout];
    
    
    UIView *v1 = [UIView new];
    v1.mySize = CGSizeMake(100, 100);
    v1.myTop = 100;
    v1.myLeft = 100;
    v1.visibility = MyVisibility_Gone;
    [rootLayout addSubview:v1];
    
    //某个视图的水平居中依赖另外一个视图，另外一个视图隐藏。
    UIView *v2 = [UIView new];
    v2.mySize = CGSizeMake(100, 100);
    v2.centerXPos.equalTo(v1.centerXPos).offset(20);
    v2.centerYPos.equalTo(v1.centerYPos).offset(20);
    [rootLayout addSubview:v2];
    
    //某个视图的左边依赖另外一个视图，另外一个视图隐藏。
    UIView *v3 = [UIView new];
    v3.mySize = CGSizeMake(100, 100);
    v3.leadingPos.equalTo(v1.leadingPos).offset(20);
    v3.bottomPos.equalTo(v1.bottomPos).offset(20);
    [rootLayout addSubview:v3];

    UIView *v4 = [UIView new];
    v4.mySize = CGSizeMake(100, 100);
    v4.leadingPos.lBound(v3.leadingPos, 0);
    v4.trailingPos.uBound(rootLayout.trailingPos,0);
    v4.bottomPos.equalTo(@(10));
    [rootLayout addSubview:v4];

    UIView *v5 = [UIView new];
    v5.mySize = CGSizeMake(100, 100);
    v5.baselinePos.equalTo(v4.baselinePos).offset(20);
    [rootLayout addSubview:v5];
    
    UILabel *v6 = [UILabel new];
    v6.mySize = CGSizeMake(100, 100);
    v6.baselinePos.equalTo(v1.baselinePos).offset(20);
    [rootLayout addSubview:v6];

    UILabel *v7 = [UILabel new];
    v7.mySize = CGSizeMake(100, 100);
    v7.baselinePos.equalTo(@(40));
    [rootLayout addSubview:v7];
    
}

-(void)example2
{
    MyFrameLayout *rootLayout = [MyFrameLayout new];
    rootLayout.myMargin = 0;
    [self.view addSubview:rootLayout];
    
    // B 视图
    UIScrollView *scrollview = [[UIScrollView alloc] init];
    scrollview.backgroundColor = [UIColor blueColor];
    scrollview.myHorzMargin = 0;
    scrollview.wrapContentHeight = YES;
    scrollview.heightSize.max(400).min(280);
    [rootLayout addSubview:scrollview];
    
    // 内容C视图
    MyLinearLayout * backLinear = [MyLinearLayout linearLayoutWithOrientation:MyOrientation_Vert];
    backLinear.backgroundColor = [UIColor greenColor];
    backLinear.myHorzMargin = 0;
    backLinear.heightSize.min(280);
    backLinear.gravity = MyGravity_Vert_Bottom;
    [scrollview addSubview:backLinear];
    
    UIView *v = [UIView new];
    v.myHeight = 500;  //调整不同的尺寸得到不同的结果。分别设置为100， 350， 500
    v.myWidth = 100;
    v.backgroundColor = [UIColor redColor];
    [backLinear addSubview:v];

}

-(void)example3
{
    //用链式语法创建一个弹性布局，宽度和父视图一致，高度为100
    MyFlexLayout *layout = MyFlexLayout.new.flex
    .flex_direction(MyFlexDirection_Row)
    .flex_wrap(MyFlexWrap_Wrap)
    .align_content(MyFlexGravity_Center)
    .align_items(MyFlexGravity_Flex_End)
    .vert_space(10)
    .horz_space(10)
    .padding(UIEdgeInsetsMake(10, 10, 10, 10))
    .margin_top(50)
    .width(MyLayoutSize.fill)
    .height(MyLayoutSize.wrap)
    .addTo(self.view);
    
    
    UILabel *itemA = UILabel.new.flexItem
    .width(MyLayoutSize.fill)
    .height(30)
    .addTo(layout);
    
    UILabel *itemB = UILabel.new.flexItem
    .flex_grow(1)
    .align_self(MyFlexGravity_Flex_Start)
    .height(30)
    .addTo(layout);
    
    UILabel *itemC = UILabel.new.flexItem
    .flex_grow(1)
    .height(40)
    .addTo(layout);
    
    UILabel *itemD = UILabel.new.flexItem
    .flex_grow(1)
    .height(50)
    .addTo(layout);
    
    
    layout.backgroundColor = [UIColor grayColor];
    itemA.text = @"A";
    itemA.backgroundColor = [UIColor redColor];
    itemB.text = @"B";
    itemB.backgroundColor = [UIColor greenColor];
    itemC.text = @"C";
    itemC.backgroundColor = [UIColor blueColor];
    itemD.text = @"D";
    itemD.backgroundColor = [UIColor yellowColor];

}

@end
