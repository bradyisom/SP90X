gulp = require 'gulp'
connect = require 'gulp-connect'
coffee = require 'gulp-coffee'
sass = require 'gulp-sass'

gulp.task 'coffee', ->
    gulp.src('src/**/*.coffee')
        .pipe(coffee())
        .pipe(gulp.dest('.tmp'))
        .pipe(connect.reload())

gulp.task 'watch-coffee', ->
    gulp.watch('src/**/*.coffee', ['coffee'])

gulp.task 'sass', ->
    gulp.src('src/**/*.scss')
        .pipe(sass())
        .pipe(gulp.dest('.tmp'))
        .pipe(connect.reload())

gulp.task 'watch-sass', ->
    gulp.watch('src/**/*.scss', ['sass'])

gulp.task 'build-html', ->
    gulp.src('src/**/*.html')
        .pipe(connect.reload())

gulp.task 'watch-html', ->
    gulp.watch('src/**/*.html', ['build-html'])

gulp.task 'connect', ->
    connect.server(
        root: ['.tmp', 'src', '.']
        port: 8001
        livereload: true
    )

gulp.task 'default', ['connect', 'watch-coffee', 'watch-sass', 'watch-html'], ->
	
