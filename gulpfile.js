 const gulp = require('gulp');
const headerComment = require('gulp-header-comment');
 const moment = require('moment');
gulp.task('default', function() {
    gulp.src('**/*.sqf')
    .pipe(headerComment(`
        DYNAMIC CIVIL WAR
        Created: <%= moment().format('YYYY-MM-DD') %>
        Author: <%= pkg.author %>
        License: MIT
    `))
   .pipe(gulp.dest(function (file) {
        return file.base;
    }));
 // .pipe(gulp.dest('./dist/'))
});