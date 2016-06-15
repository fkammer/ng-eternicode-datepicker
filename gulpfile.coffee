gulp = require 'gulp'

coffee = require 'gulp-coffee'
concat = require 'gulp-concat'
uglify = require 'gulp-uglify'
rename = require 'gulp-rename'

gulp.task 'build', ->
  gulp.src './src/*.coffee'
    .pipe coffee()
    .pipe concat 'ng-datepicker.js'
    .pipe gulp.dest './dist'
    .pipe uglify()
    .pipe rename 'ng-datepicker.min.js'
    .pipe gulp.dest './dist'

gulp.task 'watch', ->
  gulp.watch 'src/*', ['build']

gulp.task 'default', ['build', 'watch']
