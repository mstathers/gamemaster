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
    my $first_combat = qq/As $nick travels up the road, the knight hears a
    rustling of bushes nearby. With a loud shriek a goblin jumps out onto
    the road and assaults knight $nick with a crude dagger! $nick can either
    "fight" or "flee" from it./;

    my $text = &stripper($greeting) . "\n" . &stripper($first_combat);
    return $text;
}

# If the character is victorious!
sub victory() {
    my ($self, $nick, $monster, $new_level) = @_;

    my $victory = qq/With an arcing swing of $nick\'s shining blade, the
    heroic knight puts the $monster out of its misery for good! $nick is
    rewarded only in knowing that the $monster will not be able to continue
    terrorizing the local people any longer./;

    # Specially message if we leveled up.
    if (defined($new_level)) {
        my $level_text = qq/LEVEL UP! $nick is now level $new_level!/;
        my $text = &stripper($victory) . "\n" . &stripper($level_text);
        return $text
    }

    return &stripper($victory);
}

# defeat
sub defeat() {
    my ($self, $nick, $monster) = @_;

    my $text = qq/Suffering from a unfortunate defeat against the mighty
    $monster, $nick picks himself up and limps back up the road. The valiant
    knight vows to return in order to destroy the evil $monster, once and
    for all!/;

    return &stripper($text);
}

# Flee for your live!
sub flee() {
    my ($self, $nick, $monster) = @_;

    my $text = qq/Uncharacteristically, the brave knight $nick makes an
    expeditious retreat from the $monster at the first opportunity, leaving
    only pride behind!/;

    return &stripper($text);
}

# If a character is supposed to be fighting something but they aren't 
# actually fighting for some reason.
sub waiting() {
    my ($self, $nick, $monster) = @_;

    my $text = qq/The brave knight $nick waits, weapon drawn, for the
    opportune moment to strike the $monster. $nick knows that timing is key
    to this battle! $nick is getting ready to either "fight" or "flee" the
    $monster./;

    return &stripper($text);
}

sub new_quest() {
    my ($self, $nick, $monster) = @_;

    #TODO Perhaps we should store these in DB so that they can be different
    #     for each monster?
    my $text = qq/A frightening $monster jumps out at $nick. $nick must
    choose to either "fight" it or "flee" from it.
    /;

    return &stripper($text);
}

return 1;
