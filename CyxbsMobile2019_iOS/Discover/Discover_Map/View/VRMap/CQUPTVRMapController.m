//
//  CQUPTVRMapController.m
//  CyxbsMobile2019_iOS
//
//  Created by 方昱恒 on 2020/8/28.
//  Copyright © 2020 Redrock. All rights reserved.
//

#import "CQUPTVRMapController.h"
#import <WebKit/WebKit.h>

@interface CQUPTVRMapController ()

@end

@implementation CQUPTVRMapController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    WKWebViewConfiguration *webConfiguration = [WKWebViewConfiguration new];
    WKWebView *mapView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds configuration:webConfiguration];
    NSString *urlStr = @"http://720yun.com/t/0e929mp6utn?pano_id=473004";
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [mapView loadRequest:request];
    
    [self.view addSubview:mapView];
}


@end
