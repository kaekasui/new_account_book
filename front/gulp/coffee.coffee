'use strict'

path = require('path')
gulp = require('gulp')
conf = require('./conf')
plumber = require('gulp-plumber')
coffee = require('gulp-coffee')

gulp.task 'coffee', ->
  gulp.src [path.join(conf.paths.src, '/app/**/*.coffee')]
    .pipe coffee()
    .pipe gulp.dest(path.join(conf.paths.src, '/app/'))
