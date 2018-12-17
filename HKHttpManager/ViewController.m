//
//  ViewController.m
//  HKHttpManager
//
//  Created by hans on 2018/1/4.
//  Copyright © 2018年 hans. All rights reserved.
//

#import "ViewController.h"
#import "HKHttpManagerHeader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [HKHttpConfigure shareInstance].generalServer = @"https://www.apiopen.top/";
//    [self sendBasicRequest];
    [self sendChainRequest];
    [self sendGroupRequest];
    [HKHttpConfigure shareInstance].enableDebug = YES;
}

/**
 基础请求
 */
- (void)sendBasicRequest{
        HKHttpRequest *request = [[HKHttpRequest alloc] init];
        request.requestURL = @"satinApi";
//        request.normalParams = @{@"type":@"1",
//                                 @"page":@"1"
//                                 };
    [[HKHttpManager shareManager] sendRequest:request complete:^(HKHttpResponse * _Nullable response) {
        
    }];
        request.requestMethod = HKHttpRequestTypeGet;
        [[HKHttpManager shareManager] sendRequest:request complete:^(HKHttpResponse * _Nullable response) {
            NSLog(@"%@",response.content);
        }];
        [[HKHttpManager shareManager] sendRequestWithConfigBlock:^(HKHttpRequest * _Nullable request) {
            request.requestURL = @"satinApi";
            request.normalParams = @{@"type":@"1",
                                     @"page":@"1"
                                     };
            request.requestMethod = HKHttpRequestTypeGet;
        } complete:^(HKHttpResponse * _Nullable response) {
            if (response.status == HKHttpResponseStatusSuccess) {
                NSLog(@"%@",response.content);
            }
        }];
}
/**
 队列请求
 */
- (void)sendChainRequest{
    [[HKHttpManager shareManager] sendChainRequest:^(HKHttpChainRequest * _Nullable chainRequest) {
        [chainRequest onFirst:^(HKHttpRequest * _Nullable request) {
            request.requestURL = @"satinApi";
            request.normalParams = @{@"type":@"1",
                                     @"page":@"1"
                                     };
            request.requestMethod = HKHttpRequestTypeGet;
        }];
        [chainRequest onNext:^(HKHttpRequest * _Nullable request, HKHttpResponse * _Nullable responseObject, BOOL * _Nullable isSent) {
            request.requestURL = @"satinApi";
            request.normalParams = @{@"type":@"1",
                                     @"page":@"2"
                                     };
            request.requestMethod = HKHttpRequestTypeGet;
        }];
        [chainRequest onNext:^(HKHttpRequest * _Nullable request, HKHttpResponse * _Nullable responseObject, BOOL * _Nullable isSent) {
            request.requestURL = @"satinApi";
            request.normalParams = @{@"type":@"1",
                                     @"page":@"3"
                                     };
            request.requestMethod = HKHttpRequestTypeGet;
        }];
        
    } complete:^(NSArray<HKHttpResponse *> * _Nullable responseObjects, BOOL isSuccess) {
        
    }];
}
- (void)sendGroupRequest{
   
    [[HKHttpManager shareManager] sendGroupRequest:^(HKHttpGroupRequest * _Nullable groupRequest) {
        for (NSInteger i = 0; i < 5; i ++) {
            HKHttpRequest *request = [[HKHttpRequest alloc] init];
            request.requestURL = @"satinApi";
            request.normalParams = @{@"type":@"1",
                                     @"page":@"1"
                                     };
            request.requestMethod = HKHttpRequestTypeGet;
            [groupRequest addRequest:request];
        }
    } complete:^(NSArray<HKHttpResponse *> * _Nullable responseObjects, BOOL isSuccess) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
