use v6;

unit module SQL::NamedPlaceholder;

my regex placeholder { \:<[A..Za..z_]><[A..Za..z0..9_]>* }
sub bind-named (Str $query is copy, %bind-hash --> List) is export {
    my @bind-list;
    $query ~~ s:g/(<placeholder>)/{
        my $key = ~$0.substr(1);
        die "bind parameter $key is not found." unless %bind-hash{$key}:exists;
        my $value = %bind-hash{$key};
        @bind-list.push($value);
        "?"
    }/;
    return [ $query, @bind-list ];
}
