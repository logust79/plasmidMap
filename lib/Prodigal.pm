package lib::Prodigal;
use Moose;
use strict;
use warnings;
use 5.18.1;
use Bio::Seq;
use IPC::Run;
use Try::Tiny;
use Carp;
# a simple wrapper for Prodigal

my @global_results;

# confidence cut off
has 'conf' => (
    is          => 'rw',
    isa         => 'Num',
    default     => sub { 100 },
);

# length cut off
has 'length' => (
    is          => 'rw',
    isa         => 'Int',
    predicate   => 'has_length',
);

# The sequence to be analysed. takes Bio::Seq object.
has 'dna' => (
    is          => 'rw',
    isa         => 'Bio::Seq',
    predicate   => 'has_dna',
);

# or provide a file
has 'file' => (
    is          => 'rw',
    isa         =>'Str',
    predicate   => 'has_file',
);

# deposit result
has 'result' => (
    is          => 'ro',
    isa         => 'Str',
    predicate   => 'has_result',
    builder     => '_run',
    lazy        => 1,
);

has 'args' => (
    is          => 'rw',
    isa         => 'ArrayRef[Str]',
    predicate   => 'has_args',
);

sub _run {
    my $self = shift;
    $self->has_dna or $self->has_file or carp ("Has to provide a Bio::Seq object to proceed.");
    $self->has_dna and $self->has_file and carp ("Can't take both a Bio::Seq and file as input.");
    my $in;
    my @args = ('prodigal');
    if ($self->has_dna){
        my $seq = $self->dna->seq;
        # circular Plasmid?
        if ($self->dna->is_circular){
            $seq = $seq x 2;
        }
        $in = '>'.$self->dna->primary_id."\n".$seq;
    }
    if ($self->has_file){
        push @args, ('-i', $self->file);
    }
    if ($self->has_args){
        my @user_args = @{$self->args};
        push @args, (@user_args);
        
    }
    my ($out, $err);
    try {
        IPC::Run::run \@args, \$in, \$out, \$err;
    }catch{
        warn "Error to run Prodigal: $_";
    };
    $err and carp "$err";
    return $out;
}
# reiterate through the result, till it is exausted.
sub next_predict {
    return shift @global_results;
}

# rewind result
sub rewind {
    my $self = shift;
    @global_results = $self->parse_result;
}

# parse result
sub parse_result {
    my $self = shift;
    my $result = $self->result;
    my @results;
    while ($result =~ /^ {5}CDS.*\n(^(?!( {5}CDS)).*\n)+/pgm){
        my $cd = ${^MATCH};
        my %re;
        # orientation?
        $cd =~ /complement\(/ ? ($re{orient} = -1) : ($re{orient} = 1);
        ($re{start}, $re{end}) = ($cd =~ /^ {5}CDS {13}(?:complement\()?(\d+)\.\.(\d+)/ );
        
        # when circular, start may exceed the length of the DNA. get rid of them
        next if $re{start} >= $self->dna->length;
        
        # when circular, the orf length may exceed the one of the DNA
        next if ($re{length} = $re{end} - $re{start}) > $self->dna->length;
        
        # when circular, end may exceed the length of DNA. - length.
        if ($re{end} > $self->dna->length){
            $re{start} -= $self->dna->length;
            $re{end} -= $self->dna->length;
        }
        
        
        (my $sec_line) = ($cd =~ / +\/note="(.*)"\n/);
        my @temp = split ';', $sec_line;
        for my $t (@temp){
            my ($aa, $bb) = split '=', $t;
            $re{$aa} = $bb;
        }
        
        # length and conf cut off?
        next if $re{conf} < $self->conf;
        if ($self->has_length){
            next if $re{length} < $self->length;
        }
        
        push @results, \%re;
    }
    return @results
}
1;