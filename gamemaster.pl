#!/usr/bin/env perl
#
# gamemaster daemon

use strict;
use warnings;
no warnings "redefine";
use Bot::BasicBot;
use DBI;
use story;
require "config.pl";

# Some Basic Settings.
my $irc_server = &config_server();
my $irc_port = &config_port();
my $channel = &config_channel();
my $ssl_enable = &config_ssl();
my $nick = &config_nick();
my $sqlite_db = &config_sqlite_db();

# Setup some objects.
my $dbh = DBI->connect("dbi:SQLite:dbname=$sqlite_db","","");
my $story = story->new();


# Some pre-flight checks - this will create the schema.
sub check_db() {
    # Does the table exist in the DB?
    my $select = $dbh->prepare(
        "SELECT * FROM
        sqlite_master where
        name = 'characters'"
    );
    $select->execute();
    my $select_result = $select->fetch();

    # Normally, yes.
    if ( defined($select_result) ) {
        print "DB table exists.\n";
        return 1;
    }

    # If not, we will create the schema.
    print "DB table does not exist yet. Creating...\n";
    my $create_table = $dbh->prepare(
        "CREATE TABLE characters(
        id INTEGER PRIMARY KEY ASC,
        nick TEXT,
        strength INT,
        level INT)"
    );
    $create_table->execute();
    return 1;
}


# MAIN ROUTINE
sub game() {
    my $message = $_[0];

    # Log  message
    print "$message->{who}: $message->{address}\n";

    # Do we recognize this character?
    &check_character($message->{who});
}

# Routine to see if we know a character, or option make a new one.
sub check_character() {
    my $nick = $_[0];

    # Does this nick exist in the DB?
    my $select = $dbh->prepare(
        "SELECT * FROM
        characters where
        nick = '$nick'"
    );
    $select->execute();
    my $select_result = $select->fetch();

    # Normally, yes.
    if ( defined($select_result) ) {
        return undef;
    }

    # But if not, we need to create the new character.
    print "Nick $nick doesn't exist yet. Meet and greet...\n";
    my $insert = $dbh->prepare(
        "INSERT INTO characters
        (nick, strength, level)
        values (
        '$nick',
        10,
        1);"
    );
    $insert->execute();
    # We will send them a welcome message.
    return $story->welcome($nick);
}

sub Bot::BasicBot::said {
    my ($self, $message) = @_;
    my $address = $message->{address};

    # Just for fun.
    if ($message->{body} =~ /rpg/) {
        return "I LOVE RPG's!";
    }

    # Are you talking to me!?
    if ($address && $address eq "$nick") {
        return &game($message);
    }

    # Ignore all else.
    return undef;
}

# Just to change what happens when somebody sends the bot "help"
sub Bot::BasicBot::help {
    return "I am the Game Master! See more about me here: https://github.com/mstathers/gamemaster";
}

# $bot object constructor.
my $bot = Bot::BasicBot->new(
    server => "$irc_server",
    port => "$irc_port",
    ssl => "$ssl_enable",
    channels => ["$channel"],
    nick => "$nick",
);

# Actually get started.
&check_db();
$bot->run();
