my @all = qw/ a b c d e f /;

&power_set( @all );

sub power_set {
    my @all = @_;
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
    print Dumper( \@sets ); use Data::Dumper;
}
