# p6-SQL-NamedPlaceholder

Perl6 port of [SQL::NamedPlaceholder](https://github.com/cho45/SQL-NamedPlaceholder).

# SYNOPSIS

```
use SQL::NamedPlaceholder;

my ($sql, $bind) = bind-named(q[
    SELECT *
    FROM entry
    WHERE
        user_id = :user_id
], {
    user_id => $user_id
});

$dbh.prepare($sql).execute(|$bind);
```

# DESCRIPTION

SQL::NamedPlaceholder is extension of placeholder. This enable more readable and robust code.

# FUNCTION

- [$sql, $bind] = bind-named($sql, $hash);

    The $sql parameter is SQL string which contains named placeholders. The $hash parameter is map of bind parameters.

    The returned $sql is new SQL string which contains normal placeholders ('?'), and $bind is List of bind parameters.

# SYNTAX

- :foobar

    Replace as placeholder which uses value from $hash{foobar}.

- foobar = ?, foobar > ?, foobar < ?, foobar <> ?, etc.

    This is same as 'foobar (op.) :foobar'.

# AUTHOR

astj <asato.wakisaka@gmail.com>

Author of original SQL::NamedPlaceholder in Perl5 is cho45 <cho45@lowreal.net>.

# SEE ALSO

- [SQL::NamedPlaceholder in Perl5](https://github.com/cho45/SQL-NamedPlaceholder)

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
