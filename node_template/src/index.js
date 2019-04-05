const { makeTestFolderAndFile } = require('./lib')
const moment                    = require('moment')

;(async function () {

  let output = '/Users/stone/git_repository/oc-template/objc_template/objc_template/controllers'
  let date   = moment().format('YYYY/MM/DD') //2014-09-24 23:36:09
  let user   = 'stone'

  await makeTestFolderAndFile(output, date, user, [63, 83])

})()
