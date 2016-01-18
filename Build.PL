use Module::Build;
my $build = Module::Build->new
(
	 module_name => 'plasmidDraw',
	 license => 'perl',
	 requires => {
		          'perl'		=> '5.14.0',
		         },
);

$build->create_build_script;
