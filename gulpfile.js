const gulp = require('gulp');
const headerComment = require('gulp-header-comment');
const moment = require('moment');
var watch = require('gulp-watch');
var clean = require('gulp-clean');
var rimraf = require('gulp-rimraf');

var directories = ['DCW.Malden', 'DCW.Lythium', 'DCW.Chongo','DCW.Module/functions'];  

// Perform a default watch to the root folder
gulp.task('default', function () {
    // Callback mode, useful if any plugin in the pipeline depends on the `end`/`flush` event
    return watch('DCW/**/*', function () {
        for (var i = 0; i < directories.length; i++) {  
            gulp.src('DCW/**/*')
            .pipe(gulp.dest('./'+directories[i]+'/DCW'));  
        }
    });
});

gulp.task('copy', function () {
    for (var i = 0; i < directories.length; i++) {  
        gulp.src('DCW/**/*')
            .pipe(gulp.dest('./'+directories[i]+'/DCW'));  
    } 
});


gulp.task('clean', function () {
    for (var i = 0; i < directories.length; i++) {  
      gulp.src(directories[i]+'/DCW', {read: false})
        .pipe(rimraf());
    }
});

gulp.task('comments', function() {
    gulp.src('**/*.sqf')
    .pipe(headerComment(`
        DYNAMIC CIVIL WAR
        Created: <%= moment().format('YYYY-MM-DD') %>
        Author: <%= pkg.author %>
        License: GNU (GPL)
    `))
   .pipe(gulp.dest(function (file) {
        return file.base;
    }));
 // .pipe(gulp.dest('./dist/'))
});

const pbo = require('gulp-armapbo');

gulp.task('pack', () => {
    return gulp.src('DCW.Module/**/*')
        .pipe(pbo.pack({
            fileName: 'DCW_Module.pbo',
            extensions: [{
                name: 'Bidass',
                value: 'AntoineBidault'
            }, {
                name: 'DCW',
                value: 'DynamicCivilWar'
            }],
            compress: [
               // '**/*.sqf',
                'config.cpp'
            ]
        }))
        .pipe(gulp.dest('@DCW/addons'));
});