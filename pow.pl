my @all = qw/ a b c d e f /;

sub power_set {
    my @all = @_;
    #my @sets = [];
    my @sets = ();
    #ignore the empty set?
    while (@all) {
        my $next = shift;
        push @sets, [$next];
        my @new_sets;
        foreach my $set (@sets) {
            push @new_sets, [ $next, @$set ];
            }

            
    }
}
