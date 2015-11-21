package story;
# Modele which contains all story text for the bot.

use strict;
use warnings;

# New constructor for object.
sub new() {
    my $class = shift;
    return bless{}, $class;
}

# Trim leading whitespace and replace \n with ' '.
# Used to make formatting of story text more readable.
#  This is not meant to be called from the main script, only 
#  from here.
sub stripper() {
    my $text = shift;
    # get rid of leading whitespace
    $text =~ s/^\s+//gm;
    # change \n to ' '
    $text =~ s/\n/ /g;
    return $text;
}

sub welcome() {
    my ($self, $nick) = @_;

    my $greeting = qq/The valiant knight $nick approaches! $nick is ready to
    head out to face the evil of the world and rise triumphant over all
    foes!/;
    my $first_combat = qq/As you are travelling up the road, you hear a
    rustling of bushes beside you. With a shreak a goblin jumps out onto the
    road and assults you with his crude dagger! You must "fight" it!/;

    my $text = &stripper($greeting) . "\n" . &stripper($first_combat);
    return $text;
}

sub quest() {
    my ($self, $nick) = @_;

}

return 1;
