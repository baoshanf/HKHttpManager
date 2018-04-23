//
//  HKHttpChainRequest.h
//  HKHttpManager
//
//  Created by hans on 2018/4/9.
//  Copyright © 2018年 hans. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HKHttpConstant.h"

@class HKHttpRequest, HKHttpResponse;
@interface HKHttpChainRequest : NSObject

@property (nonatomic, copy, readonly) NSString *identifier;
@property (nonatomic, strong, readonly) HKHttpRequest *runningRequest;

- (HKHttpChainRequest *)onFirst:(HKRequestConfigBlock)firstBlock;
- (HKHttpChainRequest *)onFirstReqeust:(HKHttpRequest *)request UNAVAILABLE_ATTRIBUTE;

- (HKHttpChainRequest *)onNext:(HKNextBlock)nextBlock;
- (HKHttpChainRequest *)onNextReqeust:(HKHttpRequest *)request UNAVAILABLE_ATTRIBUTE;

- (BOOL)onFinishedOneRequest:(HKHttpRequest *)request response:(nullable HKHttpResponse *)responseObject;
@end
