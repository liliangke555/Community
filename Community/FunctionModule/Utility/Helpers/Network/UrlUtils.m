//
//  UrlUtils.m
//  IR_HowJoy_iphone
//
//  Created by gzdlw on 14-12-24.
//  Copyright (c) 2014年 gzdlw. All rights reserved.
//

#import "UrlUtils.h"
#import "Tools.h"
#import "UserTempData.h"

@implementation UrlUtils

/**
 * 服务器地址
 */
static NSString *serverAddress  = URL_SERVER_ADDRESS_TEST;
static NSString *serverPort     = URL_SERVER_PORT_TEST;

/**
 * 是否为调试模式
 */
static bool isDebug = YES;
/**
 * 服务器获得的SessionId
 */
static NSString *sessionId;

/**
 * 用于登陆的参数集合
 */
static NSMutableDictionary *loginDict;

/**
 * 用于登陆的URL
 */
static NSURL *loginUrl;

/*
 * 用于加密密码的key
*/
static NSString *aesKey;

/*
 *  设置服务器地址，端口
 *
 *  @param address 服务器地址
 *  @param port 服务器端口
 */
+ (void)setServerAddress:(NSString *)address andPort:(NSString *)port
{
    serverAddress = address;
    serverPort = port;
}

/**
 * 获得对象实例
 *
 *  @param pattern 服务器Servlet url pattern
 *  @result UrlUtils
 */
+ (instancetype)getInstanceWithUrlPattern:(NSString *)pattern
{
    
    UrlUtils *utils = [[UrlUtils alloc] init];
    utils.address = serverAddress;
    utils.port = serverPort;
    utils.urlPattern = pattern;
    utils.handle = nil;
    return utils;
}

/**
 * 获得对象实例
 *
 *  @param handle 与服务器交互的操作标识
 *  @result UrlUtils
 */
+ (instancetype)getInstanceWithHandle:(NSString *)handle
{
    UrlUtils *utils = [[UrlUtils alloc] init];
    utils.address = serverAddress;
    utils.port = serverPort;
    utils.urlPattern = URL_SERVLETURLPATTERNCLIENTRESPONSE;
    utils.handle = handle;
    return utils;
}

/**
 *  初始化对象
 *
 *  @param address 服务器地址
 *  @param port 服务器端口
 *  @param urlPattern 服务器Servlet url pattern
 *  @result UrlUtils
 */
+ (instancetype)getInstanceWithAddressAndUrlPattern:(NSString *)address port:(NSString *)port urlPattern:(NSString *)urlPattern {
    return [self getInstanceWithAddressAndHandle:address port:port urlPattern:urlPattern handle:nil];
}

/**
 *  初始化对象
 *
 *  @param address 服务器地址
 *  @param port 服务器端口
 *  @param urlPattern 服务器Servlet url pattern
 *  @param handle 与服务器交互的操作标识
 *  @result UrlUtils
 */
+ (instancetype)getInstanceWithAddressAndHandle:(NSString *)address port:(NSString *)port urlPattern:(NSString *)urlPattern handle:(NSString *)handle {
    UrlUtils *utils = [[UrlUtils alloc] init];
    utils.address = address;
    utils.port = port;
    utils.urlPattern = urlPattern;
    utils.handle = handle;
    return utils;
}

/**
 *  添加参数
 *
 *  @param param 参数名称
 *  @param value 参数值
 *  @result
 */
- (void)addParam:(NSString *)param value:(NSString *)value{
    if(self.paramDict == nil) {
        self.paramDict = [[NSMutableDictionary alloc] init];
    }
    if(value == nil) {
        return;
    }
    [self.paramDict setObject:value forKey:param];
}

/**
 *  获得服务器地址
 *
 *  @result NSURL
 */
- (NSString *)getHost {
    return [NSString stringWithFormat:@"https://%@:%@", self.address, self.port];
//    return [NSString stringWithFormat:@"http://%@:%@", self.address, self.port];
}

/**
 *  获得NSURL对象
 *
 *  @result NSURL
 */
- (NSURL *)getUrl {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@?", [self getHost], self.urlPattern];
    bool needFirstFlag = false;
    if(self.handle != nil) {
        urlStr = [urlStr stringByAppendingFormat:@"%@=%@", URL_HANDLE, self.handle];
        needFirstFlag = true;
    }
    // 构建url
    if (self.paramDict != nil && [self.paramDict count]>0) {
        for (NSString *param in self.paramDict) {
            NSString *value = [self.paramDict objectForKey:param];
            // 转换特殊字符
            value = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(nil, (CFStringRef)value, nil, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
            // 拼接
            if (needFirstFlag) {
                urlStr = [urlStr stringByAppendingFormat:@"&%@=%@", param, value];
            }else {
                urlStr = [urlStr stringByAppendingFormat:@"%@=%@", param, value];
                needFirstFlag = true;
            }
        }
    }
    //    NSLog(@"2urlStr__%@",urlStr);
    return [NSURL URLWithString:urlStr];
}

/*
 * 重新构造登录url
 */
- (NSURL *)getNewLoginUrl:(NSMutableDictionary *)dic {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@?", [self getHost], URL_HJAPP_NEW_LOGIN];
    bool needFirstFlag = false;
    if(self.handle != nil) {
        urlStr = [urlStr stringByAppendingFormat:@"%@=%@", URL_HANDLE, self.handle];
        needFirstFlag = true;
    }
    // 构建url
    if (dic != nil && [dic count]>0) {
        for (NSString *param in dic) {
            NSString *value = [dic objectForKey:param];
            // 转换特殊字符
            value = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(nil, (CFStringRef)value, nil, (CFStringRef)@"!*'();:@&=+$,/?%#[]", kCFStringEncodingUTF8));
            // 拼接
            if (needFirstFlag) {
                urlStr = [urlStr stringByAppendingFormat:@"&%@=%@", param, value];
            }else {
                urlStr = [urlStr stringByAppendingFormat:@"%@=%@", param, value];
                needFirstFlag = true;
            }
        }
    }
    return [NSURL URLWithString:urlStr];
}

/**
 *  连接任务，并上传文件(带回调)
 *
 *  @param filePath 上传的文件路径
 *  @block 回调
 *  @result NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)getUploadFileTaskByCompletionHandler:(NSString *)filePath completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler {
    // 执行自动登录
    return [self autoUserLoginTask:^(bool okFLag, NSData *nData, NSURLResponse *nResponse, NSError *nError) {
        if (!okFLag) {
            // 登录失败，将结果返给回调
            completionHandler(nData, nResponse, nError);
        }else {
            // 添加服务器默认文件上传标识
            //[self addParam:URL_PARAM_UPLOADFILE_ID value:URL_PARAM_UPLOADFILE_VALUE];
            
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[self getUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:URL_TIMEOUTINTERVAL];
            [request setHTTPShouldHandleCookies:YES];
            if(sessionId != nil) {
                [request addValue:sessionId forHTTPHeaderField:@"Cookie"];
            }
            // 数据分隔线
            NSString *BOUNDARY = @"---------------------------7da2137580612";
            // 请求方式
            request.HTTPMethod = @"POST";
            // 设置请求参数
            [request addValue:@"image/gif, image/jpeg, image/pjpeg, image/pjpeg, application/x-shockwave-flash, application/xaml+xml, application/vnd.ms-xpsdocument, application/x-ms-xbap, application/x-ms-application, application/vnd.ms-excel, application/vnd.ms-powerpoint, application/msword, */*" forHTTPHeaderField:@"Accept"];
            [request addValue:@"zh-CN" forHTTPHeaderField:@"Accept-Language"];
            [request addValue:@"connection" forHTTPHeaderField:@"keep-alive"];
            [request addValue:[self getHost] forHTTPHeaderField:@"Host"];
            
            NSString *contentType = [NSString stringWithFormat:@"multipart/form-data;charset=utf-8;boundary=%@", BOUNDARY];
            [request setValue:contentType forHTTPHeaderField:@"Content-Type"];
            
            // 将要传递的参数转换为请求体
            NSString *paramEntity = @"--";
            paramEntity = [paramEntity stringByAppendingString:BOUNDARY];
            paramEntity = [paramEntity stringByAppendingString:@"\r\n"];
            paramEntity = [paramEntity stringByAppendingString:@"Content-Disposition: form-data; name=\""];
            paramEntity = [paramEntity stringByAppendingString:URL_HANDLE];
            paramEntity = [paramEntity stringByAppendingString:@"\"\r\n\r\n"];
            //            paramEntity = [paramEntity stringByAppendingString:self.handle];
            paramEntity = [paramEntity stringByAppendingString:@"\r\n"];
            
            NSString *paramKey = nil;
            for (paramKey in self.paramDict) {
                paramEntity = [paramEntity stringByAppendingString:@"--"];
                paramEntity = [paramEntity stringByAppendingString:BOUNDARY];
                paramEntity = [paramEntity stringByAppendingString:@"\r\n"];
                paramEntity = [paramEntity stringByAppendingString:@"Content-Disposition: form-data; name=\""];
                paramEntity = [paramEntity stringByAppendingString:paramKey];
                paramEntity = [paramEntity stringByAppendingString:@"\"\r\n\r\n"];
                paramEntity = [paramEntity stringByAppendingString:[self.paramDict valueForKey:paramKey]];
                paramEntity = [paramEntity stringByAppendingString:@"\r\n"];
            }
            
            // 获取文件名
            NSArray *split = [filePath componentsSeparatedByString:@"/"];
            NSString *fileName = [split lastObject];
            // 构造文件实体数据
            NSString *fileEntity = @"--";
            fileEntity = [fileEntity stringByAppendingString:BOUNDARY];
            fileEntity = [fileEntity stringByAppendingString:@"\r\n"];
            fileEntity = [fileEntity stringByAppendingString:@"Content-Disposition: form-data;name=\""];
            fileEntity = [fileEntity stringByAppendingString:URL_PARAM_UPLOADFILE_VALUE];
            fileEntity = [fileEntity stringByAppendingString:@"\";filename=\""];
            fileEntity = [fileEntity stringByAppendingString:fileName];
            fileEntity = [fileEntity stringByAppendingString:@"\"\r\n"];
            fileEntity = [fileEntity stringByAppendingString:@"Content-Type: application/octet-stream\r\n\r\n"];
            
            // 获得文件NSData
            NSData *fileData = [NSData dataWithContentsOfFile:filePath];
            
            // 数据结束标志
            NSString *endline = [NSString stringWithFormat:@"\r\n--%@--\r\n", BOUNDARY];
            
            // 合并上传数据
            NSMutableData *uploadData = [[NSMutableData alloc] init];
            [uploadData appendData:[paramEntity dataUsingEncoding:NSUTF8StringEncoding]];
            [uploadData appendData:[fileEntity dataUsingEncoding:NSUTF8StringEncoding]];
            [uploadData appendData:fileData];
            [uploadData appendData:[endline dataUsingEncoding:NSUTF8StringEncoding]];
            
            // request.HTTPBody = uploadData;//可以使用dataTaskWithRequest替换uploadTaskWithRequest
            // 指定数据长度
            NSString *lengthStr = [NSString stringWithFormat:@"%@", @([uploadData length])];
            [request setValue:lengthStr forHTTPHeaderField:@"Content-Length"];
            
            NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
            NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
            
            NSURLSessionDataTask *dataTask = [session uploadTaskWithRequest:request fromData:uploadData completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                completionHandler(data, response, error);
            }];
            [dataTask resume];
        }
    }];
    
}

/**
 *  连接任务，并上传数据(带回调)
 *
 *  @param updateData 上传的字符串
 *  @block 回调
 *  @result NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)getUploadDataTaskByCompletionHandler:(id)uploadObj completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler {
    [self addParam:URL_PARAM_UPLOADOBJECT_ID value:URL_PARAM_UPLOADOBJECT_VALUE];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[self getUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:URL_UPLOAD_TIMEOUT_INTERVAL];
    [request setHTTPShouldHandleCookies:YES];
    if(sessionId != nil) {
        [request addValue:sessionId forHTTPHeaderField:@"Cookie"];
    }
    request.HTTPMethod = @"POST";
    [request addValue:@"text/json;charset=utf-8" forHTTPHeaderField:@"Content-type"];
    
    // 用Json封装
    JsonUitls *utils = [JsonUitls new];
    NSData *jsonData = [utils getJsonDataFromObj:uploadObj];
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *dataTask = [session uploadTaskWithRequest:request fromData:jsonData completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        if (error) {
            completionHandler(data, response, error);
            
        }else {
            NSError *jsonError = nil;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:&jsonError];
            if (jsonError) {
                completionHandler(data, response, error);
                return ;
            }
            JsonUitls *jsonUtils = [JsonUitls new];
            bool haveFlag = false;
            if (dict != nil) {
                haveFlag = [jsonUtils checkResultHaveCode:dict];
            }
            if(haveFlag) {
                NSInteger code = [(NSString *)[dict objectForKey:RESULT_NAME_CODE] integerValue];
                NSString *messsage = [dict objectForKey:RESULT_NAME_MESSAGE];
                if (code == 1069) {
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"MoreAcountLogin" object:messsage];
                } else {
                    completionHandler(data, response, error);
                }
                
            } else {
                completionHandler(data, response, error);
            }
        }
        
        
    }];
    return dataTask;
}

/**
 *  连接任务(自动登录)，并上传数据(带回调)
 *
 *  @param updateData 上传的字符串
 *  @block 回调
 *  @result NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)getUploadDataTaskByCompletionHandlerAndLogin:(id)uploadObj completionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler {
    // 执行自动登录
    return [self autoUserLoginTask:^(bool okFLag, NSData *nData, NSURLResponse *nResponse, NSError *nError) {
        if (!okFLag) {
            // 登录失败，将结果返给回调
            completionHandler(nData, nResponse, nError);
        }else {
            
            NSURLSessionDataTask *dataTask = [self getUploadDataTaskByCompletionHandler:uploadObj completionHandler:completionHandler];
            [dataTask resume];
        }
    }];
}

/**
 *  连接任务(带回调)
 *
 *  @block 回调
 *  @result NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)getDataTaskByCompletionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler {
    //2019-11-25
    if([self.urlPattern isEqualToString:URL_HJAPP_NEW_REGISTER] || [self.urlPattern isEqualToString:URL_HJAPP_NEW_FORGETPASSWORD]) {
        //判断是否是注册/忘记密码接口调用
        return [self getAesKey:^(bool okFLag, NSData *data, NSURLResponse *response, NSError *error) {
            if (!okFLag) {
                //获取失败
                completionHandler(data, response, error);
            }else {
                if ([[self.paramDict allKeys] containsObject:URL_PARAM_PASSWORD_BYFORGET]) {
                    //判断是否包含密码这个字段
                    [self.paramDict setObject:[Tools AES128Encrypt:[self.paramDict objectForKey:URL_PARAM_PASSWORD_BYFORGET] key:aesKey] forKey:URL_PARAM_PASSWORD_BYFORGET];
                }
                NSURLSessionDataTask *dataTask = [self getNewDataTaskByCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    completionHandler(data,response,error);
                }];
                [dataTask resume];
                
            }
        }];
        
    }else if ([self.urlPattern isEqualToString:URL_HJAPP_NEW_UPDATEPASSWORD]) {
        //修改密码接口调用
        return [self getAesKey:^(bool okFLag, NSData *data, NSURLResponse *response, NSError *error) {
            if (!okFLag) {
                //获取失败
                completionHandler(data, response, error);
            }else {
                if ([[self.paramDict allKeys] containsObject:URL_PARAM_NEW_OLDPASSWORD]) {
                    //判断是否包含密码这个字段
                    [self.paramDict setObject:[Tools AES128Encrypt:[self.paramDict objectForKey:URL_PARAM_NEW_OLDPASSWORD] key:aesKey] forKey:URL_PARAM_NEW_OLDPASSWORD];
                }
                if ([[self.paramDict allKeys] containsObject:URL_PARAM_NEW_NEWPASSWORD]) {
                    [self.paramDict setObject:[Tools AES128Encrypt:[self.paramDict objectForKey:URL_PARAM_NEW_NEWPASSWORD] key:aesKey] forKey:URL_PARAM_NEW_NEWPASSWORD];
                }
                
                NSURLSessionDataTask *dataTask = [self getNewDataTaskByCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    completionHandler(data,response,error);
                }];
                [dataTask resume];
            }
        }];
        
    }else {
        return [self getNewDataTaskByCompletionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            completionHandler(data,response,error);
        }];
    }
    
}

/**
 * 2019-11-25 修改注册忘记密码修改密码接口
 *  连接任务(带回调)
 *  @block 回调
 *  @result NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)getNewDataTaskByCompletionHandler:(void (^)(NSData *data, NSURLResponse *response, NSError *error))completionHandler {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[self getUrl] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:URL_TIMEOUTINTERVAL];
    [request setHTTPShouldHandleCookies:YES];
    request.HTTPMethod = @"POST";
    [request addValue:@"text/json;charset=utf-8" forHTTPHeaderField:@"Content-type"];
    if(sessionId != nil) {
//        NSLog(@"sessionID--%@",sessionId);
        [request addValue:sessionId forHTTPHeaderField:@"Cookie"];
    }
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    NSError *err;
                                                    if (data == nil) {
                                                        completionHandler(data, response, error);
                                                    }else{
                                                        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:&err];
                                                        
                                                        if (err) {
                                                            // NSLog(@"需要自动登录，但解析失败:%@",err);
                                                            completionHandler(data, response, error);
                                                            
                                                        }else {
                                                            JsonUitls *jsonUtils = [JsonUitls new];
                                                            bool haveFlag = false;
                                                            if (dict != nil) {
                                                                haveFlag = [jsonUtils checkResultHaveCode:dict];
                                                            }
                                                            if(haveFlag) {
                                                                int code = [(NSString *)[dict objectForKey:RESULT_NAME_CODE] intValue];
                                                                //2019-11-21 状态码返回200，直接成功，需保存sessionID
                                                                if(code == HTTP_STATUS_CODE_SCUESS){
                                                                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                                    NSDictionary *fields = [httpResponse allHeaderFields];
                                                                    NSString *cookie = [fields valueForKey:@"Set-Cookie"];
                                                                    // 从响应中获得session
                                                                    if(cookie != nil) {
                                                                        //将字符串中的，换成；
                                                                        if ([cookie containsString:@","]) {
                                                                            cookie = [cookie stringByReplacingOccurrencesOfString:@"," withString:@";"];
                                                                        }
                                                                        //将字符串分割
                                                                        NSArray *array = [cookie componentsSeparatedByString:@";"];
                                                                        NSMutableArray *cookieArray = [NSMutableArray new];
                                                                        for (NSString *cookieStr in array) {
                                                                            if ([cookieStr containsString:@"Path="] || [cookieStr containsString:@"Domain="] || [cookieStr containsString:@"Expires="] || [cookieStr containsString:@"GMT"] || [cookieStr containsString:@"UT"] || [cookieStr containsString:@"UTC"] || [cookieStr containsString:@"HttpOnly"] || [cookieStr containsString:@"Secure"]) {
                                                                                //包含这几个字符，则舍弃
                                                                            }else {
                                                                                //将name=zhangsan等保存
                                                                                [cookieArray addObject:cookieStr];
                                                                            }
                                                                        }
//                                                                        NSLog(@"=====cookieArray=%@",cookieArray);
                                                                        sessionId = [cookieArray componentsJoinedByString:@";"];
//                                                                        NSLog(@"======sessionId%@",sessionId);
                                                                        //更新session
                                                                        [[NSUserDefaults standardUserDefaults] setObject:cookieArray forKey:FullOfSession];
                                                                        [[NSUserDefaults standardUserDefaults] synchronize];
                                                                    }
                                                                    completionHandler(data, response, error);
                                                                }else if(code == RESPONSE_CODE_SESSION_OVER_CODE) {
                                                                    // 执行自动登录
                                                                    [[self autoUserLoginTask:^(bool okFLag, NSData *nData, NSURLResponse *nResponse, NSError *nError) {
                                                                        if (okFLag) {
                                                                            // 登录成功，重新发起请求
                                                                            [[self getDataTaskByCompletionHandler:completionHandler] resume];
                                                                        }else {
                                                                            // 登录失败，将结果返给回调
                                                                            completionHandler(nData, nResponse, nError);
                                                                        }
                                                                    }] resume];
                                                                } else if(code == Login_OUT_CODE) {
                                                                    NSString *messsage = [dict objectForKey:RESULT_NAME_MESSAGE];
                                                                    [[NSNotificationCenter defaultCenter] postNotificationName:@"MoreAcountLogin" object:messsage];
                                                                } else{
                                                                    completionHandler(data, response, error);
                                                                }
                                                                
                                                            }else{
                                                                completionHandler(data, response, error);
                                                            }
                                                        }
                                                        
                                                    }
                                                }];
    return dataTask;
}


/**
 *  登陆服务器(带回调)
 *
 *  @param loginUrl 登录链接
 *  @param loginParam 登录参数
 *  @block 回调
 *  @result NSURLSessionDataTask
 */
-(NSURLSessionDataTask *)loginServer:(NSURL *)url loginParam:(NSMutableDictionary *)loginParam loginHandler:(void (^)(bool okFLag, ResidentLoginVo
                                                                                                                      *user, NSString *errorMsg, NSData *data, NSURLResponse *response, NSError *error, NSInteger code))loginHandler {
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:URL_TIMEOUTINTERVAL];
    [request setHTTPShouldHandleCookies:YES];
    //2019.07.01添加post
    request.HTTPMethod = @"POST";
    [request addValue:@"text/json;charset=utf-8" forHTTPHeaderField:@"Content-type"];
    // 是否已获得session，如果获得就携带到请求中
    if(sessionId != nil) {
//        NSLog(@"sessionID--%@",sessionId);
        [request addValue:sessionId forHTTPHeaderField:@"Cookie"];
    }
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
                                                    // 是否登录成功
                                                    BOOL flag = NO;
                                                    ResidentLoginVo *user ;
                                                    NSString *errorMsg;
                                                    NSInteger code  = 0;
                                                    
                                                    NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
                                                    NSDictionary *fields = [httpResponse allHeaderFields];
                                                    NSString *cookie = [fields valueForKey:@"Set-Cookie"];
                                                    
                                                    // 从响应中获得session
                                                    if(cookie != nil) {
//                                                        sessionId = [cookie substringToIndex:[cookie rangeOfString:@";"].location];
                                                        //2019年8月13日网络中间键需传完整session;同时缓存session用于显示图片
                                                        //2019年9月20日修改session
                                                        /*"name=zhangsan;Path=/;Domain=tc.lookdoor.cn;Expires=Fri, 20-Sep-2019 07:38:37 GMT, hjAccessToken=afjaskj.sdhfja.ihjrnh;Path=/;Domain=tc.lookdoor.cn;Expires=Fri, 20-Sep-2019 07:38:37 GMT, SESSION=2a1bfac1-0fc1-4d1e-bfc1-e10bf8e18395;Path=/"*/
                                                        //将字符串中的，换成；
                                                        if ([cookie containsString:@","]) {
                                                            cookie = [cookie stringByReplacingOccurrencesOfString:@"," withString:@";"];
                                                        }
                                                        //将字符串分割
                                                        NSArray *array = [cookie componentsSeparatedByString:@";"];
                                                        NSMutableArray *cookieArray = [NSMutableArray new];
                                                        for (NSString *cookieStr in array) {
                                                            if ([cookieStr containsString:@"Path="] || [cookieStr containsString:@"Domain="] || [cookieStr containsString:@"Expires="] || [cookieStr containsString:@"GMT"] || [cookieStr containsString:@"UT"] || [cookieStr containsString:@"UTC"] || [cookieStr containsString:@"HttpOnly"] || [cookieStr containsString:@"Secure"]) {
                                                                //包含这几个字符，则舍弃
                                                            }else {
                                                                //将name=zhangsan等保存
                                                                [cookieArray addObject:cookieStr];
                                                            }
                                                        }
//                                                        NSLog(@"=====cookieArray=%@",cookieArray);
                                                        sessionId = [cookieArray componentsJoinedByString:@";"];
//                                                        NSLog(@"======sessionId%@",sessionId);
                                                        //更新session
                                                        [[NSUserDefaults standardUserDefaults] setObject:cookieArray forKey:FullOfSession];
                                                        [[NSUserDefaults standardUserDefaults] synchronize];
                                                    }
                                                    
                                                    if([httpResponse statusCode] == HTTP_STATUS_CODE_SCUESS) {
                                                        
                                                        NSString *result    = [StringUtils convertString:data];
                                                        NSDictionary *dic   = [Tools dictionaryWithJsonString:result];
                                                        
                                                        if ([[dic objectForKey:RESULT_NAME_CODE] integerValue] == HTTP_STATUS_CODE_SCUESS) {
                                                            flag        = YES;
                                                            loginUrl    = [url copy];
                                                            loginDict   = [loginParam mutableCopy];
                                                        }else{
                                                            if ([data length] > 0) {
                                                                errorMsg     = [dic objectForKey:RESULT_NAME_MESSAGE];
                                                            }else {
                                                                errorMsg     = [error localizedDescription];
                                                            }
                                                            code               = [[dic objectForKey:RESULT_NAME_CODE] integerValue];
                                                        }
//                                                        NSLog(@"utils--%@",loginUrl);
                                                        
                                                    }else {
                                                        
                                                        code        = 0;
                                                        errorMsg    = @"网络不给力，请重试";
                                                        
                                                    }
                                                    
                                                    loginHandler(flag, user, errorMsg, data, response, error, code);
                                                }];
    
    return dataTask;
}

/**
 *  会员登陆(带回调)
 *
 *  @block 回调
 *  @result NSURLSessionDataTask
 * 2019-11-21 添加NSData *data,
 */
- (NSURLSessionDataTask *)getUserLoginTask:(void (^)(bool okFLag, ResidentLoginVo *user, NSData *data, NSString *errorMsg, NSInteger code))loginHandler {
    //先获取key
    return [self getAesKey:^(bool okFLag, NSData *data, NSURLResponse *response, NSError *error) {
        if (!okFLag) {
            //获取失败
            ResidentLoginVo *user;
            loginHandler(okFLag, user, data, @"网络不给力，请重试" ,0);
        }else {
            [self paramDict];
            if ([[self.paramDict allKeys] containsObject:URL_PARAM_PASSWORD_BYFORGET]) {
                //判断是否包含密码这个字段
                [self.paramDict setObject:[Tools AES128Encrypt:[self.paramDict objectForKey:URL_PARAM_PASSWORD_BYFORGET] key:aesKey] forKey:URL_PARAM_PASSWORD_BYFORGET];
            }
            
            NSURLSessionDataTask *loginTask = [self loginServer:[self getUrl] loginParam:self.paramDict loginHandler:^(bool okFLag, ResidentLoginVo *user, NSString *errorMsg, NSData *data, NSURLResponse *response, NSError *error,NSInteger code) {
                loginHandler(okFLag, user, data, errorMsg ,code);
            }];
            [loginTask resume];
        }
    }];
}

/**
 *  执行自动会员登录（带回调）但前提是必须已经执行过登录
 *
 *  @block 回调
 */
-  (NSURLSessionDataTask *)autoUserLoginTask:(void (^)(bool okFLag, NSData *data, NSURLResponse *response, NSError *error))loginHandler {
    return [self getAesKey:^(bool okFLag, NSData *data, NSURLResponse *response, NSError *error) {
        if (!okFLag) {
            //获取失败
            loginHandler(okFLag, data, response, error);
        }else {
            if ([[loginDict allKeys] containsObject:URL_PARAM_PASSWORD_BYFORGET]) {
                //判断是否包含密码这个字段
                [loginDict setObject:@"" forKey:URL_PARAM_PASSWORD_BYFORGET];
                [loginDict setObject:[Tools AES128Encrypt:[[NSUserDefaults standardUserDefaults]objectForKey:UserPassword] key:aesKey] forKey:URL_PARAM_PASSWORD_BYFORGET];
            }
            
            NSURLSessionDataTask *loginTask = [self loginServer:[self getNewLoginUrl:loginDict] loginParam:loginDict loginHandler:^(bool okFLag, ResidentLoginVo *user, NSString *errorMsg, NSData *data, NSURLResponse *response, NSError *error, NSInteger code) {
                loginHandler(okFLag, data, response, error);
            }];
            [loginTask resume];
        }
    }];
}

/*
 * 获取Aeskey
 */
- (NSURLSessionDataTask *)getAesKey:(void (^)(bool okFLag, NSData *data, NSURLResponse *response, NSError *error))loginHandler {
    NSString *urlStr = [NSString stringWithFormat:@"%@%@?", [self getHost], URL_HJAPP_NEW_GETPASSWORDAESKEY];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:URL_TIMEOUTINTERVAL];
    [request setHTTPShouldHandleCookies:YES];
    //2019.07.01添加post
    request.HTTPMethod = @"POST";
    [request addValue:@"text/json;charset=utf-8" forHTTPHeaderField:@"Content-type"];
    // 是否已获得session，如果获得就携带到请求中
    if(sessionId != nil) {
//        NSLog(@"sessionID--%@",sessionId);
        [request addValue:sessionId forHTTPHeaderField:@"Cookie"];
    }
    
    NSURLSessionConfiguration *sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        BOOL flag = NO;
        NSString *errorMsg;
        NSInteger code  = 0;
        
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        NSDictionary *fields = [httpResponse allHeaderFields];
        NSString *cookie = [fields valueForKey:@"Set-Cookie"];
        
        // 从响应中获得session
        if(cookie != nil) {
            //将字符串中的，换成；
            if ([cookie containsString:@","]) {
                cookie = [cookie stringByReplacingOccurrencesOfString:@"," withString:@";"];
            }
            //将字符串分割
            NSArray *array = [cookie componentsSeparatedByString:@";"];
            NSMutableArray *cookieArray = [NSMutableArray new];
            for (NSString *cookieStr in array) {
                if ([cookieStr containsString:@"Path="] || [cookieStr containsString:@"Domain="] || [cookieStr containsString:@"Expires="] || [cookieStr containsString:@"GMT"] || [cookieStr containsString:@"UT"] || [cookieStr containsString:@"UTC"] || [cookieStr containsString:@"HttpOnly"] || [cookieStr containsString:@"Secure"]) {
                    //包含这几个字符，则舍弃
                }else {
                    //将name=zhangsan等保存
                    [cookieArray addObject:cookieStr];
                }
            }
//            NSLog(@"=====cookieArray=%@",cookieArray);
            sessionId = [cookieArray componentsJoinedByString:@";"];
//            NSLog(@"======sessionId%@",sessionId);
            //更新session
            [[NSUserDefaults standardUserDefaults] setObject:cookieArray forKey:FullOfSession];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        if([httpResponse statusCode] == HTTP_STATUS_CODE_SCUESS) {
            
            NSString *result = [StringUtils convertString:data];
            NSDictionary *dic = [Tools dictionaryWithJsonString:result];
            
            if ([[dic objectForKey:RESULT_NAME_CODE] integerValue] == HTTP_STATUS_CODE_SCUESS) {
                flag = YES;
                aesKey = [[dic objectForKey:RESULT_NAME_DATA] objectForKey:@"aesKey"];
//                NSLog(@"加密key=%@",aesKey);
            }else{
                if ([data length] > 0) {
                    errorMsg = [dic objectForKey:RESULT_NAME_MESSAGE];
                }else {
                    errorMsg = [error localizedDescription];
                }
                code = [[dic objectForKey:RESULT_NAME_CODE] integerValue];
            }
//            NSLog(@"utils--%@",urlStr);
            
        }else {
            code = 0;
            errorMsg = @"网络不给力，请重试";
        }
        loginHandler(flag, data, response, error);
    }];
    return dataTask;
}

#pragma mark ********************************** 适配HTTPS 对应NSURLSESSION 代理回调 ******************************

//只要请求的地址是HTTPS的, 就会调用这个代理方法
//challenge:质询
//NSURLAuthenticationMethodServerTrust:服务器信任
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler
{
    // 判断是否是信任服务器证书
    if(challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
        // 告诉服务器，客户端信任证书
        // 创建凭据对象
        NSURLCredential *credntial = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        // 通过completionHandler告诉服务器信任证书
        completionHandler(NSURLSessionAuthChallengeUseCredential,credntial);
    }
}

/**
 * 获取当前服务器地址
 */
+ (NSString *)getCurrentServerAddress{
    DevelopmentEnrivonmentEnum currentEnumType = (DevelopmentEnrivonmentEnum)[[[NSUserDefaults standardUserDefaults]objectForKey:DevelopEnrivonmentType]integerValue];
    if ([UserTempData sharedInstance].checkDebugEnvironment) {
        //调试模式已开
        if (currentEnumType == DevelopmentEnrivonmentEnumTest) {
            //测试
            return URL_SERVER_ADDRESS_TEST;
        }else{
            //开发
            return URL_SERVER_ADDRESS_PRODUCT;
        }
    }else{
        //非调试模式
        return URL_SERVER_ADDRESS_PRODUCT;
    }
}

/**
 * 获取当前服务器端口
 */
+ (NSString *)getCurrentServerPort{
    DevelopmentEnrivonmentEnum currentEnumType = (DevelopmentEnrivonmentEnum)[[[NSUserDefaults standardUserDefaults]objectForKey:DevelopEnrivonmentType]integerValue];
    if ([UserTempData sharedInstance].checkDebugEnvironment) {
        if (currentEnumType == DevelopmentEnrivonmentEnumTest) {
            //测试
            return URL_SERVER_PORT_TEST;
        }else{
            //开发
            return URL_SERVER_PORT_PRODUCT;
        }
    }else{
        //非调试模式
        return URL_SERVER_PORT_PRODUCT;
    }
}

@end
