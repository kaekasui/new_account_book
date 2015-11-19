'use strict'

path = require('path')
gulp = require('gulp')
conf = require('./conf')
haml = require('gulp-ruby-haml')

gulp.task 'haml', ->
  gulp.src([path.join(conf.paths.src, '/app/**/*.haml')])
    .pipe(haml())
    .pipe(gulp.dest(path.join(conf.paths.src, '/app/')))
