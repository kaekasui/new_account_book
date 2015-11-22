gutil = require('gulp-util')

exports.paths =
  src: 'src'
  dist: '../public'
  tmp: '.tmp'
  e2e: 'e2e'

exports.wiredep =
  exclude: [
    /\/bootstrap\.js$/
    /\/bootstrap-sass\/.*\.js/
    /\/bootstrap\.css/
  ]
  directory: 'bower_components'

exports.errorHandler = (title) ->
  'use strict'
  (err) ->
    gutil.log gutil.colors.red('[' + title + ']'), err.toString()
    @emit 'end'
