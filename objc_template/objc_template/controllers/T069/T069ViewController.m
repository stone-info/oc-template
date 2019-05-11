//
//  T069ViewController.m
//  objc_template
//
//  Created by stone on 2019/04/05.
//  Copyright © 2019 stone. All rights reserved.
//

#import <AFNetworking/AFHTTPSessionManager.h>
#import "T069ViewController.h",
/*
 * https://www.jianshu.com/p/4ac9c4c25ea8
 *
 * 2、直接终端生成对应的cer证书
这个方式会跳过服务器端给的证书一步，因为很多时候你们都不清楚到底要哪个证书，也不知道哪里会出现错误。
直接看命令：

openssl s_client -connect www.baidu.com:443 </dev/null 2>/dev/null | openssl x509 -outform DER > https.cer
 *
 * */
// https://www.jianshu.com/p/4ac9c4c25ea8
// https://github.com/yuantiku/YTKNetwork/issues/424

@interface T069ViewController ()

@end

@implementation T069ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.
  [self entry];
}


// https ssl 验证函数

- (AFSecurityPolicy *)customSecurityPolicy {
  // 先导入证书 证书由服务端生成，具体由服务端人员操作
  NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"https" ofType:@"cer"];//证书的路径
  NSData   *cerData = [NSData dataWithContentsOfFile:cerPath];
  NSSet    *certSet = [NSSet setWithObject:cerData];

  // AFSSLPinningModeCertificate 使用证书验证模式
  AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:certSet];
  // allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO
  // 如果是需要验证自建证书，需要设置为YES
  securityPolicy.allowInvalidCertificates = YES;

  //validatesDomainName 是否需要验证域名，默认为YES;
  //假如证书的域名与你请求的域名不一致，需把该项设置为NO；如设成NO的话，即服务器使用其他可信任机构颁发的证书，也可以建立连接，这个非常危险，建议打开。
  //置为NO，主要用于这种情况：客户端请求的是子域名，而证书上的是另外一个域名。因为SSL证书上的域名是独立的，假如证书上注册的域名是www.google.com，那么mail.google.com是无法验证通过的；当然，有钱可以注册通配符的域名*.google.com，但这个还是比较贵的。
  //如置为NO，建议自己添加对应域名的校验逻辑。
  securityPolicy.validatesDomainName = NO;
  return securityPolicy;


  //     //https 公钥证书配置
  //
  //     NSString *certFilePath = [[NSBundle mainBundle] pathForResource:@"serverapple" ofType:@"cer"];
  //
  //     NSData *certData = [NSData dataWithContentsOfFile:certFilePath];
  //
  //     NSSet *certSet = [NSSet setWithObject:certData];
  //
  //     AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:certSet];
  //
  //     policy.allowInvalidCertificates = YES;
  //
  //     policy.validatesDomainName = NO;//是否校验证书上域名与请求域名一致
}

- (void)entry {

  // NSURL                *baseURL = [NSURL URLWithString:@"https://39.107.124.73"];
  NSURL                *baseURL = [NSURL URLWithString:@"https://vmei001.com"];
  AFHTTPSessionManager *manager = [[AFHTTPSessionManager manager] initWithBaseURL:baseURL];
  // 如果返回的数据既不是xml也不是json那么应该修改解析方案为[AFHTTPResponseSerializer serializer],
  // 返回的是什么就接收什么
  manager.responseSerializer                        = [AFHTTPResponseSerializer serializer];
  manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", @"text/xml", @"text/plain", nil];

  // [manager setSecurityPolicy:[self customSecurityPolicy]];

  //  问题 接口 : https://39.107.124.73/api/bd/indexData/middleCategory
  // http://jsonplaceholder.typicode.com/posts
  NSURLSessionDataTask *dataTask = [manager GET:@"api/bd/indexData/middleCategory" parameters:nil progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
    NSLog(@"sn.dataToString(responseObject) = %@", sn.dataToString(responseObject));
    NSLog(@"success %s", __func__);
  } failure:^(NSURLSessionDataTask *task, NSError *error) {
    NSLog(@"error = %@", error);
    NSLog(@"error %s", __func__);
  }];

  [dataTask resume];
}

- (void)injected {
  [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
  // [self.views removeAllObjects];
  // self.views = nil;
  [self entry];
}


@end
    