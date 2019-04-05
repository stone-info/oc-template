const execa     = require('execa')
const fs        = require('fs')
const path      = require('path')
const util      = require('util')
const writeFile = util.promisify(fs.writeFile)
const sprintf   = require('sprintf-js').sprintf
const vsprintf  = require('sprintf-js').vsprintf
const moment    = require('moment')

// console.log(sprintf(filename + ': %.2f%%', state.percent * 100));
// let output = '/Users/stone/git_repository/objective_c_template/objc_template/objc_template/controllers'
// let date = moment().format('YYYY/MM/DD') //2014-09-24 23:36:09

async function makeTestFolderAndFile (output, date, user, range) {

  for (let i = range[0]; i <= range[range.length - 1]; i++) {

    let folderName = `T${sprintf('%03d', i)}`
    let dirPath    = `${output}/${folderName}`
    let { stdout } = await execa.shell(`mkdir -p ${dirPath}`)

    let viewController = `${folderName}ViewController`
    await writeFile(`${dirPath}/${viewController}.h`, `//
//  ${viewController}.h
//  objc_template
//
//  Created by ${user} on ${date}.
//  Copyright © 2019 ${user}. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ${viewController} : UIViewController

@end

NS_ASSUME_NONNULL_END
    
    `)

    await writeFile(`${dirPath}/${folderName}ViewController.m`, `//
//  ${viewController}.m
//  objc_template
//
//  Created by ${user} on ${date}.
//  Copyright © 2019 ${user}. All rights reserved.
//

#import "${viewController}.h"

@interface  ${viewController} ()

@end

@implementation  ${viewController}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
    `)
  }
}

exports.makeTestFolderAndFile = makeTestFolderAndFile
