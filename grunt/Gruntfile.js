// Generated on 2014-01-02 using generator-webapp 0.4.6
'use strict';

// # Globbing
// for performance reasons we're only matching one level down:
// 'test/spec/{,*/}*.js'
// use this if you want to recursively match all subfolders:
// 'test/spec/**/*.js'

module.exports = function (grunt) {

  // Load grunt tasks automatically
  require('load-grunt-tasks')(grunt);

  // Time how long tasks take. Can help when optimizing build times
  require('time-grunt')(grunt);

  // Define the configuration for all the tasks
  grunt.initConfig({

    sass: {
      options: {
        style: 'nested',
        lineNumbers: true
      },
      dev: {
        options: {
          style: 'expanded',
          debugInfo: false,
        },
        files: {
          './public/lib/css/dev/base.css': './public/lib/css/dev/base.scss'
        }
      },
    },

    autoprefixer: {
      options: {
        browsers: ['> 1%', 'last 2 versions', 'ff 17', 'opera 12.1' /* the defaults, and also: */, 'ie >= 8']
      },
      dev: {
        src: './public/lib/css/base.css',
        dest: './public/lib/css/base.css'
      },
    },

    concat: {
      css: {
        //concat vendor css files
        src: [
          './public/lib/css/dev/base.css',
        ],
        dest: './public/lib/css/dev/main.css',
      },
      js: {
        src: [ 
          './public/lib/js/dev/vendor/plugins.js',
          './public/lib/js/dev/vendor/disqus.js',
          './public/lib/js/dev/vendor/jquery.smoothstate.js', 
          './public/lib/js/dev/vendor/ojp/ojp_events_dispatcher.js',
          './public/lib/js/dev/vendor/ojp/ojp_marquee.js',
          './public/lib/js/dev/vendor/ojp/ojp_utils.js',
          './public/lib/js/dev/vendor/bootstrap.min.js',
          './public/lib/js/dev/vendor/bootstrap-validator/bootstrapValidator.js',
          './public/lib/js/dev/vendor/bootstrap-validator/bootstrapValidator.js',
          './public/lib/js/dev/vendor/bootstrap-validator/validator/notEmpty.js',
          './public/lib/js/dev/vendor/bootstrap-validator/validator/emailAddress.js',
          './public/lib/js/dev/vendor/bootstrap-validator/validator/stringLength.js',
          './public/lib/js/dev/vendor/bootstrap-validator/validator/different.js',
          './public/lib/js/dev/vendor/bootstrap-validator/validator/regExp.js',
          './public/lib/js/dev/vendor/bootstrap-validator/validator/date.js',
          './public/lib/js/dev/vendor/bootstrap-validator/validator/phone.js', 
          './public/lib/js/dev/vendor/iframeResizer.min.js',
        ],
        dest: './public/lib/js/dev/vendor.js',
        separator: ';'
      },
    },

    cssmin: {
      dev: {
        files: [
          {
            src: ['./public/lib/css/dev/main.css'],
            dest: './public/lib/css/main.min.css'
          },
          {
            src: ['./public/lib/css/parallax.css'],
            dest: './public/lib/css/parallax.min.css'
          }
        ]
        
      }
    },

    uglify: {
      dev: {
        options: {
          mangle: false,
          compress: true,
          sourceMap: false,
        },
        files: {
          './public/lib/js/main.min.js': ['./public/lib/js/dev/main.js'],
          './public/lib/js/vendor.min.js': ['./public/lib/js/dev/vendor.js']
        }
      }
    },
    

    /*clean: {
      tmp: {
        src: ['./tmp']
      }
    },*/

    coffee: {
      compile: {
        options: {
          join: true
        },
        files: {
          './public/lib/js/dev/main.js': [
            './public/lib/js/dev/modules.coffee',
            './public/lib/js/dev/exterro/form.coffee',
            './public/lib/js/dev/exterro/contact-form.coffee',
            './public/lib/js/dev/main.coffee'],
        },
      },
      
    },


    // Watches files for changes and runs tasks based on the changed files
    watch: {
      options: {
        livereload: true
      },
      js: {
          files: ['./public/lib/js/{,*/}*.coffee', './public/lib/js/dev/exterro/*.coffee', './public/lib/js/dev/vendor/plugins.js'],
          tasks: ['dev']
      },
      gruntfile: {
          files: ['Gruntfile.js']
      },
      css: {
          files: [
            './public/lib/css/dev/{,*/}*.{scss,sass}', 
            './public/lib/css/dev/vendor/*.css', 
            './public/lib/css/dev/vendor/ojp/*.css', 
            './public/lib/css/dev/elements/*.scss',
            './public/lib/css/parallax.css'
          ],
          tasks: ['devCSS']
      },
      html: {
          files: ['./craft/templates/**/*', '!./craft/templates/layouts/main/_layout.html'],
          tasks: ['devHTML']
      }
    },

    targethtml: {
      dev: {
        files: {
          './craft/templates/layouts/main/_layout.html': './craft/templates/layouts/main/src/_layout.html'
        }
      },
      dist: {
        files: {
          './craft/templates/layouts/main/_layout.html': './craft/templates/layouts/main/src/_layout.html'
        }
      }
    },

    // The actual grunt server settings
    connect: {
      options: {
        port: 9003,
        livereload: true,
        // Change this to '0.0.0.0' to access the server from outside
        hostname: 'localhost'
      },
      prod: {
        options: {
          open: true,
          base: '',
          livereload: false
        }
      }
    },
  });

  grunt.loadNpmTasks('grunt-contrib-sass');
  grunt.loadNpmTasks('grunt-contrib-watch');
  grunt.loadNpmTasks('grunt-contrib-connect');
  grunt.loadNpmTasks('grunt-autoprefixer');
  grunt.loadNpmTasks('grunt-contrib-cssmin');
  //grunt.loadNpmTasks('grunt-contrib-clean');
  grunt.loadNpmTasks('grunt-contrib-concat');
  //grunt.loadNpmTasks('grunt-contrib-uglify');
  grunt.loadNpmTasks('grunt-targethtml');


  grunt.registerTask('dev', 'build development js', ['coffee:compile', 'concat:js']);
  grunt.registerTask('devCSS', 'build dev css', ['sass:dev', 'autoprefixer:dev']);
  grunt.registerTask('devHTML', 'build development html', ['targethtml:dev']);
  grunt.registerTask('prod', 'build development css', ['sass:dev', 'coffee:compile', 'autoprefixer:dev', 'concat:css', 'cssmin:dev', 'concat:js', 'uglify:dev', 'targethtml:dist']);
  //grunt.registerTask('prod', 'build production css', ['sass:prod', 'autoprefixer:prod', 'concat:css', 'cssmin:prod', 'coffee:compile', 'concat:js', 'uglify:prod', 'clean:tmp']);
  
  grunt.registerTask('default',['watch', 'connect']);
};
