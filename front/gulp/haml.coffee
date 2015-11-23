'use strict'

path = require('path')
gulp = require('gulp')
conf = require('./conf')
plumber = require('gulp-plumber')
haml = require('gulp-ruby-haml')

gulp.task 'haml', ->
  gulp.src([path.join(conf.paths.src, '/app/**/*.haml')])
    .pipe(plumber())
    .pipe(haml())
    .pipe(gulp.dest(path.join(conf.paths.src, '/app/')))
