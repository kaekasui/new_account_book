'use strict';

var path = require('path');
var gulp = require('gulp');
var conf = require('./conf');
var haml = require('gulp-ruby-haml');
var cache = require('gulp-cached');

var browserSync = require('browser-sync');

var $ = require('gulp-load-plugins')();

gulp.task('markups', function() {
  return gulp.src(path.join(conf.paths.src, '/app/**/*.haml'))
    .pipe(cache('linting'))
    .pipe(haml())
    .pipe(gulp.dest(path.join(conf.paths.dist, '/')))
    .pipe(browserSync.stream());
});
