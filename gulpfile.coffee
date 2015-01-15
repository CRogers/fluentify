gulp = require('gulp')
coffee = require('gulp-coffee')
del = require('del')
mocha = require('gulp-mocha')

paths =
  coffee: './src/*.coffee'
  test: './test/*.coffee'

gulp.task 'coffee', ->
  gulp.src paths.coffee
    .pipe(coffee())
    .pipe(gulp.dest('./build/'))

gulp.task 'clean', ->
  del(['build/*'])

gulp.task 'watch', ->
  gulp.watch(paths.coffee, ['coffee'])

gulp.task 'test', ->
  gulp.src paths.test
    .pipe(coffee())
    .pipe(gulp.dest('./build/'))
  gulp.src('./build/*-spec.js', {read: false})
    .pipe(mocha())
