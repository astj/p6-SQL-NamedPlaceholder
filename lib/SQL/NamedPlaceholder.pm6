use v6;

unit module SQL::NamedPlaceholder;

my regex placeholder { <[A..Za..z_]><[A..Za..z0..9_]>* }
my regex operator { '=' || '<=' || '<' || '>=' || '>' || '<>' || '!=' || '<=>' }
my token column-quote { <[`"]> }
sub bind-named (Str $query is copy, %bind-hash --> List) is export {
    my @bind-list;

    # replace question marks as placeholder. e.g. [`hoge` = ?] to [`hoge` = :hoge]
    $query ~~ s:g:s/($<cq>=(<column-quote>?)$<key>=(<placeholder>)$<cq>\s?<operator>\s?)\?/$0\:$0<key>/;

    $query ~~ s:g/\:(<placeholder>)/{
        die "bind parameter $0 is not found." unless %bind-hash{$0}:exists;
        my $value = %bind-hash{$0};
        @bind-list.push($value);
        "?"
    }/;
    return [ $query, @bind-list ];
}
