gulp = require('gulp')
coffee = require('gulp-coffee')
del = require('del')
mocha = require('gulp-mocha')

paths =
  coffee: './src/*.coffee'

gulp.task 'coffee', ->
  gulp.src paths.coffee
    .pipe(coffee())
    .pipe(gulp.dest('./build/'))

gulp.task 'clean', ->
  del(['build/*'])

gulp.task 'watch', ->
  gulp.watch(paths.coffee, ['test'])

gulp.task 'test', ['coffee'], ->
  gulp.src('./build/*-spec.js', {read: false})
    .pipe(mocha())
