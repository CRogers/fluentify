gulp = require('gulp')
coffee = require('gulp-coffee')

gulp.task 'coffee', ->
  gulp.src './src/*.coffee'
    .pipe(coffee())
    .pipe(gulp.dest('./build/'))
