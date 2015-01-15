gulp = require('gulp')
coffee = require('gulp-coffee')
del = require('del')

paths =
  coffee: './src/*.coffee'

gulp.task 'coffee', ->
  gulp.src paths.coffee
    .pipe(coffee())
    .pipe(gulp.dest('./build/'))

gulp.task 'clean', ->
  del(['build/*'])

gulp.task 'watch', ->
  gulp.watch(paths.coffee, ['coffee'])
