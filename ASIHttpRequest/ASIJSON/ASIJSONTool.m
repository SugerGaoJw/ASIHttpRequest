//
//  ASIJSONTool.m
//  ASIHttpRequest
//
//  Created by Suger on 15-7-22.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import "ASIJSONTool.h"

@implementation ASIJSONTool

+ (NSString *)toJSONString:(id)theObject {
    NSError *error = nil;
    NSData *jsonData =
    [NSJSONSerialization dataWithJSONObject:theObject
                                    options:NSJSONWritingPrettyPrinted
                                      error:&error];
    if ([jsonData length] > 0 && error == nil){
        NSString* jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        //        NSLog(@"[%s] , [%@]",__func__ , debug);
        return jsonStr;
    }else{
        NSLog(@"[%s] , [%@]",__func__ , @"to JSONString is Failed");
        return nil;
    }
}

+ (id)toJSONData:(NSData *)theData {
    
    @try {
        if (theData == nil || [theData isKindOfClass:[NSNull class]]) {
            NSLog(@"[%s] , [%@]",__func__ , @"to JSONData is Failed");
            return nil;
        }
        NSError *error = nil;
        NSString *ret = [[NSString alloc] initWithData:theData encoding:NSUTF8StringEncoding];
        NSLog(@"---> [debug] %@",ret);
        id jsonObject = [NSJSONSerialization JSONObjectWithData:theData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&error];
        
        if (![jsonObject isKindOfClass:[NSNull class]] &&
            jsonObject != nil &&
            error == nil){
            return jsonObject;
        }else{
            NSLog(@"[%s] , [%@]",__func__ , error);
            return nil;
        }
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    @finally {
        
    }
    
 
}

@end
