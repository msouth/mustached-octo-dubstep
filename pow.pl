use strict;
use warnings;
#my @all = qw/ a b c d e f /;
#my @all = qw/ a b c /;#d e f /;

#&power_set( @all );

print Dumper \[ &grab_em(7, apple=>7) ];

sub power_set {
    my @all = @_;
    my $size = scalar (@all); # I know there should be 2**n, so I'm saving so I can check 
    #my @sets = [];
    my @sets = ([]);
    #ignore the empty set?
    while (@all) {
        # get the next thing off the list
        my $next = shift @all;
        # maybe this is my bug?  I need to start with the empty set, and not tread this
        # singleton set special--it's just x composed with the empty set: push @sets, [$next];
        # collect the new sets--all the previoius ones, plus this guy
        my @new_sets;
        foreach my $set (@sets) {
            push @new_sets, [ $next, @$set ];
        }
        push @sets, @new_sets;
    }
    return @sets;
    #print "original size: $size, 2**that = ". 2**$size. ", power set size is ", scalar @sets, $/; 
    #print Dumper( \@sets ); use Data::Dumper;
}

sub grab_em {
    my $target = shift;
    my %weight = @_;

    my @solutions;
    foreach my $key ( keys %weight ) {
        # get rid of the food if the value is greater than the
        # target--saves us a power of two worth of checks
        delete $weight{$key} if $weight{$key} > $target;
        # zero-weight foods are not interesting--if people
        # really want them, we can compute the solution without
        # them, then add the power set of them to every regular 
        # solution.  Probably people don't want them, we might
        # even die here calling it bad data.
        delete $weight{$key} unless $weight{$key};
    }

    my @foods = keys %weight;

    my @sets_of_foods  = &power_set( @foods );
    foreach my $possible (@sets_of_foods) {
        my $total = 0;
        # in the case of natural number (positive integer) inputs, we can
        # discard any set that has more elements than 
        # $target, since we know from my assumption above
        # that they are at least 1;
        # next if scalar @$possible > $target;

        # depending on data might check the total as we go and jump
        # out if it crosses total and we don't allow negative weights.
        # all of this rather than check as we go before 
        $total += $weight{ $_ } for @$possible;
        if ($total == $target) {
            #we have a winner
            push @solutions, $possible;
        }
    }
    return @solutions;
}
