//
//  HKHttpResponse.m
//  HKHttpManager
//
//  Created by hans on 2018/1/4.
//  Copyright © 2018年 hans. All rights reserved.
//

#import "HKHttpResponse.h"
#import "HKHttpConfigure.h"

@interface HKHttpResponse()

@property (nonatomic, copy, readwrite) NSData *rawData;
@property (nonatomic, assign, readwrite) HKHttpResponseStatus status;
@property (nonatomic, copy, readwrite) id content;
@property (nonatomic, assign, readwrite) NSInteger statueCode;
@property (nonatomic, assign, readwrite) NSInteger requestId;
@property (nonatomic, copy, readwrite) NSURLRequest *request;

@end

@implementation HKHttpResponse
- (nonnull instancetype)initWithRequestId:(nonnull NSNumber *)requestId
                                  request:(nonnull NSURLRequest *)request
                             responseData:(nullable NSData *)responseData
                                   status:(HKHttpResponseStatus)status{
    self = [super init];
    if (self)
    {
        self.requestId = [requestId unsignedIntegerValue];
        self.request = request;
        self.rawData = responseData;
        [self inspectionResponse:nil];
    }
    return self;
}
- (nonnull instancetype)initWithRequestId:(nonnull NSNumber *)requestId
                                  request:(nonnull NSURLRequest *)request
                             responseData:(nullable NSData *)responseData
                                    error:(nullable NSError *)error{
    self = [super init];
    if (self)
    {
        self.requestId = [requestId unsignedIntegerValue];
        self.request = request;
        self.rawData = responseData;
        [self inspectionResponse:error];
    }
    return self;
}

- (id)jsonWithData:(NSData *)data { return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:NULL]; }
#pragma mark - Private methods

- (void)inspectionResponse:(NSError *)error
{
    if (error)
    {
        self.status = HKHttpResponseStatusError;
        self.content = @"网络异常，请稍后再试";
        self.statueCode = error.code;
        return;
    }
    
    if (self.rawData.length > 0)
    {
        NSDictionary *dic = [self jsonWithData:self.rawData];
        BOOL result = NO;
        if ([dic[@"code"] isMemberOfClass:[NSString class]]) {
            result = [dic[@"code"] isEqualToString:[HKHttpConfigure shareInstance].respondeSuccessCode];
        }else if ([dic[@"code"] isMemberOfClass:[NSNumber class]]){
            result = [dic[@"code"] integerValue] == [[HKHttpConfigure shareInstance].respondeSuccessCode integerValue];
        }
        
        if (result)
        {
            self.status = HKHttpResponseStatusSuccess;
            self.content = [self processCotnentValue:dic];
            NSString *code = dic[@"code"];
            if (code && [code isKindOfClass:[NSString class]]) {
                self.statueCode = ((NSString*)code).integerValue;
            }
        }
        else
        {
            self.status = HKHttpResponseStatusError;
            self.content = dic[@"msg"];
            NSString *code = dic[@"code"];
            if (code && [code isKindOfClass:[NSString class]]) {
                self.statueCode = ((NSString*)code).integerValue;
            }
            if (![self.content isKindOfClass:[NSString class]]) {
                self.content = @"未知错误";
            }
        }
    }
    else
    {
        self.statueCode = NSURLErrorUnknown;
        self.status = HKHttpResponseStatusError;
        self.content = @"未知错误";
    }
    
}

 /**
  临时 返回数据处理
  */

- (id)processCotnentValue:(id)content
{
    if ([content isKindOfClass:[NSDictionary class]])
    {
        NSMutableDictionary *contentDict = ((NSDictionary *)content).mutableCopy;
        [contentDict removeObjectForKey:@"result"];
        //        [contentDict removeObjectForKey:@"msg"];
        
        if ([contentDict[@"data"] isKindOfClass:[NSNull class]])
        {
            [contentDict removeObjectForKey:@"data"];
        }
        
        return contentDict.copy;
    }
    return content;
}
@end
