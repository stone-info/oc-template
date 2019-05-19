
//
//  T043ViewController.m
//  objc_template
//
//  Created by stone on 2019/04/05.
//  Copyright © 2019 stone. All rights reserved.
//

#import <YTKNetwork/YTKNetworkConfig.h>
#import "T043ViewController.h"
#import "RegisterApi.h"
#import "GetImageApi.h"
#import "GetUserInfoApi.h"
#import "YTKUrlArgumentsFilter.h"
#import "UploadImageApi.h"

#import <MBProgressHUD/MBProgressHUD.h>

#import <objc/runtime.h>// 导入运行时文件

@interface T043ViewController () <YTKRequestDelegate, YTKChainRequestDelegate, YTKRequestAccessory>

@property (weak, nonatomic) NSTimer *timer;

@property (strong, nonatomic) NSDictionary               *options;
@property (strong, nonatomic) NSMutableArray<SNButton *> *buttons;
@property (weak, nonatomic) MBProgressHUD                *hud;

@end

@implementation T043ViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event {
  [self.hud hideAnimated:YES];
}

///  Inform the accessory that the request is about to start.
///
///  @param request The corresponding request.
- (void)requestWillStart:(id)request {
  [self.timer invalidate];
  self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(dosomething:) userInfo:nil repeats:NO];
  [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
  //  NSLog(@"request class = %@", SN.getClassName(request));
  //  [self performSelector:@selector(dosomething:) withObject:nil afterDelay:2.0];
}

- (void)dosomething:(NSTimer *)timer {
  // timer.userInfo
  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
  self.hud                                  = hud;
  hud.backgroundView.userInteractionEnabled = NO;
}

///  Inform the accessory that the request is about to stop. This method is called
///  before executing `requestFinished` and `successCompletionBlock`.
///
///  @param request The corresponding request.
- (void)requestWillStop:(id)request {
  NSLog(@"%s", __func__);
  NSLog(@"self.hud = %@", self.hud);
  // [self.hud removeFromSuperview];
  //  [self.timer invalidate];
  //  [self.hud hideAnimated:YES];
}

///  Inform the accessory that the request has already stoped. This method is called
///  after executing `requestFinished` and `successCompletionBlock`.
///
///  @param request The corresponding request.
- (void)requestDidStop:(id)request {
  NSLog(@"%s", __func__);
  // [self.hud hideAnimated:YES afterDelay:3.f];
  NSLog(@"self.hud = %@", self.hud);
  // [self.hud removeFromSuperview];
  [self.timer invalidate];
  [self.hud hideAnimated:YES];
}

- (NSMutableArray<SNButton *> *)buttons {

  if (_buttons == nil) {
    _buttons = [NSMutableArray<SNButton *> array];
  }
  return _buttons;
}

- (NSDictionary *)options {

  /** _options lazy load */

  if (_options == nil) {
    _options = @{
      @"borderColor"     : HexRGBA(@"#CCCCCC", 1.0),
      @"borderWidth"     : @1,
      @"type"            : @(UIButtonTypeSystem),
      @"font"            : [UIFont fontWithName:@"PingFangSC-Regular" size:14],
      @"backgroundColor" : [UIColor whiteColor],
      @"titleColorNormal": UIColor.blackColor,
      @"masksToBounds"   : @YES,
      @"borderRadius"    : @4.f,
    };
  }
  return _options;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.

  YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
  config.baseUrl = @"http://localhost:7000";
  config.cdnUrl  = @"http://localhost:7000";

  NSString              *appVersion = [[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"];
  YTKUrlArgumentsFilter *urlFilter  = [YTKUrlArgumentsFilter filterWithArguments:@{@"version": appVersion}];
  [config addUrlFilter:urlFilter];

  [self makeButton01];
  [self makeButton02];
  [self makeButton03];
  [self makeButton04];
  [self makeButton05];
  [self makeButton06];
  [self makeButton07];

  SNButton *previousButton;

  for (NSUInteger i = 0; i < self.buttons.count; ++i) {
    SNButton *button = self.buttons[i];
    [self.view addSubview:button];

    if (i == 0) {
      kMasKey(button);
      [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(10);
        make.left.offset(20);
        make.right.offset(-20);
        make.height.mas_equalTo(30);
      }];
    } else {
      kMasKey(button);
      [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(previousButton.mas_bottom).offset(10);
        make.left.offset(20);
        make.right.offset(-20);
        make.height.mas_equalTo(30);
      }];
    }
    previousButton = button;
  }
}

- (void)loadCacheData {

  NSString *userId = @"1";

  GetUserInfoApi *api = [[GetUserInfoApi alloc] initWithUserId:userId];

  if ([api loadCacheWithError:nil]) {

    NSDictionary *json = [api responseJSONObject];
    NSLog(@"json = %@", json);
    // show cached data
  }

  [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {

    NSLog(@"update ui");

  } failure:^(YTKBaseRequest *request) {

    NSLog(@"failed");

  }];
}

- (void)sendBatchRequest {
  GetImageApi     *a            = [[GetImageApi alloc] initWithImageId:@"abc.jpg"];
  GetImageApi     *b            = [[GetImageApi alloc] initWithImageId:@"abc.jpg"];
  GetImageApi     *c            = [[GetImageApi alloc] initWithImageId:@"abc.jpg"];
  GetUserInfoApi  *d            = [[GetUserInfoApi alloc] initWithUserId:@"123"];
  YTKBatchRequest *batchRequest = [[YTKBatchRequest alloc] initWithRequestArray:@[a, b, c, d]];
  [batchRequest startWithCompletionBlockWithSuccess:^(YTKBatchRequest *batchRequest) {
    NSLog(@"succeed");
    NSArray        *requests = batchRequest.requestArray;
    GetImageApi    *a        = (GetImageApi *) requests[0];
    GetImageApi    *b        = (GetImageApi *) requests[1];
    GetImageApi    *c        = (GetImageApi *) requests[2];
    GetUserInfoApi *user     = (GetUserInfoApi *) requests[3];
    // deal with requests result ...
  } failure:^(YTKBatchRequest *batchRequest) {
    NSLog(@"failed");
  }];
}

- (void)sendChainRequest {

  RegisterApi *reg = [[RegisterApi alloc] initWithUsername:@"stone" password:@"123"];

  YTKChainRequest *chainReq = [[YTKChainRequest alloc] init];

  [chainReq addRequest:reg callback:^(YTKChainRequest *chainRequest, YTKBaseRequest *baseRequest) {

    RegisterApi *result = (RegisterApi *) baseRequest;

    NSString *userId = [result userId];

    GetUserInfoApi *api = [[GetUserInfoApi alloc] initWithUserId:userId];

    [chainRequest addRequest:api callback:nil];
  }];

  chainReq.delegate = self;

  // start to send request
  [chainReq start];
}

- (void)chainRequestFinished:(YTKChainRequest *)chainRequest {
  // all requests are done
  NSLog(@"%s", __func__);
}

- (void)chainRequestFailed:(YTKChainRequest *)chainRequest failedBaseRequest:(YTKBaseRequest *)request {
  // some one of request is failed
  NSLog(@"%s", __func__);
}

- (void)makeButton07 {
  NSMutableDictionary *dictionary = self.options.mutableCopy;
  dictionary[@"titleNormal"] = @"上传文件";
  dictionary[@"action"]      = ^void(SNButton *sender) {
    UploadImageApi *api = [[UploadImageApi alloc] initWithImage:[UIImage imageNamed:@"abc002"]];

    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
      id o = request.responseJSONObject;
      NSLog(@"o = %@", o);
      // 你可以直接在这里使用 self
      NSLog(@"succeed");
    } failure:^(YTKBaseRequest *request) {
      // 你可以直接在这里使用 self
      NSLog(@"failed");
    }];
  };

  SNButton *button = [SNButton makeButtonWithOptions:dictionary];
  [self.buttons addObject:button];
}

- (void)makeButton06 {
  NSMutableDictionary *dictionary = self.options.mutableCopy;
  dictionary[@"titleNormal"] = @"显示上次缓存的内容";
  dictionary[@"action"]      = ^void(SNButton *sender) {
    [self loadCacheData];
  };

  SNButton *button = [SNButton makeButtonWithOptions:dictionary];
  [self.buttons addObject:button];
}

- (void)makeButton05 {
  NSMutableDictionary *dictionary = self.options.mutableCopy;
  dictionary[@"titleNormal"] = @"async awat 请求";
  dictionary[@"action"]      = ^void(SNButton *sender) {
    [self sendChainRequest];
  };

  SNButton *button = [SNButton makeButtonWithOptions:dictionary];
  [self.buttons addObject:button];
}

- (void)makeButton04 {
  NSMutableDictionary *dictionary = self.options.mutableCopy;
  dictionary[@"titleNormal"] = @"并发请求";
  dictionary[@"action"]      = ^void(SNButton *sender) { [self sendBatchRequest]; };

  SNButton *button = [SNButton makeButtonWithOptions:dictionary];
  [self.buttons addObject:button];
}

- (void)makeButton03 {

  NSMutableDictionary *dictionary = self.options.mutableCopy;
  dictionary[@"titleNormal"] = @"缓存请求";
  dictionary[@"action"]      = ^void(SNButton *sender) {
    GetUserInfoApi *api = [[GetUserInfoApi alloc] initWithUserId:@"123"];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
      id o = request.responseJSONObject;
      NSLog(@"o = %@", o);
      // 你可以直接在这里使用 self
      NSLog(@"succeed");
    } failure:^(YTKBaseRequest *request) {
      // 你可以直接在这里使用 self
      NSLog(@"failed");
    }];
  };

  SNButton *button = [SNButton makeButtonWithOptions:dictionary];
  [self.buttons addObject:button];
}

- (void)makeButton02 {

  NSMutableDictionary *dictionary = self.options.mutableCopy;

  dictionary[@"titleNormal"] = @"图片请求";

  dictionary[@"action"] = ^void(SNButton *sender) {
    NSLog(@"kHome = %@", kHome);
    GetImageApi *api = [[GetImageApi alloc] initWithImageId:@"abc.jpg"];
    [api startWithCompletionBlockWithSuccess:^(YTKBaseRequest *request) {
      printProperties(YTKBaseRequest.class, request);
      // 你可以直接在这里使用 self
      NSLog(@"succeed");
    } failure:^(YTKBaseRequest *request) {
      // 你可以直接在这里使用 self
      NSLog(@"failed");
    }];
  };

  SNButton *button = [SNButton makeButtonWithOptions:dictionary];
  [self.buttons addObject:button];
}

- (void)makeButton01 {

  NSMutableDictionary *dictionary = self.options.mutableCopy;

  dictionary[@"titleNormal"] = @"入门使用";

  dictionary[@"action"] = ^void(SNButton *sender) {
    NSString *username = @"stone";
    NSString *password = @"123";
    if (username.length > 0 && password.length > 0) {
      RegisterApi *api = [[RegisterApi alloc] initWithUsername:username password:password];

      [api addAccessory:self];

      api.delegate = self;
      [api start];
    }
  };

  SNButton *button = [SNButton makeButtonWithOptions:dictionary];
  [self.buttons addObject:button];

}

- (void)requestFinished:(YTKBaseRequest *)request {
  NSLog(@"succeed");

  id o = request.responseJSONObject;
  NSLog(@"o = %@", o);

  printProperties(YTKBaseRequest.class, request);
}

- (void)requestFailed:(YTKBaseRequest *)request {
  NSLog(@"failed");

  id o = request.jsonValidator;

  NSLog(@"o = %@", o);

}

- (void)injected {

  // // 获取当前类的所有属性
  // unsigned int               count;// 记录属性个数
  // objc_property_t            *properties = class_copyPropertyList(cls, &count);
  // // 遍历
  // NSMutableArray<NSString *> *mArray     = [NSMutableArray array];
  // for (int                   i           = 0; i < count; i++) {
  //
  //   // An opaque type that represents an Objective-C declared property.
  //   // objc_property_t 属性类型
  //   objc_property_t property = properties[i];
  //   // 获取属性的名称 C语言字符串
  //   const char      *cName   = property_getName(property);
  //   // 转换为Objective C 字符串
  //   NSString        *name    = [NSString stringWithCString:cName
  //                                        encoding:NSUTF8StringEncoding];
  //   [mArray addObject:name];
  // }
}


@end
    
