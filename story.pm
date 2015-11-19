package story;

# Modele which contains all story text for the bot.

# New constructor for object.
sub new() {
    my $class = shift;
    return bless{}, $class;
}

sub welcome() {
    my ($self, $nick) = @_;

    my $text = "The valiant knight $nick approaches! $nick is ready to " .
    "head out to face the evil of the world and rise triumphant over all " .
    "foes!";

    return $text;
}

return 1;
