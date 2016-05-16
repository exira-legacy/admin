'use strict';

var gulp = require('gulp'),
    rename = require('gulp-rename'),
    gulpSequence = require('gulp-sequence'),

    // Loads the plugins without having to list all of them, but you need
    // to call them as $.pluginname
    $ = require('gulp-load-plugins')(),

    // 'del' is used to clean out directories and such
    del = require('del'),

    // BrowserSync isn't a gulp package, and needs to be loaded manually
    browserSync = require('browser-sync'),
    elm = require('gulp-elm'),
    fs = require('fs'),
    ga = require('gulp-ga'),

    // merge is used to merge the output from two different streams into the same stream
    merge = require('merge-stream'),

    // Need a command for reloading webpages using BrowserSync
    plumber = require('gulp-plumber'),
    reload = browserSync.reload,

    // And define a variable that BrowserSync uses in its function
    bs,

    wiredep = require('wiredep').stream;

// Deletes the directory that is used to serve the site during development
gulp.task('clean:dev', function (cb) {
    return del(['serve'], cb);
});

// Deletes the directory that the optimized site is output to
gulp.task('clean:prod', function (cb) {
    return del(['dist'], cb);
});

// Compiles the SASS files and moves them into the 'assets/stylesheets' directory
gulp.task('styles', function () {
    // Looks at the style.scss file for what to include and creates a style.css file
    return gulp.src('src/assets/scss/style.scss')
        .pipe(plumber())
        .pipe($.sass())
        .on('error', function (err) {
            browserSync.notify('SASS error');

            console.error(err.message);

            // Save the error to index.html, with a simple HTML wrapper
            // so browserSync can inject itself in.
            fs.writeFileSync('serve/index.html', '<!DOCTYPE HTML><html><body><pre>' + err.message + '</pre></body></html>');

            // No need to continue processing.
            this.emit('end');
        })
        // AutoPrefix your CSS so it works between browsers
        .pipe($.autoprefixer('last 1 version', { cascade: true }))
        // Directory your CSS file goes to
        .pipe(gulp.dest('serve/assets/stylesheets/'))
        // Outputs the size of the CSS file
        .pipe($.size({ title: 'styles' }))
        // Injects the CSS changes to your browser since Jekyll doesn't rebuild the CSS
        .pipe(reload({ stream: true }));
});

// Optimizes the images that exists
gulp.task('images', function () {
    return gulp.src('src/assets/images/**')
        .pipe($.changed('dist/assets/images'))
        .pipe($.imagemin({
            // Lossless conversion to progressive JPGs
            progressive: true,
            // Interlace GIFs for progressive rendering
            interlaced: true
        }))
        .pipe(gulp.dest('dist/assets/images'))
        .pipe($.size({ title: 'images' }));
});

// Copy over fonts to the 'dist' directory
gulp.task('fonts', function () {
    return gulp.src('src/assets/fonts/**')
        .pipe(gulp.dest('dist/assets/fonts'))
        .pipe($.size({ title: 'fonts' }));
});

// Copy over fonts to the 'dist' directory
gulp.task('favicon', function () {
    return gulp.src('src/assets/favicon/**')
        .pipe(gulp.dest('dist'))
        .pipe($.size({ title: 'favicon' }));
});

// Copy index.html to the 'serve' directory
gulp.task('copy:dev', ['copy:bower'], function () {
    return gulp.src(['src/index.html', 'src/js/**/*', 'src/assets/images/**/*', 'src/assets/favicon/**/*'])
        .pipe(gulp.dest('serve'))
        .pipe($.size({ title: 'index.html' }))
});

// Copy bower
gulp.task('copy:bower', function () {
    return gulp.src(['bower_components/**/*'])
        .pipe(gulp.dest('serve/bower_components'))
        .pipe($.size({ title: 'Bower' }))
});

// Copy images
gulp.task('copy:images', function () {
    return gulp.src([])
        .pipe(gulp.dest('serve/assets/images'))
        .pipe($.size({ title: 'Assets images' }))
});

gulp.task('bower', function () {
    gulp.src('src/index.html')
        .pipe(wiredep())
        .pipe(gulp.dest('serve'));
});

// Setup Google Analytics
gulp.task('ga', function () {
    gulp.src('src/index.html')
        .pipe(ga({
            anonymizeIp: false,
            sendPageView: true,
            url: 'auto',
            uid: 'UA-xxxxxxx-xx'
        }))
        .pipe(gulp.dest('serve'));
});

// Optimizes all the CSS, HTML and concats the JS etc
gulp.task('minify', ['styles'], function () {
    var assets = $.useref.assets({ searchPath: 'serve' });

    return gulp.src('serve/**/*.*')
        // Concatenate JavaScript files and preserve important comments
        .pipe($.if('*.js', $.uglify({ preserveComments: 'some' })))
        // Minify CSS
        .pipe($.if('*.css', $.cleanCSS()))
        // Start cache busting the files
        .pipe($.revAll({ ignore: ['index.html', '.eot', '.svg', '.ttf', '.woff'] }))
        .pipe(assets.restore())
        // Replace the asset names with their cache busted names
        .pipe($.revReplace())
        // Minify HTML
        .pipe($.if('*.html', $.htmlmin({
            removeComments: true,
            removeCommentsFromCDATA: true,
            removeCDATASectionsFromCDATA: true,
            collapseWhitespace: true,
            collapseBooleanAttributes: true,
            removeAttributeQuotes: true,
            removeRedundantAttributes: true
        })))
        // Send the output to the correct folder
        .pipe(gulp.dest('dist'))
        .pipe($.size({ title: 'optimizations' }));
});

gulp.task('elm-init', elm.init);

gulp.task('elm', ['elm-init'], function () {
    return gulp
        .src('src/elm/Main.elm')
        .pipe(plumber())
        .pipe(elm())
        .on('error', function (err) {
            console.error(err.message);

            browserSync.notify('Elm compile error', 5000);

            // Save the error to index.html, with a simple HTML wrapper
            // so browserSync can inject itself in.
            fs.writeFileSync('serve/index.html', '<!DOCTYPE HTML><html><body><pre>' + err.message + '</pre></body></html>');
        })
        .pipe(rename('app.js'))
        .pipe(gulp.dest('serve'));
});

// BrowserSync will serve our site on a local server for us and other devices to use
// It will also autoreload across all devices as well as keep the viewport synchronized
// between them.
gulp.task('serve:dev', ['build'], function () {
    bs = browserSync({
        notify: true,
        // tunnel: '',
        server: {
            baseDir: 'serve'
        }
    });
});

// These tasks will look for files that change while serving and will auto-regenerate or
// reload the website accordingly. Update or add other files you need to be watched.
gulp.task('watch', function () {
    // We need to copy dev, so index.html may be replaced by error messages.
    gulp.watch(['src/index.html', 'src/js/**/*.js'], ['copy:dev', reload]);
    gulp.watch(['src/elm/**/*.elm'], ['elm', 'copy:dev', reload]);
    gulp.watch(['src/assets/scss/**/*.scss'], ['styles', 'copy:dev', reload]);
});

// Serve the site after optimizations to see that everything looks fine
gulp.task('serve:prod', function () {
    bs = browserSync({
        notify: false,
        // tunnel: true,
        server: {
            baseDir: 'dist'
        }
    });
});

// Default task, run when just writing 'gulp' in the terminal
gulp.task('default', ['serve:dev', 'watch']);

// Builds the site but doesnt serve it to you
// @todo: Add 'bower' here
gulp.task('build', gulpSequence('clean:dev', ['styles', 'copy:dev', 'elm'], 'ga'));

// Builds your site with the 'build' command and then runs all the optimizations on
// it and outputs it to './dist'
gulp.task('publish', ['build', 'clean:prod'], function () {
    gulp.start('minify', 'images', 'fonts');
});
