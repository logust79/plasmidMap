#!/bin/sh

# this is to install dependent programs/perl modules

# perl version >= 14?

ver=$(perl -v | awk '/version [0-9]+/ {print $6}' | awk '{print substr($0,0,2)}')

if [ $ver -ge 24 ] ; then
	# good. install prerequisite
	sudo apt-get -qq update
	sudo apt-get install ncbi-blast+
	sudo apt-get install libdb-dev
	sudo apt-get install graphviz
	cpan install App::cpanminus
	cpanm BioPerl 
	cpanm Bio::Tools::Run::StandAloneBlastPlus --force
	cpanm Moose
	cpanm Template
	cpanm Try::Tiny
	cpanm Math::Trig
	cpanm File::Temp
	cpanm File::Slurp
	cpanm Starman
	wget https://github.com/hyattpd/Prodigal/archive/v2.6.1.tar.gz -O /tmp/prodigal.tar.gz
	tar -xvf /tmp/prodigal.tar.gz
	cd Prodigal-2.6.1
	sudo make install
	cd ..
else
	# not good. throw an error.
	echo 'Error: Your perl version has to be at least 5.14.0. perl -v to check your perl version';
	exit 1;
fi
