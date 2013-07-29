#my @all = qw/ a b c d e f /;
my @all = qw/ a b c /;#d e f /;

&power_set( @all );

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

    foreach my $key ( keys %weight ) {
        # get rid of the food if the value is greater than the
        # target--saves us a power of two worth of checks
        delete $candidate{$key} if $candidate{$key} > $target;
        # zero-weight foods are not interesting--if people
        # really want them, we can compute the solution without
        # them, then add the power set of them to every regular 
        # solution.  Probably people don't want them, we might
        # even die here calling it bad data.
        delete $candidate{$key} unless $candidate{$key};
    }

    my @foods = keys %weight;

    my @sets_of_foods  = &power_set( @foods );
    foreach my $possible (@sets_of_foods) {
        my $total = 0;
        # in the case of natural number inputs, we can
        # discard any set that has more elements than 
        # $target, since we know from my assumption above
        # that they are at least 1;
        while (@$possible) {
            my $food = shift @$possible;
            $total += $weight{ $food };
            # we could jump out here (labeling the foreach and using next LABEL)
            # if the total is over $target, as long as we are not allowing
            # helium balloons.  So, in case negative weights are desired, we can 
            # 
        }
    }
}
