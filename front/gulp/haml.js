'use strict';

var path = require('path');
var gulp = require('gulp');
var conf = require('./conf');
var haml = require('gulp-ruby-haml');

gulp.task('haml', function () {
  gulp.src([
    path.join(conf.paths.src, '/app/**/*.haml')
  ])
    .pipe(haml())
    .pipe(gulp.dest(path.join(conf.paths.src, '/app/')));
});
