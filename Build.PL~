use Module::Build;
my $build = Module::Build->new
(
	 module_name => 'plasmidDraw',
	 license => 'perl',
	 requires => {
		          'perl'		=> '5.14.0',
		          'Dancer2'		=> '0',
		          'BioPerl'		=> '0',
		          'Moose'		=> '0',
		          'Template'	=> '0',
		          'Try::Tiny'	=> '0',
		          'File::Temp'	=> '0',
		          'File::Slurp'	=> '0',
		          'Bio::Tools::Run::StandAloneBlastPlus' => '0',
		         },
);

$build->create_build_script;
