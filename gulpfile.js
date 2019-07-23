const gulp = require('gulp');
const headerComment = require('gulp-header-comment');
const moment = require('moment');
var watch = require('gulp-watch');
var clean = require('gulp-clean');
var rimraf = require('gulp-rimraf');
var replace = require('gulp-replace');
var log = require('fancy-log');
cache = require('gulp-cached'),
    remember = require('gulp-remember');
var pjson = require('./package.json');

var version = pjson.version;

var directories = ['DCW.Malden','DCW.Tanoa', 'DCW.Lythium', 'DCW.Takistan', 'DCW.Chongo','DCW.Module/functions'];  

// Perform a default watch to the root folder
gulp.task('default', function () {
    var source = './DCW'
    gulp.start('copy');
    // Callback mode, useful if any plugin in the pipeline depends on the `end`/`flush` event
    
     for (var i = 0; i < directories.length; i++) {  
        gulp.src(source+'/**/*', {base: source})
        .pipe(watch(source, {base: source}))
        .on('change', function(data){ log('File change - copying ' + data ); })
        .on('added', function(data){ log('File added - copying '+ data ); })
        .pipe(replace('{VERSION}', version))
        .pipe(replace('{WORLD_NAME}', directories[i].split('.')[1]))
        .pipe(gulp.dest('./'+directories[i]+'/DCW'));  

        gulp.src('./stringtable.xml')
        .pipe(watch('./stringtable.xml'))
        .on('change', function(data){ log('File change - stringtable.xml ' ); })
        .on('added', function(data){ log('File added -  stringtable.xml '); })
        .pipe(replace('{VERSION}', version))
        .pipe(replace('{WORLD_NAME}', directories[i].split('.')[1]))
        .pipe(gulp.dest('./'+directories[i]));  
    }

});

gulp.task('copy',function() {
    for (let i = 0; i < directories.length; i++) {  
        console.log(directories[i].split('.')[1]);
        gulp.src('DCW/**/*')
        .pipe(replace('{VERSION}', version))
        .pipe(replace('{WORLD_NAME}', directories[i].split('.')[1]))
        .pipe(gulp.dest('./'+directories[i]+'/DCW'));  
    } 
});


gulp.task('clean', function () {
    for (var i = 0; i < directories.length; i++) {  
      gulp.src(directories[i]+'/DCW', {read: false})
        .pipe(rimraf());
    }
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
        .pipe(gulp.dest('Build/@DCW/addons'));
});


gulp.task('mission', () => {
    return gulp.src('DCW.Malden/**/*')
        .pipe(pbo.pack({
            fileName: 'DCW.Malden.pbo',
            extensions: [{
                name: 'Bidass',
                value: 'AntoineBidault'
            }, {
                name: 'DCW',
                value: 'DynamicCivilWar'
            }],
            compress: [
               // '**/*.sqf',
              //  'config.cpp'
            ]
        }))
        .pipe(gulp.dest('Build/MPMissions'));
});