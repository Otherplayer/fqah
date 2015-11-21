//
//  FQAHNetworking.m
//  fqah
//
//  Created by __无邪_ on 15/11/21.
//  Copyright © 2015年 __无邪_. All rights reserved.
//

#import "FQAHNetworking.h"
#import "FQAHURLResponse.h"
#import "FQAHLogger.h"

#import "FQAHCache.h"
#import "FQAHDiskCache.h"

NSString *const kIMGKey = @"kIMGKey";


@interface FQAHNetworking ()
@property (nonatomic, strong)FQAHCache *cache;
@property (nonatomic, strong)NSMutableDictionary *dispatchList; //请求列表
@property (nonatomic, strong)FQAHNetworking *shareManager;
@end

@implementation FQAHNetworking
+ (instancetype)sharedNetwork {
    static FQAHNetworking *shareManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager =[FQAHNetworking manager];
        dispatch_queue_t requestQueue = dispatch_queue_create("com.example.MyQueue", NULL);
        shareManager.completionQueue = requestQueue;
        
        shareManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/xml", @"application/json", @"text/xml", @"text/json", @"text/html",nil];
        /*@"application/xml", @"text/xml", @"application/json", @"text/json", @"text/html",@"text/javascript", @"image/jpeg";*/
        
        //设置安全请求类型
        AFSecurityPolicy * securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeNone];
        //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
        //如果是需要验证自建证书，需要设置为YES
        securityPolicy.allowInvalidCertificates = YES;
        /*******************************************************************
         //validatesDomainName 是否需要验证域名，默认为YES；
         //假如证书的域名与你请求的域名不一致，需把该项设置为NO
         //主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
         securityPolicy.validatesDomainName = NO;
         //validatesCertificateChain 是否验证整个证书链，默认为YES
         //设置为YES，会将服务器返回的Trust Object上的证书链与本地导入的证书进行对比，这就意味着，假如你的证书链是这样的：
         //GeoTrust Global CA
         //    Google Internet Authority G2
         //        *.google.com
         //那么，除了导入*.google.com之外，还需要导入证书链上所有的CA证书（GeoTrust Global CA, Google Internet Authority G2）；
         //如是自建证书的时候，可以设置为YES，增强安全性；假如是信任的CA所签发的证书，则建议关闭该验证；
         securityPolicy.validatesCertificateChain = NO;
         *******************************************************************/
        shareManager.securityPolicy = securityPolicy;
        
        //设置超时时长
        [shareManager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
        shareManager.requestSerializer.timeoutInterval = kFQAHNetworkTimeoutInterval;
        [shareManager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
        
        
        ///--
        
        
    });
    return shareManager;
}

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - getter and setter

- (NSMutableDictionary *)dispatchList{
    if (_dispatchList == nil) {
        _dispatchList = [[NSMutableDictionary alloc] init];
    }
    return _dispatchList;
}

- (FQAHCache *)cache{
    if (_cache == nil) {
        _cache = [FQAHCache sharedInstance];
    }
    return _cache;
}

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark
#pragma mark - Base Network Public Methods

////网络请求,请勿改动

- (void)POST:(NSString *)URLString params:(id)parameters memoryCache:(BOOL)memoryCache diskCache:(BOOL)diskCache completed:(FQAHRequestCallbackBlock)completed isNotReachable:(FQAHNetNotReachabilityBlock)notRBlock{
    
    if ([self shouldLoadDataFromCache:URLString params:parameters memoryCache:memoryCache diskCache:diskCache completed:completed]) {
        return;
    }
    
    if ([self isNOTReachable]) {notRBlock();return;}
    
    [[FQAHNetworking sharedNetwork] POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self isSuccessedOnCallingAPIOperation:operation object:responseObject url:URLString params:parameters memoryCache:memoryCache diskCache:diskCache completedHandler:completed];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self isFailedOnCallingAPIOperation:operation withError:error completedHandler:completed];
        
    }];
}


- (void)POST:(NSString *)URLString params:(id)parameters images:(NSArray *)images imageSConfig:(NSString *)serviceName completed:(FQAHRequestCallbackBlock)completed isNotReachable:(FQAHNetNotReachabilityBlock)notRBlock{
    
    if ([self isNOTReachable]) {notRBlock();return;}
    
    [[FQAHNetworking sharedNetwork] POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (int i = 0; i < images.count; i++) {
            UIImage *image = [[images objectAtIndex:i] objectForKey:kIMGKey];
            NSString *fileName = [[[NSDate date] description] stringByAppendingString:[NSString stringWithFormat:@"%d",i]];
            NSData *imageData = UIImageJPEGRepresentation(image, 0.35);
            [formData appendPartWithFileData:imageData name:serviceName fileName:fileName mimeType:@"image/jpeg"];
        }
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self isSuccessedOnCallingAPIOperationNoCache:operation withReObject:responseObject completedHandler:completed];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self isFailedOnCallingAPIOperation:operation withError:error completedHandler:completed];
        
    }];
}


- (void)GET:(NSString *)URLString params:(id)parameters memoryCache:(BOOL)memoryCache diskCache:(BOOL)diskCache completed:(FQAHRequestCallbackBlock)completed isNotReachable:(FQAHNetNotReachabilityBlock)notRBlock{
    
    if ([self shouldLoadDataFromCache:URLString params:parameters memoryCache:memoryCache diskCache:diskCache completed:completed]) {
        return;
    }
    
    if ([self isNOTReachable]) {notRBlock();return;}
    
    [[FQAHNetworking sharedNetwork] GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        [self isSuccessedOnCallingAPIOperation:operation object:responseObject url:URLString params:parameters memoryCache:memoryCache diskCache:diskCache completedHandler:completed];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [self isFailedOnCallingAPIOperation:operation withError:error completedHandler:completed];
        
    }];
}

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark
#pragma mark -  统一数据处理 Private

////数据处理，请勿改动

- (void)handleResponse:(FQAHURLResponse *)response shouldCache:(BOOL)flag diskCache:(BOOL)diskCache completedHandler:(FQAHRequestCallbackBlock)completed{
    
    id fetchedRawData = nil;
    
    if (response.responseObject) {
        fetchedRawData = [response.responseObject copy];
    } else {
        fetchedRawData = [response.responseData copy];
    }
    
    if (flag && !response.isCache) {
        [self.cache saveCacheWithData:response.responseData URLStr:response.requestUrlStr params:response.requestParams];
    }
    
    if (diskCache && !response.isCache && !response.isDiskCache) {
        [[FQAHDiskCache sharedInstance] saveCacheWithData:response.responseData URLStr:response.requestUrlStr params:response.requestParams];
    }
    
    [FQAHLogger logDebugResponse:response];
    
    [self fetchData:fetchedRawData completedHandler:completed];
    
}


- (void)fetchData:(id)object completedHandler:(FQAHRequestCallbackBlock)completed{
    FQAHResponseErrCodeType reponseCode = [object[@"state_code"] intValue];
    
#ifdef SHOULD_USE_JSONMODEL
    NSError *jsonModelError = nil;
    BaseModel *baseModel = [[BaseModel alloc] initWithDictionary:object error:&jsonModelError];
    if (jsonModelError) {
        NSLog(@"*************************数据解析错误:%@********************************************",jsonModelError);
    }
    completed(reponseCode == FQAHURLResponseStatusSuccess, baseModel);
#else
    id resultData = object[@"data"];
    completed(reponseCode == FQAHServiceResponseErrCodeTypeNone, resultData);
#endif
    
    
}

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

- (BOOL)shouldLoadDataFromCache:(NSString *)URLString params:(id)parameters memoryCache:(BOOL)memoryCache diskCache:(BOOL)diskCache completed:(FQAHRequestCallbackBlock)completed{
    // 先检查一下是否需要从缓存中读数据
    if (memoryCache && [self hasCacheWithURLStr:URLString Params:parameters completedHandler:completed]) {
        return YES;
    }
    
    // 在网络未连接时是否需要从本地磁盘读数据
    BOOL isCannotReachable = ![FQAHReachability sharedInstance].isReachable;
    if (diskCache && isCannotReachable && [self hasDiskCacheWithURLStr:URLString Params:parameters completedHandler:completed]) {
        return YES;
    }
    return NO;
}


- (BOOL)hasCacheWithURLStr:(NSString *)urlStr Params:(NSDictionary *)params completedHandler:(FQAHRequestCallbackBlock)completed{
    
    NSData *result = [self.cache fetchCachedDataWithURLStr:urlStr params:params];
    
    if (result == nil) {
        return NO;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        FQAHURLResponse *response = [[FQAHURLResponse alloc] initWithMemoryData:result];
        response.requestParams = params;
        response.requestUrlStr = urlStr;
        [self handleResponse:response shouldCache:NO diskCache:YES completedHandler:completed];
    });
    
    return YES;
}

- (BOOL)hasDiskCacheWithURLStr:(NSString *)urlStr Params:(NSDictionary *)params completedHandler:(FQAHRequestCallbackBlock)completed{
    
    NSData *result = [[FQAHDiskCache sharedInstance] fetchCachedDataWithURLStr:urlStr params:params];
    
    if (result == nil) {
        return NO;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        FQAHURLResponse *response = [[FQAHURLResponse alloc] initWithDiskData:result];
        response.requestParams = params;
        response.requestUrlStr = urlStr;
        [self handleResponse:response shouldCache:NO diskCache:NO completedHandler:completed];
    });
    
    return YES;
}

////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////

- (void)isSuccessedOnCallingAPIOperation:(AFHTTPRequestOperation *)operation object:(id)object url:(NSString *)url params:(id)params memoryCache:(BOOL)memoryCache diskCache:(BOOL)diskCache completedHandler:(FQAHRequestCallbackBlock)completed{
    FQAHURLResponse *response = [[FQAHURLResponse alloc] initWithResponse:operation.response
                                                              request:operation.request
                                                       responseObject:object
                                                       responseString:operation.responseString
                                                         responseData:operation.responseData
                                                               status:FQAHURLResponseStatusSuccess];
    
    response.requestParams = params;
    response.requestUrlStr = url;
    
    [self handleResponse:response shouldCache:memoryCache diskCache:diskCache completedHandler:completed];
}

- (void)isSuccessedOnCallingAPIOperationNoCache:(AFHTTPRequestOperation *)operation withReObject:(id)responseObject completedHandler:(FQAHRequestCallbackBlock)completed{
    
    [FQAHLogger logDebugOperation:operation];
    
    [self fetchData:responseObject completedHandler:completed];
}

- (void)isFailedOnCallingAPIOperation:(AFHTTPRequestOperation *)operation withError:(NSError *)error completedHandler:(FQAHRequestCallbackBlock)completed{
    
    [FQAHLogger logDebugOperation:operation];
    
    
    
#ifdef SHOULD_USE_JSONMODEL
    NSDate *now = [NSDate date];
    
    BaseModel *model = [[BaseModel alloc] init];
    model.desc = error.localizedDescription;
    model.time_stamp = [NSString stringWithFormat:@"%@",@(now.timeIntervalSinceReferenceDate)];
    
    if (error.code == NSURLErrorTimedOut) {
        model.state_code = FQAHURLResponseStatusErrorTimeout;
    }else{
        model.state_code = FQAHURLResponseStatusErrorNoNetwork;
    }
    
    completed(NO, model);
    
#else
    if (error.code == NSURLErrorTimedOut) {
        completed(NO, error.localizedDescription);
    }else{
        completed(NO, error.localizedDescription);
    }
#endif
    
}


#pragma mark - ISReachibility

- (BOOL)isNOTReachable{
    return ![FQAHReachability sharedInstance].isReachable;
}




@end
