var gulp = require('gulp'),
  browserify = require('browserify'),
  del = require('del'),
  //reactify = require('reactify'),
  source = require('vinyl-source-stream'),
  to5 = require('6to5ify'),
  coffeeify = require('coffeeify');


var paths = {
    srcJs: ['./main.coffee'],
    js: ['./bundle.js']
}


gulp.task('clean', function(done){
    del(['build'], done)
})


gulp.task('js', ['clean'], function() {
//#browserify({debug: true})
        browserify('./main.coffee')
        .transform(coffeeify)
//        .require('./main.js')
        .bundle()
        .on("error", function (err) { console.log("Error: " + err.message); })
        .pipe(source('bundle.js'))
        .pipe(gulp.dest('./build/'));
})


// Rerun tasks whenever a file changes.
gulp.task('watch', ['js'], function() {
    gulp.watch(paths.srcJs, ['js']);
});
