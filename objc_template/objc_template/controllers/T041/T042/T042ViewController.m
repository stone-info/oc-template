//
//  T042ViewController.m
//  objc_template
//
//  Created by stone on 2019/04/05.
//  Copyright © 2019 stone. All rights reserved.
//

#import <JavaScriptCore/JavaScriptCore.h>
#import "T042ViewController.h"

@interface T042ViewController ()

@property (copy, nonatomic) NSString *jsonString;

@end

@implementation T042ViewController

- (NSString *)jsonString {

  /** _jsonString lazy load */

  if (_jsonString == nil) {
    _jsonString = @"{\"code\":0,\"msg\":\"success\",\"data\":{\"logined\":true,\"lastSignDay\":0,\"needResign\":false,\"needSign\":true,\"signAwds\":[{\"type\":2,\"code\":\"1\",\"value\":\"0.05\",\"name\":\"第一天签到领取本金金额\"},{\"type\":2,\"code\":\"2\",\"value\":\"0.05\",\"name\":\"第二天签到领取本金金额\"},{\"type\":2,\"code\":\"3\",\"value\":\"0.05\",\"name\":\"第三天签到领取本金金额\"},{\"type\":2,\"code\":\"4\",\"value\":\"0.05\",\"name\":\"第四天签到领取本金金额\"},{\"type\":2,\"code\":\"5\",\"value\":\"0.05\",\"name\":\"第五天签到领取本金金额\"},{\"type\":2,\"code\":\"6\",\"value\":\"0.05\",\"name\":\"第六天签到领取本金金额\"},{\"type\":2,\"code\":\"7\",\"value\":\"0.2\",\"name\":\"第七天签到领取本金金额\"}],\"asset\":{\"userId\":1162773,\"totalPrinc\":0.0,\"totalIncome\":1.0,\"remainIncome\":1.0,\"lastIncome\":1.0,\"willIncome\":6.75,\"totalPrincString\":\"0.00\",\"totalIncomeString\":\"1.00\",\"remainIncomeString\":\"1.00\",\"lastIncomeString\":\"1.00\",\"activeFactor\":1.0,\"apprenticeCount\":0,\"apprenticeOrderCount\":0,\"willIncomeString\":\"6.75\"},\"userSign\":[]}}";
  }
  return _jsonString;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view from its nib.

  id o = jsonLoads(self.jsonString);

  NSLog(@"o = %@", o);
}

- (void)injected {
  NSLog(@"hello world");
  // [self log_json:NSData.new];
  // NSLog(@"hello");
}

// func to_json(obj: Any?) -> String {
//
//   guard let obj = obj else { return "" }
//
//   if (!JSONSerialization.isValidJSONObject(obj)) {
//     print("\u{001B}[1;97;41m【" + String(describing: "无法解析出JSONString") + "】\u{001B}[0m")
//     return ""
//   }
//
//   let data: NSData? = try? JSONSerialization.data(withJSONObject: obj, options: .prettyPrinted) as NSData
//
//   if let data = data {
//     let r = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)
//     return r! as String
//   } else {
//     return ""
//   }
// }


// func json_loads<T>(jsonString: String?) -> T? {
//
//   guard let jsonString = jsonString else { return nil }
//
//   let jsonData: Data = jsonString.data(using: .utf8)!
//
//   let obj_original = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
//
//   guard let obj = obj_original else { return nil }
//
//   if let obj_d = obj as? NSDictionary { return obj_d as? T }
//
//   if let obj_a = obj as? NSArray { return obj_a as? T }
//
//   return nil
//
// }


@end


// func SLogJson(_ file: String, _ line: Int, _ obj: Any?) {
//
//   if obj == nil {
//     SLog(file, line, "None", c: 0);
//     return
//   }
//
//   if (obj is NSData) {
//     let s = SN.dataToString(data: obj as? Data)
//     SLog(file, line, to_json(obj: json_loads(jsonString: s)), c: 0);
//     return
//   }
//
//   if (obj is String) {
//     SLog(file, line, to_json(obj: json_loads(jsonString: obj as? String)), c: 0);
//     return
//   }
//
//   SLog(file, line, to_json(obj: obj), c: 0);
// }
//

//
// func json_loads<T>(jsonString: String?) -> T? {
//
//   guard let jsonString = jsonString else { return nil }
//
//   let jsonData: Data = jsonString.data(using: .utf8)!
//
//   let obj_original = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
//
//   guard let obj = obj_original else { return nil }
//
//   if let obj_d = obj as? NSDictionary { return obj_d as? T }
//
//   if let obj_a = obj as? NSArray { return obj_a as? T }
//
//   return nil
//
//   // guard let jsonString = jsonString else { return nil }
//   //
//   // let jsonData: Data = jsonString.data(using: .utf8)!
//   // var obj            = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
//   // guard (obj != nil) else { return nil }
//   //
//   // obj = obj!
//   //
//   // let obj_d = obj as? NSDictionary
//   //
//   // if (obj_d != nil) {
//   //   return obj_d as? T
//   // }
//   //
//   // let obj_a = obj as? NSArray
//   //
//   // if (obj_a != nil) {
//   //   return obj_a as? T
//   // }
//   //
//   // return nil
// }
//
