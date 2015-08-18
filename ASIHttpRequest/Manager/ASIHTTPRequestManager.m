//
//  ASIHTTPRequestManager.m
//  ASIHTTPRequestPoject
//
//  Created by Suger on 15-7-18.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import "ASIHTTPRequestManager.h"


//static ASIHTTPRequestManager* _asiHttpRequestManager = nil;
@implementation ASIHTTPRequestManager
- (void)dealloc {
    NSLog(@" [%s]----> %@",__func__ ,self);
}
- (id)init {
    self = [super init];
    if (self) {
        
        NSLog(@" [%s]----> %@",__func__ ,self);
    }
    return self;
}

/*
 - (void)user_pic_modifyWithUrl:(NSURL*)url
 Param:(NSDictionary *)params
 Block:(ASIRequestComplete)block
 {
 
 NSLog(@"_%s %@",__func__, url);
 
 NSString* imageFormat = [params objectForKey:@"format"];
 NSAssert(imageFormat == nil ||
 (![imageFormat isEqualToString:@"jpg"] ||
 ![imageFormat isEqualToString:@"png"] ), @"we don't image format !!, suport jpg or png ");
 
 
 
 
 //分界线的标识符
 NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
 
 
 //根据url初始化request
 NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:url
 cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
 timeoutInterval:10];
 
 
 
 
 //分界线 --AaB03x
 NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
 //结束符 AaB03x--
 NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
 //得到图片的data
 NSData* data = [params objectForKey:@"imageData"];
 //http body的字符串
 NSMutableString *body=[[NSMutableString alloc]init];
 //参数的集合的所有key的集合
 NSArray *keys= [params allKeys];
 
 //遍历keys
 for(int i=0;i<[keys count];i++)
 {
 //得到当前key
 NSString *key=[keys objectAtIndex:i];
 //如果key不是pic，说明value是字符类型，比如name：Boris
 if(![key isEqualToString:@"imageData"])
 {
 //添加分界线，换行
 [body appendFormat:@"%@\r\n",MPboundary];
 //添加字段名称，换2行
 [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
 //添加字段的值
 [body appendFormat:@"%@\r\n",[params objectForKey:key]];
 }
 }
 
 ////添加分界线，换行
 [body appendFormat:@"%@\r\n",MPboundary];
 //声明pic字段，文件名为iosUplaod. + imageFormat
 
 NSString* uploadImageName = [NSString stringWithFormat:@"iosUplaod.%@",imageFormat];
 NSString* picBody = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"uploadedfile\"; filename=\"%@\"\r\n",uploadImageName];
 [body appendString:picBody];
 //声明上传文件的格式
 
 NSString* picFormat = [NSString stringWithFormat:@"Content-Type: image/%@\r\n\r\n",imageFormat];
 [body appendString:picFormat];
 
 //声明结束符：--AaB03x--
 NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
 //声明myRequestData，用来放入http body
 NSMutableData *myRequestData=[NSMutableData data];
 //将body字符串转化为UTF8格式的二进制
 [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
 //将image的data加入
 [myRequestData appendData:data];
 //加入结束符--AaB03x--
 [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
 
 //设置HTTPHeader中Content-Type的值
 NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
 //设置HTTPHeader
 [request setValue:content forHTTPHeaderField:@"Content-Type"];
 //设置Content-Length
 [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
 //设置http body
 [request setHTTPBody:myRequestData];
 //http method
 [request setHTTPMethod:@"POST"];
 
 //建立连接，设置代理
 //    conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
 //    [conn start];
 //    [conn se]
 //获取一个主队列
 NSOperationQueue *queue=[NSOperationQueue mainQueue];
 [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
 if (connectionError) {
 [self blockCompleteObj:nil ErrorMsg:@"网络异常" Error:connectionError];
 }else{
 NSDictionary *dict=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
 NSLog(@"%@",dict);
 NSDictionary* status = [dict objectForKey:@"status"];
 NSNumber* suc =[status objectForKey:@"succeed"];
 if (suc == nil || [suc intValue] != 1) {
 //上传失败
 [self blockCompleteObj:nil ErrorMsg:@"上传有误，请稍后再试！" Error:connectionError];
 }else{
 //上传成功
 [self blockCompleteObj:dict ErrorMsg:nil Error:nil];
 }
 }
 
 }];
 
 }
 */
-(ASIHTTPRequest *)asiImagePostUrl:(NSURL *)url
                              flag:(NSString *)flag
                   UrlForImageBody:(NSData *)imageBody
                             Block:(ASIRequestComplete)block {
    NSLog(@"%s uploadImage --> url:%@ flag:%@ image:%@",__func__,url,flag,imageBody);
    ASIFormDataRequest *uploadImageRequest= [ ASIFormDataRequest requestWithURL:url];
    
    [uploadImageRequest setStringEncoding:NSUTF8StringEncoding];
    [uploadImageRequest setRequestMethod:@"POST"];
    [uploadImageRequest setPostFormat:ASIMultipartFormDataPostFormat];
    //    NSLog(@"图片大小+++++%u",[imageBody length]/1024);
    
    [uploadImageRequest setPostValue:@"IOS APP" forKey:@"photoDescribe"];
    [uploadImageRequest setPostValue:flag forKey:@"uid"];
    
    [uploadImageRequest addData:imageBody withFileName:@"uploadedfile.jpg" andContentType:@"image/jpg" forKey:@"uploadedfile"];
    
    [uploadImageRequest setDelegate:self];
    [uploadImageRequest startAsynchronous];
    return uploadImageRequest;
    
}






-(ASIHTTPRequest *)asiRequestPostUrl:(NSURL *)url
                     UrlForImageBody:(NSData *)imageBody
                               Block:(ASIRequestComplete)block {
    _isRequestComplete = NO;
    _blockRequestComplete = block;
    
    
    
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:url];
    [request setPostValue:imageBody forKey:@""];
    [request setDelegate:self];
    [request startAsynchronous];
    _asiHttpRequest = request;
    return request;
    
}


-(ASIHTTPRequest *)asiRequestPostUrl:(NSURL *)url
                      UrlForPostBody:(NSDictionary *)postBody
                               Block:(ASIRequestComplete)block {
    _isRequestComplete = NO;
    _blockRequestComplete = block;
    
    [[NSOperationQueue mainQueue]addOperationWithBlock:^{
        
        //    /*!
        //     *  nsstirng to jsonArray
        //     */
        NSString* json = [ASIJSONTool toJSONString:postBody];
        //-----------去掉 "[
        json = [json stringByReplacingOccurrencesOfString:@"\"[" withString:@"["];
        json = [json stringByReplacingOccurrencesOfString:@"]\"" withString:@"]"];
        //-----------去掉 ]"
        
        ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:url];
        [request setPostValue:json forKey:@"json"];
        [request setDelegate:self];
        [request startAsynchronous];
        
        
    }];
    //    _asiHttpRequest = request;
    //    return request;
    return nil;
    
}

-(void)asiQueueDataRequests:(NSArray * /*ASIFormDataRequest*/)asiFormDataRequests
                      Block:(ASIRequestComplete)block {
    NSError* err = nil;
    _isRequestComplete = NO;
    ASINetworkQueue* queue = [self getQueue];
    for (ASIFormDataRequest* request in asiFormDataRequests) {
        if (![request isKindOfClass:[ASIFormDataRequest class]]) {
            err =[NSError errorWithDomain:NSStringFromClass([ASIHTTPRequestManager class])
                                     code:0
                                 userInfo:@{@"errMsg":@"必须是ASIFormDataRequest类"}];
            [self blockCompleteObj:nil ErrorMsg:@"必须是ASIFormDataRequest类" Error:err];
            break ;
        }
        [request setDelegate:self];
        _asiHttpRequest = request;
        [queue addOperation:request];
    }
    
    if (err) return;
    [queue go];
    _blockRequestComplete = block;
    
    while (!_isRequestComplete) {
        [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.25]];
    }
    
}
#pragma mark - Cancel Request
- (void)asiCancelAllRequest {
    
    [[ASIHTTPRequest sharedQueue] cancelAllOperations];
}

- (void)asiCancelRequest:(ASIHTTPRequest *)request {
    if (request == nil || [request isKindOfClass:[NSNull class]]) {
        NSLog(@"[[%s] [ request is %@]",__func__, request);
        return;
    }
    NSOperationQueue* queue = [ASIHTTPRequest sharedQueue];
    NSArray* operations = queue.operations;
    ASIHTTPRequest* req = nil;
    for (req in operations) {
        if ([req isEqual:request]) {
            [req cancel];
            break;
        }
    }
}
#pragma mark - publice tool
- (void)setAsiHttpRequestArray:(NSMutableArray *)asiArray {
    _asiArray = asiArray;
}

#pragma mark - private tootl
- (void)blockCompleteObj:(id)obj
                ErrorMsg:(NSString *)errorMsg
                   Error:(NSError *)error {
    
    if (_blockRequestComplete) {
        _blockRequestComplete(obj,errorMsg,error);
    }
    [self resetASIHTTPRequestManager];
}

- (ASINetworkQueue *)getQueue {
    ASINetworkQueue *networkQueue = [ASINetworkQueue queue];
    [networkQueue setDelegate:self];
    [networkQueue setQueueDidFinishSelector:@selector(queueFinished:)];
    return networkQueue;
}
- (void)resetASIHTTPRequestManager {
    _isRequestComplete = YES;
    _blockRequestComplete = nil;
    [_asiArray removeObject:self];
    
}

#pragma mark - ASIHTTPRequestDelegate
- (void)queueFinished:(ASINetworkQueue *)queue{
    NSLog(@"[%s] [%@]",__func__,queue);
    [self resetASIHTTPRequestManager];
    
}
- (void)requestFailedCancellingOthers:(ASIHTTPRequest *)request {
    NSLog(@"[%s] [%@]",__func__,request);
    [self resetASIHTTPRequestManager];
    
}
- (void)requestFailed:(ASIHTTPRequest *)request {
    NSLog(@"[%s] [%@]",__func__,[request error]);
    NSError* error = [[request error] copy];
    [self blockCompleteObj:nil ErrorMsg:@"请求超时，请检查网络" Error:error];
}
- (void)requestStarted:(ASIHTTPRequest *)request {
    //    NSLog(@"[%s] [%@]",__func__,request);
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    @try {
        NSError* err = nil;
        id obj = [ASIJSONTool toJSONData:[request responseData] ];
        
        //parse respond object
        if (obj == nil || [obj isKindOfClass:[NSNull class]]) {
            err = [NSError errorWithDomain:NSStringFromClass([ASIHTTPRequestManager class])
                                      code:0
                                  userInfo:@{@"errMsg":@"请求返回错误"}];
        }
        
        //asiHttpRequest staue
        if (err != nil && ![err isKindOfClass:[NSNull class]]) {
            [self blockCompleteObj:nil ErrorMsg:@"请求返回错误" Error:err];
            return;
        }
        //parse respond statue
        _asiHttpRespStatus = [self asiParseRespStatues:obj];
        if ([_asiHttpRespStatus.error_desc isEqual:[NSNull class]] ) {
            err = [NSError errorWithDomain:NSStringFromClass([ASIHTTPRequestManager class])
                                      code:_asiHttpRespStatus.error_code
                                  userInfo:@{@"errMsg":_asiHttpRespStatus.error_desc}];
            [self blockCompleteObj:_asiHttpRespStatus ErrorMsg:@"未知异常，请稍后再试！" Error:err];
            return;
        }
        
        if (_asiHttpRespStatus.succeed == 0) {
            NSString* errstr = nil;
            if ([_asiHttpRespStatus.error_desc isEqual:[NSNull class]]) {
                errstr = @"未知异常，请稍后再试！";
            }else {
                errstr = _asiHttpRespStatus.error_desc;
            }
            
            [self blockCompleteObj:obj ErrorMsg:errstr Error:nil];
            return;
        }
        
        [self blockCompleteObj:obj ErrorMsg:nil Error:nil];
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    @finally {
        
    }
}

#pragma mark- JSON Help
- (ASIHttpRespStatus *)asiParseRespStatues:( id )respData {
    
    ASIHttpRespStatus* status  = [[ASIHttpRespStatus alloc]init];
    
    NSDictionary* dic = [respData objectForKey:@"status"];
    status.succeed = [[dic objectForKey:@"succeed"] integerValue];
    
    NSInteger code = 0;
    if ([[dic objectForKey:@"error_code"] isKindOfClass:[NSNull class]]) {
        code = 1 ;
    }else{
        code = [[dic objectForKey:@"error_code"] integerValue];
    }
    status.error_code =  code;
    
    NSString* err = [dic objectForKey:@"error_desc"];
    if ([err isKindOfClass:[NSNull class]]) {
        err =  @"未知异常 ";
    }
    status.error_desc =  (err == nil ? @"":err);
    
    return status;
}
@synthesize asiHttpRequest = _asiHttpRequest;
@synthesize blockRequestComplete = _blockRequestComplete;
@synthesize asiHttpRespStatus = _asiHttpRespStatus;
@end


@implementation ASIHttpRespStatus
@end
