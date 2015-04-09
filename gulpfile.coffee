gulp = require('gulp')
coffee = require('gulp-coffee')
del = require('del')
mocha = require('gulp-mocha')

allCoffee = './src/*.coffee'

compileToFolder = (path, outputFolder) ->
  gulp.src path
    .pipe(coffee(bare: true))
    .pipe(gulp.dest("./#{outputFolder}/"))

gulp.task 'coffee', ->
  compileToFolder(allCoffee, 'build')

gulp.task 'clean', ->
  del(['build/*'])

gulp.task 'watch', ->
  gulp.watch(allCoffee, ['test'])

gulp.task 'test', ['coffee'], ->
  gulp.src('./build/*-spec.js', {read: false})
    .pipe(mocha())

gulp.task 'dist', ->
  compileToFolder('./src/fluidify.coffee', 'dist')