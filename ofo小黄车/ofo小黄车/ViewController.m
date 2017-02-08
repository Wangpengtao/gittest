//
//  ViewController.m
//  ofo小黄车
//
//  Created by 天蓝 on 2016/12/21.
//  Copyright © 2016年 PT. All rights reserved.
//

#import "ViewController.h"
#import "SaveRecordViewController.h"

@interface ViewController ()
@property (nonatomic, strong) UITextField *plateNumberTF;
@property (nonatomic, strong) UITextField *passwordTF;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"ofo小黄车";
    self.view.backgroundColor = kBackgroundColor;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存记录" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonItemTapAction)];
    
    
    [self createTextField];
    [self createButtonWithType:1];
    [self createButtonWithType:2];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

// 右侧历史记录按钮
- (void)rightButtonItemTapAction
{
    SaveRecordViewController *vc = [[SaveRecordViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 创建输入框

- (void)createTextField
{
    UIView *plateNumberView = [self createViewWithFrame:CGRectMake(0, 100, kScreenWidth, 40) type:1];
    UIView *passwordView = [self createViewWithFrame:CGRectMake(0, plateNumberView.maxY + 20, kScreenWidth, plateNumberView.height) type:2];
    
    [self.view addSubview:plateNumberView];
    [self.view addSubview:passwordView];
}

- (UIView *)createViewWithFrame:(CGRect)frame type:(NSInteger)type
{
    UIView *view = [[UIView alloc] initWithFrame:frame];
    
    UILabel *label = [[UILabel alloc] init];
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.width.mas_equalTo(80);
        make.left.top.bottom.mas_equalTo(0);
    }];
    
    
    UITextField *textField = [[UITextField alloc] init];
    textField.font = [UIFont systemFontOfSize:14];
    textField.layer.borderWidth = 1.0;
    textField.layer.cornerRadius = 3.0;
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [textField setValue:[NSNumber numberWithInt:8] forKey:@"paddingLeft"];
    textField.layer.borderColor = [UIColor colorWithRed:0.20f green:0.80f blue:0.80f alpha:1.00f].CGColor;
    [view addSubview:textField];
    [textField mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.height.mas_equalTo(36);
        make.right.mas_equalTo(-40);
        make.left.mas_equalTo(label.mas_right);
        make.centerY.mas_equalTo(label.mas_centerY);
    }];
    
    if (type == 1)
    {// 车牌
        label.text = @"车  牌 :";
        textField.placeholder = @"请输入车牌号";
        self.plateNumberTF = textField;
    }else if (type == 2)
    {// 密码
        label.text = @"密  码 :";
        textField.placeholder = @"请输入密码";
        self.passwordTF = textField;
    }
    return view;
}

#pragma mark - 查询,保存按钮

- (void)createButtonWithType:(NSInteger)type
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont systemFontOfSize:14];
    button.layer.borderWidth = 1.0;
    button.layer.cornerRadius = 3.0;
    button.layer.borderColor = [UIColor colorWithRed:0.20f green:0.80f blue:0.80f alpha:1.00f].CGColor;
    [button setTitleColor:[UIColor colorWithRed:0.20f green:0.80f blue:0.80f alpha:1.00f] forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    if (type == 1)
    {// 查询
        [button setTitle:@"查询" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(20);
            make.height.mas_equalTo(40);
            make.right.mas_equalTo(-(kScreenWidth/2 + 10));
            make.top.mas_equalTo(self.passwordTF.mas_bottom).offset(60);
        }];
    }else if(type == 2)
    {// 保存
        [button setTitle:@"保存" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(saveAction:) forControlEvents:UIControlEventTouchUpInside];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(-20);
            make.height.mas_equalTo(40);
            make.left.mas_equalTo(kScreenWidth/2 + 10);
            make.top.mas_equalTo(self.passwordTF.mas_bottom).offset(60);
        }];
    }
}

// 搜索
- (void)searchAction:(UIButton *)sender
{
    [self.view endEditing:YES];
}

// 保存
- (void)saveAction:(UIButton *)sender
{
    [self.view endEditing:YES];
}
@end
