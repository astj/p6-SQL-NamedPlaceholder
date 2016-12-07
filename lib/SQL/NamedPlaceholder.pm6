use v6;

unit module SQL::NamedPlaceholder;

my regex placeholder { \:<[A..Za..z_]><[A..Za..z0..9_]>* }
my regex operator { '=' || '<=' || '<' || '>=' || '>' || '<>' || '!=' || '<=>' }
my token column-quote { <[`"]> }
sub bind-named (Str $query is copy, %bind-hash --> List) is export {
    my @bind-list;

    # replace question marks as placeholder. e.g. [`hoge` = ?] to [`hoge` = :hoge]
    $query ~~ s:g:s/$<left>=(<column-quote>?$<key>=(\S+?)<column-quote>?\s?<operator>\s?)\?/$<left>\:$<left><key>/;

    $query ~~ s:g/(<placeholder>)/{
        my $key = ~$0.substr(1);
        die "bind parameter $key is not found." unless %bind-hash{$key}:exists;
        my $value = %bind-hash{$key};
        @bind-list.push($value);
        "?"
    }/;
    return [ $query, @bind-list ];
}
