#!/bin/bash
#
# Stick this in your application's /bin directory and issue from there.
#

if [ -e styles.combined.css ]; then rm styles.combined.css; fi
cat ../stylesheets/css/*.css > styles.combined.css
java -jar ~/bin/yuicompressor-2.4.7.jar -o ../stylesheets/css/min/styles.min.css styles.combined.css
rm styles.combined.css

if [ -e application.combined.js ]; then rm application.combined.js; fi
cat ../javascripts/libs/*.js ../javascripts/*.js > application.combined.js
java -jar ~/bin/yuicompressor-2.4.7.jar -o ../javascripts/min/application.min.js application.combined.js
rm application.combined.js
