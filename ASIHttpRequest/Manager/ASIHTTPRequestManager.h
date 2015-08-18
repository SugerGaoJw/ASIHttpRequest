//
//  ASIHTTPRequestManager.h
//  ASIHTTPRequestPoject
//
//  Created by Suger on 15-7-18.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import <ASIHttpRequest/ASINetworkQueue.h>
#import <ASIHttpRequest/ASIFormDataRequest.h>
#import "MJExtension.h"
#import "ASIJSONTool.h"

//日志开关
//#define  NSLog(...)

//请求返回状态
@interface ASIHttpRespStatus : NSObject
@property (assign,nonatomic) NSInteger succeed;
@property (assign,nonatomic) NSInteger error_code;
@property (copy,nonatomic)   NSString* error_desc;
@end



typedef void(^ASIRequestComplete)(id reObj , NSString* errorMsg ,NSError *error);

@interface ASIHTTPRequestManager : NSObject <ASIHTTPRequestDelegate>{
    BOOL _isRequestComplete;
    __weak NSMutableArray* _asiArray;
}
//respond status entity
@property (nonatomic , strong , readonly)ASIHttpRespStatus* asiHttpRespStatus;
@property (nonatomic, strong , readonly) ASIRequestComplete blockRequestComplete;
@property (nonatomic, weak , readonly) ASIHTTPRequest* asiHttpRequest;
////share instance
//+(ASIHTTPRequestManager *)shareInstance;

- (void)setAsiHttpRequestArray:(NSMutableArray*)asiArray;
//request method

-(ASIHTTPRequest *)asiImagePostUrl:(NSURL *)url
                              flag:(NSString *)flag
                   UrlForImageBody:(NSData *)imageBody
                             Block:(ASIRequestComplete)block;

-(ASIHTTPRequest *)asiRequestPostUrl:(NSURL *)url
                      UrlForPostBody:(NSDictionary *)postBody
                               Block:(ASIRequestComplete)block;

-(void)asiQueueDataRequests:(NSArray * /*ASIFormDataRequest*/)asiFormDataRequests
                      Block:(ASIRequestComplete)block;

//cancel method
- (void)asiCancelAllRequest;
- (void)asiCancelRequest:(ASIHTTPRequest *)request;
@end
