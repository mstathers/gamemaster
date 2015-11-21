package story;
# Module which contains all story text for the bot.

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

# Only used for new characters, we always fight the goblin monster (id #1)
sub welcome() {
    my ($self, $nick) = @_;

    my $greeting = qq/The valiant knight $nick approaches! $nick is ready to
    head out to face the evil of the world and rise triumphant over all
    foes!/;
    my $first_combat = qq/As you are traveling up the road, you hear a
    rustling of bushes beside you. With a shriek a goblin jumps out onto the
    road and assaults you with his crude dagger! You must "fight" it!/;

    my $text = &stripper($greeting) . "\n" . &stripper($first_combat);
    return $text;
}

# If a character is supposed to be fighting something but they aren't 
# actually fighting for some reason.
sub afraid() {
    my ($self, $nick, $monster) = @_;

    my $text = qq/The brave knight $nick waits, weapon drawn, for the
    opportune moment to strike the $monster. $nick knows that timing is key
    to this victory!/;

    return &stripper($text);
}

# If the character is victorious!
sub victory() {
    my ($self, $nick, $mon_name, $new_level) = @_;

    my $victory = qq/With an arcing swing of $nick\'s blade, the
    great warrior puts the $mon_name out of its misery for good!/;

    # Specially message if we leveled up.
    if (defined($new_level)) {
        my $level_text = qq/LEVEL UP! $nick is now level $new_level!/;
        my $text = &stripper($victory) . "\n" . &stripper($level_text);
        return $text
    }

    return &stripper($victory);
}





sub quest() {
    my ($self, $nick) = @_;

}

return 1;
