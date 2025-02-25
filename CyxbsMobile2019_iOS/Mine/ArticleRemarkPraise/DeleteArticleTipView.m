//
//  DeleteArticleTipView.m
//  CyxbsMobile2019_iOS
//
//  Created by Stove on 2021/2/23.
//  Copyright © 2021 Redrock. All rights reserved.
//

#import "DeleteArticleTipView.h"

@interface DeleteArticleTipView ()

/// 弹窗
@property(nonatomic,strong)UIView *tipWindow;

@property(nonatomic,strong)UIButton *cancelBtn;

@property(nonatomic,strong)UIButton *sureBtn;

@property(nonatomic,strong)UIView *blackLine;

@property(nonatomic,strong)void(^sureBlock)(void) ;
@end

@implementation DeleteArticleTipView

- (instancetype)initWithDeleteBlock:(void (^)(void))block{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.5];
        [self mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(SCREEN_HEIGHT);
        }];
        self.sureBlock = block;
        UITapGestureRecognizer *TGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(cancelBtnClicked)];
        [self addGestureRecognizer:TGR];
        [self addTipWindow];
    }
    return self;
}

- (void)addTipWindow {
    UIView *view = [[UIView alloc] init];
    self.tipWindow = view;
    [self addSubview:view];
    
    view.layer.cornerRadius = 18;
    UITapGestureRecognizer *TGR = [[UITapGestureRecognizer alloc] init];
    [view addGestureRecognizer:TGR];
    
    //无色背景色
    if (@available(iOS 11.0, *)) {
        view.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#F7F8FB" alpha:1] darkColor:[UIColor colorWithHexString:@"#000101" alpha:1]];
    } else {
        view.backgroundColor = [UIColor colorWithRed:248/255.0 green:249/255.0 blue:252/255.0 alpha:1];
    }
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(0.1587*SCREEN_WIDTH);
        make.top.equalTo(self).offset(0.428*SCREEN_HEIGHT);
        make.width.mas_equalTo(0.6827*SCREEN_WIDTH);
        make.height.mas_equalTo(0.4174*SCREEN_WIDTH);
    }];
    [self addCancelBtn];
    [self addSureBtn];
    [self addBlackLine];
    [self addTitleLabel];
}

- (void)addTitleLabel {
    UILabel *label = [[UILabel alloc] init];
    self.titleLabel = label;
    [self.tipWindow addSubview:label];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tipWindow).offset(0.204*SCREEN_WIDTH);
        make.top.equalTo(self.tipWindow).offset(0.0773*SCREEN_WIDTH);
    }];
    
    label.text = @"确定删除此条动态吗?";
    
    if (@available(iOS 11.0, *)) {
        label.textColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#15315B" alpha:1] darkColor:[UIColor colorWithHexString:@"#F0F0F2" alpha:1]];
    } else {
        label.textColor = [UIColor colorWithRed:21/255.0 green:49/255.0 blue:91/255.0 alpha:1];
    }
    
    label.font = [UIFont fontWithName:PingFangSCMedium size:11*fontSizeScaleRate_SE];

}
- (void)addCancelBtn {
    UIButton *btn = [self getBtn];
    [self.tipWindow addSubview:btn];
    self.cancelBtn = btn;
    
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    
    if (@available(iOS 11.0, *)) {
        btn.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#C3D3ED" alpha:1] darkColor:[UIColor colorWithHexString:@"#5A5A5A" alpha:1]];
    } else {
        btn.backgroundColor = [UIColor colorWithRed:195/255.0 green:212/255.0 blue:238/255.0 alpha:1];
    }
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.tipWindow).offset(0.0693*SCREEN_WIDTH);
        make.bottom.equalTo(self.tipWindow).offset(-0.072*SCREEN_WIDTH);
    }];
    [btn addTarget:self action:@selector(cancelBtnClicked) forControlEvents:UIControlEventTouchUpInside];
}
- (void)addSureBtn {
    UIButton *btn = [self getBtn];
    self.sureBtn = btn;
    [self.tipWindow addSubview:btn];
    
    [btn setTitle:@"确定" forState:UIControlStateNormal];
    
    if (@available(iOS 11.0, *)) {
        btn.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#4943E3" alpha:1] darkColor:[UIColor colorWithHexString:@"#5555FF" alpha:1]];
    } else {
        btn.backgroundColor = [UIColor colorWithRed:74/255.0 green:67/255.0 blue:228/255.0 alpha:1];
    }
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.tipWindow).offset(-0.0693*SCREEN_WIDTH);
        make.bottom.equalTo(self.tipWindow).offset(-0.072*SCREEN_WIDTH);
    }];
    
    [btn addTarget:self action:@selector(sureBtnClicked) forControlEvents:UIControlEventTouchUpInside];
}


/// 添加 顶部条的底部黑线 的方法
- (void)addBlackLine{
    UIView *blackLine = [[UIView alloc] init];
    self.blackLine = blackLine;
    [self.tipWindow addSubview:blackLine];
    
    if (@available(iOS 11.0, *)) {
        blackLine.backgroundColor = [UIColor dm_colorWithLightColor:[UIColor colorWithHexString:@"#2C2C2C" alpha:0.2] darkColor:[UIColor colorWithHexString:@"#E6E6E6" alpha:0.4]];
    } else {
        blackLine.backgroundColor = [UIColor colorWithRed:45/255.0 green:45/255.0 blue:45/255.0 alpha:0.64];
    }
    [blackLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.tipWindow).offset(0.184*SCREEN_WIDTH);
        make.left.right.equalTo(self.tipWindow);
        make.height.mas_equalTo(0.5);
    }];
}
- (UIButton*)getBtn{
    UIButton *btn = [[UIButton alloc] init];
    
    btn.layer.cornerRadius = 0.04535*SCREEN_WIDTH;
    
    btn.titleLabel.font = [UIFont fontWithName:PingFangSCBold size:15];
    
    [btn.titleLabel setTextAlignment:NSTextAlignmentCenter];
    
    [btn setTitleColor:UIColor.whiteColor forState:UIControlStateNormal];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(0.2467*SCREEN_WIDTH);
        make.height.mas_equalTo(0.0907*SCREEN_WIDTH);
    }];
    
    return btn;
}

//MARK:-
- (void)cancelBtnClicked {
    [self removeFromSuperview];
}

- (void)sureBtnClicked {
    self.sureBlock();
    [self removeFromSuperview];
}

@end

