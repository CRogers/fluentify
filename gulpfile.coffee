gulp = require('gulp')
coffee = require('gulp-coffee')
del = require('del')

gulp.task 'coffee', ->
  gulp.src './src/*.coffee'
    .pipe(coffee())
    .pipe(gulp.dest('./build/'))

gulp.task 'clean', ->
  del(['build/*'])
