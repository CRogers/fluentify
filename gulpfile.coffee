gulp = require('gulp')
coffee = require('gulp-coffee')
del = require('del')
mocha = require('gulp-mocha')

compileToFolder = (path, outputFolder) ->
  gulp.src path
    .pipe(coffee())
    .pipe(gulp.dest("./#{outputFolder}/"))

gulp.task 'coffee', ->
  compileToFolder('./src/*.coffee', 'build')

gulp.task 'clean', ->
  del(['build/*'])

gulp.task 'watch', ->
  gulp.watch(paths.coffee, ['test'])

gulp.task 'test', ['coffee'], ->
  gulp.src('./build/*-spec.js', {read: false})
    .pipe(mocha())

gulp.task 'dist', ->
  compileToFolder('./src/fluentify.coffee', 'dist')