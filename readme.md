# Light Weight Plasmid Drawer

[![Build Status](https://travis-ci.org/logust79/plasmidMap.svg?branch=master)](https://travis-ci.org/logust79/plasmidMap)

* To install, run install_dependent.sh first. (only work on Linux-based systems)
* Convert to PNG stopped working for OSX 10.11, due to lack of support from inkscape. Will probably recover soon.
* For single worker, run as `./app.pl` or `perl ap.pl` if you don't want to chmod.
* For multiple workers, please use `starman`: `starman --workers 32 app.pl -p 5000`
* Port default is 5000. You can change it in `app.pl`, `set port => 8080`. Not relevant if you use `starman`.
* You can use `test.html` to run the POST request test.
