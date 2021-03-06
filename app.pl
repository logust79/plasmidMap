#!/usr/bin/env perl
# Use Dancer2 to accept POST request on drawing a plasmid. field name is "json". Can use "test.html" in the same folder to do a test.
=json example
{
    "primers":
    [
        {
            "name": "CAT-R",
            "id": "123",
            "url": "http://some.url.com/primer/123",
            "seq": "gca act gac tga aat gcc tc"
        },
        {
            "name": "L4440",
            "id": "124",
            "url": "http://some.url.com/primer/124",
            "seq": "agc gag tca gtg agc gag"
        },
        {
            "name": "Amp-R",
            "id": "125",
            "url": "http://some.url.com/primer/125",
            "seq": "ata ata ccg cgc cac ata gc"
        }
    ],
    "restrictionEnzymes":
    {
         "BamHI": "G^GATCC",
         "EcoRI": "G^AATTC",
         "EcoRV": "CAT^ATC",
         "HindIII": "A^AGCTT",
         "PstI": "CTGCA^G",
         "SalI": "G^TCGAC",
         "ScaI": "AGT^ACT",
         "SmaI": "CCC^GGG",
         "XbaI": "T^CTAGA",
         "NdeI": "CA^TATG",
         "ApoI": "R^AATTY",
         "AlwNI": "CAGNNNCTG",
         "AccI": "GT^MKAC",
         "SfiI": "GGCCNNNN^NGGCC",
         "HincII": "GTY^RAC",
         "NruI": "TCG^CGA",
         "BglI": "GCCNNNN^NGGC",
         "XmaI": "C^CCGGG",
         "DraI": "TTT^AAA",
         "PvuII": "CAG^CTG",
         "KpnI": "GGTAC^C",
         "NarI": "GG^CGCC",
         "BglII": "A^GATCT",
         "HpaI": "GTT^AAC",
         "StuI": "AGG^CCT",
         "NcoI": "C^CATGG",
         "BclI": "T^GATCA",
         "AvaI": "C^YCGRG",
         "AvaII": "G^GWCC",
         "PstI": "CTGCA^G",
         "SphI": "GCATG^C",
         "ApaI": "GGGCC^C",
         "NotI": "GC^GGCCGC",
         "XhoI": "C^TCGAG",
         "ClaI": "AT^CGAT"
    },
    "plasmid":
    {
        "name": "pLysS",
        "seq": "GAATTCCGGATGAGCATTCATCAGGCGGGCAAGAATGTGAATAAAGGCCGGATAAAACTTGTGCTTATTTTTCTTTACGGTCTTTAAAAAGGCCGTAATATCCAGCTGAACGGTCTGGTTATAGGTACATTGAGCAACTGACTGAAATGCCTCAAAATGTTCTTTACGATGCCATTGGGATATATCAACGGTGGTATATCCAGTGATTTTTTTCTCCATTTTAGCTTCCTTAGCTCCTGAAAATCTCGATAACTCAAAAAATACGCCCGGTAGTGATCTTATTTCATTATGGTGAAAGTTGGAACCTCTTACGTGCCGATCAACGTCTCATTTTCGCCAAAAGTTGGCCCAGGGCTTCCCGGTATCAACAGGGACACCAGGATTTATTTATTCTGCGAAGTGATCTTCCGTCACAGGTATTTATTCGGCGCAAAGTGCGTCGGGTGATGCTGCCAACTTACTGATTTAGTGTATGATGGTGTTTTTGAGGTGCTCCAGTGGCTTCTGTTTCTATCAGCTGTCCCTCCTGTTCAGCTACTGACGGGGTGGTGCGTAACGGCAAAAGCACCGCCGGACATCAGCGCTAGCGGAGTGTATACTGGCTTACTATGTTGGCACTGATGAGGGTGTCAGTGAAGTGCTTCATGTGGCAGGAGAAAAAAGGCTGCACCGGTGCGTCAGCAGAATATGTGATACAGGATATATTCCGCTTCCTCGCTCACTGACTCGCTACGCTCGGTCGTTCGACTGCGGCGAGCGGAAATGGCTTACGAACGGGGCGGAGATTTCCTGGAAGATGCCAGGAAGATACTTAACAGGGAAGTGAGAGGGCCGCGGCAAAGCCGTTTTTCCATAGGCTCCGCCCCCCTGACAAGCATCACGAAATCTGACGCTCAAATCAGTGGTGGCGAAACCCGACAGGACTATAAAGATACCAGGCGTTTCCCCTGGCGGCTCCCTCGTGCGCTCTCCTGTTCCTGCCTTTCGGTTTACCGGTGTCATTCCGCTGTTATGGCCGCGTTTGTCTCATTCCACGCCTGACACTCAGTTCCGGGTAGGCAGTTCGCTCCAAGCTGGACTGTATGCACGAACCCCCCGTTCAGTCCGACCGCTGCGCCTTATCCGGTAACTATCGTCTTGAGTCCAACCCGGAAAGACATGCAAAAGCACCACTGGCAGCAGCCACTGGTAATTGATTTAGAGGAGTTAGTCTTGAAGTCATGCGCCGGTTAAGGCTAAACTGAAAGGACAAGTTTTGGTGACTGCGCTCCTCCAAGCCAGTTACCTCGGTTCAAAGAGTTGGTAGCTCAGAGAACCTTCGAAAAACCGCCCTGCAAGGCGGTTTTTTCGTTTTCAGAGCAAGAGATTACGCGCAGACCAAAACGATCTCAAGAAGATCATCTTATTAATCAGATAAAATATTTCTAGATTTCAGTGCAATTTATCTCTTCAAATGTAGCACCTGAAGTCAGCCCCATACGATATAAGTTGTAATTCTCATGTTTGACAGCTTATCATCGATAAGCTTTAATGCGGTAGTTTATCACAGTTAAATTGCTAACGCAGTCAGGCACCGTGTATGAAATCTAACAATGCGCTCATCGTCATCCTCGGCACCGTCACCCTGGATGCTGTAGGCATAGGCTTGGTTATGCCGGTACTGCCGGGCCTCTTGCGGGATATCGTCCATTCCGACAGCATCGCCAGTCACTATGGCGTGCTGCTAGCGCTATATGCGTTGATGCAATTTCTATGCGCACCCGTTCTCGGAGCACTGTCCGACCGCTTTGGCCGCCGCCCAGTCCTGCTCGCTTCGCTACTTGGAGCCACTATCGACTACGCGATCATGGCGACCACACCCGTCCTGTGGATCCGGCCCATTGGCTGCCTCCCACACTTGGATATGCCTCCTCGGAGCCTTATAGAATTGTTTATAAGACTTGCGCATTATTTGACCTCCAATGCGAACAAAGGGAAACCGCTGTGGTCTCCCTTTAGTGAGTTCAATTAATTATCCACGGTCAGAAGTGACCAGTTCGTTCTTCTCCCACCAACGCTTAAGGTCGAACGAAGGGCAAGCCTTCGGCGCCACCTCATGATGGGCGCGAAGACCAGCGCCTTCGTACTTAGCCAGCAGTGTGACAAGCAGTGAGCGAAGGGATTGCATTTGGGCTGGCGTAAAGTTAGCGTCGAACTTACCTTTATCGTCGATACCACCAACAAGGCAGACGCCGATAGAGTTGTGGTTGTAACCCTTAGCGTGAGAGCCTACAGCCATCTCATCTCGTCCTGCCTCCACAGTACCGTCTCGCTTGATGATAAAGTGGTATCCCACATCGAGCCAACCCTGCTCTTTGTGCCACTGGCGAATCTCACGGACACCAACATTCTGACTTGGCTTGGTAGCCGAGCAGTGAACAAAGATTGCGTCAGTAGATTCACGTTGTTTAAACTGTACACGAGCCATTATTTCTTTCCTCCTTTCCTTTTTAATCTATCAAAGGGGACCCGGATCCTCTACGCCGGACGCATCGTGGCCGGCATCACCGGCGCCACAGGTGCGGTTGCTGGCGCCTATATCGCCGACATCACCGATGGGGAAGATCGGGCTCGCCACTTCGGGCTCATGAGCGCTTGTTTCGGCGTGGGTATGGTGGCAGGCCCCGTGGCCGGGGGACTGTTGGGCGCCATCTCCTTGCATGCACCATTCCTTGCGGCGGCGGTGCTCAACGGCCTCAACCTACTACTGGGCTGCTTCCTAATGCAGGAGTCGCATAAGGGAGAGCGTCGACCGATGCCCTTGAGAGCCTTCAACCCAGTCAGCTCCTTCCGGTGGGCGCGGGGCATGACTATCGTCGCCGCACTTATGACTGTCTTCTTTATCATGCAACTCGTAGGACAGGTGCCGGCAGCGCTCTGGGTCATTTTCGGCGAGGACCGCTTTCGCTGGAGCGCGACGATGATCGGCCTGTCGCTTGCGGTATTCGGAATCTTGCACGCCCTCGCTCAAGCCTTCGTCACTGGTCCCGCCACCAAACGTTTCGGCGAGAAGCAGGCCATTATCGCCGGCATGGCGGCCGACGCGCTGGGCTACGTCTTGCTGGCGTTCGCGACGCGAGGCTGGATGGCCTTCCCCATTATGATTCTTCTCGCTTCCGGCGGCATCGGGATGCCCGCGTTGCAGGCCATGCTGTCCAGGCAGGTAGATGACGACCATCAGGGACAGCTTCAAGGATCGCTCGCGGCTCTTACCAGCCTAACTTCGATCACTGGACCGCTGATCGTCACGGCGATTTATGCCGCCTCGGCGAGCACATGGAACGGGTTGGCATGGATTGTAGGCGCCGCCCTATACCTTGTCTGCCTCCCCGCGTTGCGTCGCGGTGCATGGAGCCGGGCCACCTCGACCTGAATGGAAGCCGGCGGCACCTCGCTAACGGATTCACCACTCCAAGAATTGGAGCCAATCAATTCTTGCGGAGAACTGTGAATGCGCAAACCAACCCTTGGCAGAACATATCCATCGCGTCCGCCATCTCCAGCAGCCGCACGCGGCGCATCTCGGGCAGCGTTGGGTCCTGGCCACGGGTGCGCATGATCGTGCTCCTGTCGTTGAGGACCCGGCTAGGCTGGCGGGGTTGCCTTACTGGTTAGCAGAATGAATCACCGATACGCGAGCGAACGTGAAGCGACTGCTGCTGCAAAACGTCTGCGACCTGAGCAACAACATGAATGGTCTTCGGTTTCCGTGTTTCGTAAAGTCTGGAAACGCGGAAGTCCCCTACGTGCTGCTGAAGTTGCCCGCAACAGAGAGTGGAACCAACCGGTGATACCACGATACTATGACTGAGAGTCAACGCCATGAGCGGCCTCATTTCTTATTCTGAGTTACAACAGTCCGCACCGCTGTCCGGTAGCTCCTTCCGGTGGGCGCGGGGCATGACTATCGTCGCCGCACTTATGACTGTCTTCTTTATCATGCAACTCGTAGGACAGGTGCCGGCAGCGCCCAACAGTCCCCCGGCCACGGGGCCTGCCACCATACCCACGCCGAAACAAGCGCCCTGCACCATTATGTTCCGGATCTGCATCGCAGGATGCTGCTGGCTACCCTGTGGAACACCTACATCTGTATTAACGAAGCGCTAACCGTTTTTATCAGGCTCTGGGAGGCAGAATAAATGATCATATCGTCAATTATTACCTCCACGGGGAGAGCCTGAGCAAACTGGCCTCAGGCATTTGAGAAGCACACGGTCACACTGCTTCCGGTAGTCAATAAACCGGTAAACCAGCAATAGACATAAGCGGCTATTTAACGACCCTGCCCTGAACCGACGACCGGGTCGAATTTGCTTTCGAATTTCTGCCATTCATCCGCTTATTATCACTTATTCAGGCGTAGCACCAGGCGTTTAAGGGCACCAATAACTGCCTTAAAAAAATTACGCCCCGCCCTGCCACTCATCGCAGTACTGTTGTAATTCATTAAGCATTCTGCCGACATGGAAGCCATCACAGACGGCATGATGAACCTGAATCGCCAGCGGCATCAGCACCTTGTCGCCTTGCGTATAATATTTGCCCATGGTGAAAACGGGGGCGAAGAAGTTGTCCATATTGGCCACGTTTAAATCAAAACTGGTGAAACTCACCCAGGGATTGGCTGAGACGAAAAACATATTCTCAATAAACCCTTTAGGGAAATAGGCCAGGTTTTCACCGTAACACGCCACATCTTGCGAATATATGTGTAGAAACTGCCGGAAATCGTCGTGGTATTCACTCCAGAGCGATGAAAACGTTTCAGTTTGCTCATGGAAAACGGTGTAACAAGGGTGAACACTATCCCATATCACCAGCTCACCGTCTTTCATTGCCATACG"
    }
 }

=cut
use strict;
use warnings;
use Dancer2;
use JSON;
use Bio::Seq;
use Math::Trig;
use POSIX qw(strftime);
use Try::Tiny;
use IPC::Run;
use File::Temp;
use File::Slurp;
use MIME::Base64;
use Template;
use Bio::Restriction::EnzymeCollection;
use Bio::Restriction::Analysis;
use Bio::Tools::Run::StandAloneBlastPlus;
use lib::Prodigal;

use Data::Dumper;

use constant PI => 3.141592654;

set port => 5000;
##################
# Route handler  #
##################

hook before_template => sub {
    # Defining some commonly used urls in the templates.
    my $tokens = shift;
    
    $tokens->{'css_url'} = request->base . 'css/style.css';
    $tokens->{'main_css'} = request->base. 'css/main.css';
    #$tokens->{'bootstrap_css'} = request->base. 'css/bootstrap.min.css';
    $tokens->{'bootstrap_css'} = '//maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css';
    #$tokens->{'bootstrap_js'} = request->base. 'javascripts/bootstrap.min.js';
    $tokens->{'bootstrap_js'} = '//maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js';
    $tokens->{'jquery'} = 'https://code.jquery.com/jquery-2.2.0.min.js';
    #$tokens->{'jquery'} = request->base. 'javascripts/jquery.min.js';
    $tokens->{'angularplasmid'} = request->base. 'javascripts/angularplasmid.complete.min.js';
};

post '/plasmidMapDownload' => sub {
    # for users to download plasmid map as either SVG or PNG.
    my %tokens = params;
    if ($tokens{ext} eq 'png'){
        # PNG is slightly more difficult to handle. Currently, it uses inkscape to do the conversion from SVG to PNG. But inkscape so far doesn't support stdin or stdout. I can use this trick: 'cat | inkscape -z -f /dev/stdin -A /dev/stdout | cat' (http://stackoverflow.com/questions/22658957/how-do-you-pipe-a-long-string-to-dev-stdin-via-child-process-spawn-in-node-js), however, it isn't ver portable. I'll write temp files instead for this problem.
        
        
        my $result = convert_svg(
            dpi     => 300,
            width   => 1000,
            height  => 1000,
            input   => $tokens{data},
        );
        
        #return $ink->result;
        $tokens{data} = encode_base64($result);
    }
    template 'plasmid_map_download.tt', {
        ext     => $tokens{ext},
        data    => $tokens{data},
    }
};

post '/plasmidDraw' => sub {
    my $data = from_json(param "json");
    $data->{map_size} = 500; # the size of the plasmid map
    my ($matches, $orfs, $enzymes, $primers) = draw_plasmid_map($data);
    
    # remove plasmid sequence white spaces
    $data->{plasmid}{seq} =~ s/\s+//g;
    
    # In order to save cpu, store the data for analyse_map
    my $map_data = {
        matches => $matches,
        orfs    => $orfs,
        primers => $primers,
        name    => $data->{plasmid}{name},
        seq     => $data->{plasmid}{seq},
    };
    my $json = to_json($map_data,{utf8 => 1});
    
    # add some urls
    my $analyse_url = uri_for('plasmidAnalyse');
    my $download    = uri_for('plasmidMapDownload');
    
    ############
    template 'plasmid_draw.tt', {
        length      => (length $data->{plasmid}{seq}),
        name        => $data->{plasmid}{name},
        matches     => $matches,
        orfs        => $orfs,
        enzymes     => $enzymes,
        map_size    => $data->{map_size},
        primers     => $primers,
        analyseUrl  => $analyse_url,
        download    => $download,
        map_data    => $json,
    };
};

post '/plasmidAnalyse' => sub {
    # analyse plasmid map with cutting enzymes
    my %enzymes = map {$_ => 1} (split / /, param('enzymes'));
    my $map_size = 500;
    
    # map_data has JSONed map data from draw_map
    my $map_data = param('map_data');
    $map_data = from_json($map_data);
    
    my $plasmid = Bio::Seq->new(
        -display_id => $map_data->{name},
        -seq        => $map_data->{seq},
    );
    $plasmid->is_circular(1);
    my $true_length = $plasmid->length;
    
    #######################################
    # Getting starts, ends and feature_titles from params
    #######################################
    my $starts  = param('start');
    my $ends    = param('end');
    my $titles  = param('title');
    
    # Ignore any row without any of the three elements
    for (my $i = 0; $i < @$starts; $i++){
        next unless ($starts->[$i] && $ends->[$i] && $titles->[$i]);
        
        my $ori = param('ori'.$i);
        
        if ($ori){
            # has orientation
            if ($starts->[$i] <= $ends->[$i]){
                $ori = 1;
            }else{
                $ori = -1;
                my $tmp         = $starts->[$i];
                $starts->[$i]   = $ends->[$i];
                $ends->[$i]     = $tmp;
            }
        }else{
            if ($starts->[$i] > $ends->[$i]){
                my $tmp         = $starts->[$i];
                $starts->[$i]   = $ends->[$i];
                $ends->[$i]     = $tmp;
            }
        }
        
        
        push @{$map_data->{added_features}}, {name => $titles->[$i], colour => ['#01DFA5', '#000'], orient => $ori, start => $starts->[$i], end => $ends->[$i]};
    }
    
    
    ##########################
    # Get restriction sites, TEST AND IT WORKS FOR CIRCULAR DNA.
    # i.e. it recognise sites spanning start/end of the plasmid sequence.
    #########################
    
    my $complete_collection =
    Bio::Restriction::EnzymeCollection->new();
    my $common_collection  =
    Bio::Restriction::EnzymeCollection->new( -empty => 1 );
    
    $common_collection->enzymes(
    grep { exists $enzymes{$_->name()} } $complete_collection->each_enzyme() );
    
    my $ra=Bio::Restriction::Analysis->new(-seq=>$plasmid, -enzymes=>$common_collection);
    
    # Single cutters rendered blue, rest rendered red.
    my $singles = $ra->cutters(1);
    
    my @enzymes;
    
    foreach my $enz ($singles->each_enzyme){
        my @cuts = $ra->positions($enz->name);
        my $theta = $cuts[0]/$true_length * 360;
        push @enzymes, {name => $enz->name, position => $cuts[0], theta => $theta, hadj => 0, vadj => 40, colour => '#00f', site => $enz->site};
    }
    
    #from analyse_map, enzymes have been chosen by user. I guess 50 is a big enough upper limit for a chosen enzyme to cut a plasmid??
    my $all = $ra->cutters(2, 50);
    foreach my $enz ($all->each_enzyme){
        my @cuts = $ra->positions($enz->name);
        @cuts < 2 and next; # ra->cutters(2,50) will return unique cutters when there's no enzymes cut more than once. when there should be no result, it still returns unique cutters.
        for my $cut (@cuts){
            my $theta = $cut/$true_length * 360;
            push @enzymes, {name => $enz->name, position => $cut, theta => $theta, hadj => 0, vadj => 40, colour => '#c00', site => $enz->site};
        }
    }
    my @fragments = $ra->fragment_maps($common_collection);
    for my $frag (@fragments){
        $frag->{start} > $frag->{end} and $frag->{end} += $true_length;
        $frag->{position} = ($frag->{start} + $frag->{end})/2;
    }
    
    my $json = to_json($map_data,{utf8 => 1});
    
    # add some urls
    my $analyse_url = uri_for('plasmidAnalyse');
    my $download    = uri_for('plasmidMapDownload');
    
    #########################
    
    template 'plasmid_analyse.tt', {
        length          => (length $map_data->{seq}),
        name            => $map_data->{name},
        matches         => $map_data->{matches},
        orfs            => $map_data->{orfs},
        added_features  => $map_data->{added_features},
        enzymes         => \@enzymes,
        fragments       => \@fragments,
        map_size        => $map_size,
        primers         => $map_data->{primers},
        analyseUrl      => $analyse_url,
        download        => $download,
        map_data        => $json,
    };
};
#################
# All subs      #
#################

sub draw_plasmid_map {
    # give feature matches and enzyme cuts coordinates. Features are copied from PlasMapper, and drawer powered by AngularPlasmid
    my $tokens = shift;

    my $map_size = $tokens->{map_size}; # the size of the plasmid map
    my (@matches, @enzymes, @orfs, @fragments);
    my $plasmid = Bio::Seq->new(
        -display_id => $tokens->{plasmid}{name},
        -seq        => $tokens->{plasmid}{seq},
    );
    $plasmid->is_circular(1);
    my $true_length = $plasmid->length;
    
    # Get restriction sites, TEST AND IT WORKS FOR CIRCULAR DNA.
    # i.e. it recognise sites spanning start/end of the plasmid sequence.
    #########################
    
    my $complete_collection =
    Bio::Restriction::EnzymeCollection->new();
    my $common_collection  =
    Bio::Restriction::EnzymeCollection->new( -empty => 1 );
    
    if ($tokens->{enzymes}){
        #from analyse_map, enzymes have been chosen by user
        $common_collection->enzymes(
        grep { exists $tokens->{enzymes}->{$_->name()} } $complete_collection->each_enzyme() );
    } else {
        # use default enzymes
        my $enzymes = $tokens->{restrictionEnzymes};
        $common_collection->enzymes(
        grep { exists $enzymes->{$_->name()} } $complete_collection->each_enzyme() );
    }
    my $ra=Bio::Restriction::Analysis->new(-seq=>$plasmid, -enzymes=>$common_collection);
    
    # Single cutters rendered blue, rest rendered red.
    my $singles = $ra->cutters(1);
    
    foreach my $enz ($singles->each_enzyme){
        my @cuts = $ra->positions($enz->name);
        my $theta = $cuts[0]/$true_length * 360;
        push @enzymes, {name => $enz->name, position => $cuts[0], theta => $theta, hadj => 0, vadj => 40, colour => '#00f', site => $enz->site};
    }
    if ($tokens->{enzymes}){
        #from analyse_map, enzymes have been chosen by user. I guess 50 is a big enough upper limit for a chosen enzyme to cut a plasmid??
        my $all = $ra->cutters(2, 50);
        foreach my $enz ($all->each_enzyme){
            my @cuts = $ra->positions($enz->name);
            @cuts < 2 and next; # ra->cutters(2,50) will return unique cutters when there's no enzymes cut more than once. when there should be no result, it still returns unique cutters.
            for my $cut (@cuts){
                my $theta = $cut/$true_length * 360;
                push @enzymes, {name => $enz->name, position => $cut, theta => $theta, hadj => 0, vadj => 40, colour => '#c00', site => $enz->site};
            }
        }
        @fragments = $ra->fragment_maps($common_collection);
        for my $frag (@fragments){
            $frag->{start} > $frag->{end} and $frag->{end} += $true_length;
            $frag->{position} = ($frag->{start} + $frag->{end})/2;
        }
    } else {
        # Currently only get unique and double cutters.
        
        my $doubles = $ra->cutters(2);
        
        for my $enz ($doubles->each_enzyme){
            my @cuts = $ra->positions($enz->name);
            @cuts < 2 and next;
            for my $cut (@cuts){
                my $theta = $cut/$true_length * 360;
                push @enzymes, {name => $enz->name, position => $cut, theta => $theta, hadj => 0, vadj => 40, colour => '#c00', site => $enz->site};
            }
        }
    }
    # propagate overlapping enzymes
    # radius of the plasmid track is map_size/4.
    my $plasmid_radius = $map_size/4 ;
    # sort based on position
    @enzymes = sort {$a->{position} <=> $b->{position}} @enzymes;
    
    propaget_points(\@enzymes, $map_size);
    
    @enzymes = sort {$b->{vadj} <=> $a->{vadj}} @enzymes;
    #########################
    
    #########################
    # predict ORF with Prodigal
    #########################
    my $obj = lib::Prodigal->new(
        dna => $plasmid,
        args => [
            '-p' => 'meta',
            '-c',
        ],
    );
    
    $obj->rewind;
    
    while(my $predict = $obj->next_predict){
        push @orfs, {name => 'Predicted ORF', type => '', colour => ["#04B431", "#04B431"], abbr => 'ORF', orient => $predict->{orient}, start => $predict->{start}, end => $predict->{end}};
    }
    #########################
    
    #########################
    # Get features with blast+ (wrapped by Bio::Tools::Run::StandAloneBlastPlus)
    #########################
    my $fac = Bio::Tools::Run::StandAloneBlastPlus-> new(
        -db_name => 'db/features',
    );
    # Since all plasmids are circular (am I right?), there's a chance that a feature spans across the start/end of a plasmid sequence, and blast fails to find it.
    # So the solution here is to double the seq to do the blast, and if QUERY_END is larger than the original plasmid length, QUERY_START/END - plasmid_length. Unnecessary repeated features are removed by checking if QUERY_START > plasmid_length?
    
    $plasmid->seq($plasmid->seq x 2);
    
    my $all = $fac->blastn(
        -query          => $plasmid,
        -outfile        => 'query.bls',
        -method_args    => [
            '-num_alignments'   => 50,
            '-evalue'           => 0.000001,
            '-task'             => 'blastn-short',
        ]
    );
    $fac->rewind_results;
    
    my $result = $fac->next_result;
    while (my $hit = $result->next_hit){
        next unless $hit;
        while (my $hsp = $hit->next_hsp){
            next if $hsp->{'QUERY_START'} > $true_length; #duplicates on the second plasmid copy. skip
            if (($hsp->{'HIT_LENGTH'} == $hsp->length('hsp')) or ( ($hsp->{'HIT_NAME'} =~ /\[ORI\]/) && ($hsp->{EVALUE} =~ /0.0/)) )  {
                my $identifier = $hsp->{'HIT_NAME'};
                
                if ($hsp->{'QUERY_END'} > $true_length) {
                    # features spanning across start/end of the plasmid sequence.
                    $hsp->{'QUERY_START'} -= $true_length;
                    $hsp->{'QUERY_END'} -= $true_length;
                }
                
                my ($name, $type, $abbr) = ($identifier =~ /([^\[\]]+)\[(\w+)\]\{(\w+)}/);
                my $colour = assign_type_colour($type);
                #check direction:
                my $orient;
                if (($type eq 'ORI') || ($type eq 'REG') || ($type eq 'TER') || ($type eq 'OTH') ){
                    $orient = 0;
                } else {
                    (($hsp->{'HIT_END'}+0) > ($hsp->{'HIT_START'}+0)) ?
                    ($orient = 1) :
                    ($orient = -1);
                }
                push @matches, {name => $name, type => $type, colour => $colour, abbr => $abbr, orient => $orient, start => $hsp->{'QUERY_START'}, end => $hsp->{'QUERY_END'}};
            }
        }
    }
    $fac->cleanup;
    #################
    
    #################
    # Look for primers that could be used on the plasmid
    #################
    
    # only consider 'post'
    my $f_seq = $plasmid->seq; # remember, this is the double sized plasmid sequence.
    my $r_seq = $plasmid->revcom->seq;
    my @primers;
    for my $p (@{$tokens->{primers}}){
        # get rid of white spaces in the primer seqs
        $p->{seq} =~ s/\s+//g;
        while ($f_seq =~ /$p->{seq}/ig){ # forward direction
            $-[0] >= $true_length and last;
            my ($s, $e) = ($-[0], $+[0]);
            if ($e > $true_length){
                $s -= $true_length;
                $e -= $true_length;
            }
            push @primers, {id => $p->{id}, name => $p->{name}, orient => 1, url => $p->{url}, start => $s + 1, end => $e};
        }
        while ($r_seq =~ /$p->{seq}/ig){ # reverse direction
            $-[0] >= $true_length and last;
            my ($s, $e) = ($-[0], $+[0]);
            if ($e > $true_length){
                $s -= $true_length;
                $e -= $true_length;
            }
            push @primers, {id => $p->{id}, name => $p->{name}, orient => -1, url => $p->{url}, start => $true_length - $e + 1, end => $true_length - $s};
        }
    }
    
    
    #################
    
    $tokens->{enzymes} ? (return (\@matches, \@orfs, \@enzymes, \@fragments, \@primers))
    : (return (\@matches, \@orfs, \@enzymes, \@primers));
}

sub propaget_points {
    # trys to propagate enzyme points in a plasmid map, to avoid collision.
    # this version tries to shove the points to the four corners.
    my $enzymes = shift;
    my $size = shift;
    my $plasmid_radius = $size/4;
    # sort based on position
    @$enzymes = sort {$a->{position} <=> $b->{position}} @$enzymes;
    my ($count_tr, $count_bl,) = (0, 0);
    my $count_br = () = grep { ($_->{theta} >= 90) && ($_->{theta} < 180) } @$enzymes;
    my $count_tl = () = grep { ($_->{theta} >= 270) && ($_->{theta} < 360) } @$enzymes;
    for my $enz (@$enzymes) {
        if ( ($enz->{theta} >= 0) && ($enz->{theta} < 90) ){
            # topright
            my $x = $size/2 - 30;
            my $y = $size/2 - 20 - $count_tr * 17;
            my $r = sqrt($x*$x + $y*$y);
            my $theta = atan($y/$x) * 180 / PI;
            $enz->{vadj} = $r - $plasmid_radius;
            $enz->{hadj} = (90 - $theta) - $enz->{theta};
            $count_tr++;
        } elsif ( ($enz->{theta} >= 90) && ($enz->{theta} < 180) ){
            # bottom right, work from bottom to avoid collistion with the topright guys.
            my $x = $size/2 - 28;
            my $y = - $size/2 + $count_br * 17;
            my $r = sqrt($x*$x + $y*$y);
            my $theta = atan($y/$x) * 180 / PI;
            $enz->{vadj} = $r - $plasmid_radius;
            $enz->{hadj} = (90 - $theta) - $enz->{theta};
            $count_br--;
        } elsif ( ($enz->{theta} >= 180) && ($enz->{theta} < 270) ){
            # bottom left
            my $y = - $size/2 + 25;
            my $x = $size/2 - 10 - $count_bl * 17;
            my $r = sqrt($x*$x + $y*$y);
            my $theta = atan($y/$x) * 180 / PI;
            $enz->{vadj} = $r - $plasmid_radius;
            $enz->{hadj} = (180 - $theta) - $enz->{theta};
            $count_bl++;
        } else {
            # top left
            my $x = - $size/2 + 25;
            my $y = $size/2 - 10  - $count_tl * 17;
            my $r = sqrt($x*$x + $y*$y);
            my $theta = atan($y/$x) * 180 / PI;
            $enz->{vadj} = $r - $plasmid_radius;
            $enz->{hadj} = (270 - $theta) - $enz->{theta};
            $count_tl--;
        }
    }
}

sub assign_type_colour {
    # This is to assign colours to types in order to display nicely on a plasmid map
    my $token = shift;
    
    my %types = (
    'ORI' => ['#000', '#fff'],
    'SEL' => ['#ff0', '#000'],
    'PRO' => ['#0f0', '#ff0'],
    'REG' => ['#ff8000', '#fff'],
    'TER' => ['#f0f', '#fff'],
    'TAG' => ['#00f', '#fff'],
    'REP' => ['#c00', '#fff'],
    'HYB' => ['#0ff', '#000'],
    'LOC' => ['#642efe', '#fff'],
    'OTH' => ['#f6cece', '#000'],
    );
    return $types{$token};
}

sub convert_svg {
    # this is to convert svg to png or pdf. Can't implement it as a package using moose and File::Temp. it is in conflict with StandAloneBlastPlus...
    my %tokens = @_;
    
    # output format default to be png.
    $tokens{out_format} ||= 'png';
    
    my $inf = File::Temp->new(SUFFIX => '.svg', DIR => './public/temp');
    my $outf = File::Temp->new();
    # inkscape so far doesn't support stdin or stdout. I can use this trick: 'cat | inkscape -z -f /dev/stdin -A /dev/stdout | cat' (http://stackoverflow.com/questions/22658957/how-do-you-pipe-a-long-string-to-dev-stdin-via-child-process-spawn-in-node-js), however, it isn't ver portable. I'll write temp files instead for this problem.
    #write data in $inf
    print $inf $tokens{input};
    
    # parsing args
    my @args = ('inkscape', '-z'); # silent
    
    # output
    if ($tokens{out_format} eq 'png'){
        push @args, ('-e', $outf->filename);
    } elsif ($tokens{out_format} eq 'pdf'){
        push @args, ('-A', $outf->filename);
    } else {
        warn "out_format for plasmid map image is not understood. take it as png instead...";
        push @args, ('-e', $outf->filename);
    }
    
    # dpi and dimension
    unless ($tokens{out_format} eq 'pdf') {
        push @args, ('-d', $tokens{dpi}, '-w', $tokens{width}, '-h', $tokens{height});
    }
    
    # input
    push @args, $inf->filename;
    
    # run the program
    my ($in, $out, $err);
    try {
        IPC::Run::run \@args, \$in, \$out, \$err;
    }catch{
        warn "Error to run inkscape: $_";
    };
    $err and warn "$err";
    
    my $result = read_file $outf->filename;
    if ($tokens{out_format} eq 'pdf') {
        my $now         = strftime "%Y-%m-%d %H:%M:%S", localtime;
        my $tempfile    = File::Spec->catfile('temp', 'pedigree.'.$now.'.pdf');
        my $cpfile      = File::Spec->catfile('public', $tempfile);
        copy($outf->filename, $cpfile) or die "shit, can't copy";
        send_file $tempfile;
    } else {
        return $result;
    }
}
dance;
