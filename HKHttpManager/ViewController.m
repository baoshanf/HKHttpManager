//
//  ViewController.m
//  HKHttpManager
//
//  Created by hans on 2018/1/4.
//  Copyright © 2018年 hans. All rights reserved.
//

#import "ViewController.h"
#import "HKHttpManager.h"
#import "HKHttpRequest.h"
#import "HKHttpResponse.h"
#import "HKHttpConfigure.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [HKHttpConfigure shareInstance].generalServer = @"https://www.apiopen.top/";
    HKHttpRequest *request = [[HKHttpRequest alloc] init];
    request.requestURL = @"satinApi";
    request.normalParams = @{@"type":@"1",
                             @"page":@"1"
                             };
    request.requestMethod = HKHttpRequestTypeGet;
    [[HKHttpManager shareManager] sendRequest:request complete:^(HKHttpResponse * _Nullable response) {
        NSLog(@"%@",response.content);
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
