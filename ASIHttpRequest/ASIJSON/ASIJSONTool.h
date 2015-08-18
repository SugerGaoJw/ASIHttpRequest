//
//  ASIJSONTool.h
//  ASIHttpRequest
//
//  Created by Suger on 15-7-22.
//  Copyright (c) 2015年 NewLandPay. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ASIJSONTool : NSObject

+ (NSString *)toJSONString:(id)theObject;

+ (id)toJSONData:(NSData *)theData;
@end
