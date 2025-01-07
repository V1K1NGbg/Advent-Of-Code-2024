# perl 21.2.pl

use strict;
use warnings;

my %num_keypad = (
    9 => [2, 0],
    8 => [1, 0],
    7 => [0, 0],
    6 => [2, 1],
    5 => [1, 1],
    4 => [0, 1],
    3 => [2, 2],
    2 => [1, 2],
    1 => [0, 2],
    0 => [1, 3],
    A => [2, 3]
);
my %dir_keypad = (
    "^" => [1, 0],
    A => [2, 0],
    "<" => [0, 1],
    v => [1, 1],
    ">" => [2, 1]
);
my @pointers;
my %valid_num_key_pos;
my %valid_dir_key_pos;

foreach my $key (keys %num_keypad) {
    my ($x, $y) = @{$num_keypad{$key}};
    $valid_num_key_pos{"$x,$y"} = $key;
}

foreach my $key (keys %dir_keypad) {
    my ($x, $y) = @{$dir_keypad{$key}};
    $valid_dir_key_pos{"$x,$y"} = $key;
}

my %move_memo;

sub memoized_move {
    my ($from_key, $to_key, $keypad_ref, $valid_key_pos_ref) = @_;
    my %keypad = %{$keypad_ref};
    my %valid_key_pos = %{$valid_key_pos_ref};

    if (exists $move_memo{$from_key} && exists $move_memo{$from_key}{$to_key}) {
        return $move_memo{$from_key}{$to_key};
    }

    my $command_str = "";
    my ($x, $y) = @{$keypad{$from_key}};
    my ($button_x, $button_y) = @{$keypad{$to_key}};
    my $delta_x = $button_x - $x;
    my $delta_y = $button_y - $y;
    my $x_dir = $delta_x == 0 ? 0 : $delta_x / abs($delta_x);
    my $y_dir = $delta_y == 0 ? 0 : $delta_y / abs($delta_y);

    # Prioritize left, then down, then right, then up
    # Loop twice incase any movements are skipped due to invalid position on keypad
    for my $i (0..1) {
        if ($x_dir == -1 && exists $valid_key_pos{"$button_x,$y"} && $x != $button_x) {
            $x = $button_x;
            $command_str .= "<" x abs($delta_x);
        }

        if ($y_dir == -1 && exists $valid_key_pos{"$x,$button_y"} && $y != $button_y) {
            $y = $button_y;
            $command_str .= "^" x abs($delta_y);
        }

        if ($x_dir == 1 && exists $valid_key_pos{"$button_x,$y"} && $x != $button_x) {
            $x = $button_x;
            $command_str .= ">" x abs($delta_x);
        }

        if ($y_dir == 1 && exists $valid_key_pos{"$x,$button_y"} && $y != $button_y) {
            $y = $button_y;
            $command_str .= "v" x abs($delta_y);
        }
    }

    $command_str .= "A";
    $move_memo{$from_key}{$to_key} = $command_str;

    return $command_str;
}

my %all_paths_memo;

sub get_all_paths {
    my ($from, $to, $keypad_ref, $valid_key_pos_ref) = @_;

    if (exists $all_paths_memo{$from} && exists $all_paths_memo{$from}{$to}) {
        return @{$all_paths_memo{$from}{$to}};
    }

    my %keypad = %{$keypad_ref};
    my %valid_key_pos = %{$valid_key_pos_ref};
    my ($from_x, $from_y) = @{$keypad{$from}};
    my ($to_x, $to_y) = @{$keypad{$to}};
    my $delta_x = $to_x - $from_x;
    my $delta_y = $to_y - $from_y;

    if ($delta_x == 0 && $delta_y == 0) {
        return ("A");
    }

    my $x_dir = $delta_x == 0 ? 0 : $delta_x / abs($delta_x);
    my $y_dir = $delta_y == 0 ? 0 : $delta_y / abs($delta_y);
    my $new_x = $from_x + $x_dir;
    my $new_y = $from_y + $y_dir;
    my $x_char = $x_dir == -1 ? "<" : ">";
    my $y_char = $y_dir == -1 ? "^" : "v";
    my @paths;

    if ($delta_x != 0 && exists $valid_key_pos{"$new_x,$from_y"}) {
        my $new_from = $valid_key_pos{"$new_x,$from_y"};
        my @x_paths = get_all_paths($new_from, $to, $keypad_ref, $valid_key_pos_ref);

        foreach my $path (@x_paths) {
            push(@paths, $x_char.$path);
        }
    }
    if ($delta_y != 0 && exists $valid_key_pos{"$from_x,$new_y"}) {
        my $new_from = $valid_key_pos{"$from_x,$new_y"};
        my @y_paths = get_all_paths($new_from, $to, $keypad_ref, $valid_key_pos_ref);

        foreach my $path (@y_paths) {
            push(@paths, $y_char.$path);
        }
    }

    $all_paths_memo{$from}{$to} = \@paths;
    return @paths;
}

sub calculate_cost {
    my ($command_str, $count) = @_;

    if (length($command_str) == 1 && $command_str eq "A") {
        return 1;
    } if (length($command_str) == 2) {
        my $from = substr($command_str, 0, 1);
        my $to = substr($command_str, 1, 1);
        my $moves = memoized_move($from, $to, \%dir_keypad, \%valid_dir_key_pos);
        my $cost = length($moves);

        if ($count == 0) {
            return $cost;
        } else {
            my $regular_cost = memoized_calculate_cost("A".$moves, $count - 1);

            if ($from ne "<" && $to ne "<") {
                my $first_char = substr($moves, 0, 1);
                my $reverse_moves = reverse(substr($moves, 0, length($moves) - 1))."A";
                my $reverse_cost = memoized_calculate_cost("A".$reverse_moves, $count - 1);

                if ($reverse_cost < $regular_cost) {
                    return $reverse_cost;
                } else {
                    return $regular_cost;
                }
            } else {
                return $regular_cost;
            }
        }
    }

    my $cost = 0;

    for my $i (0..length($command_str) - 2) {
        my $command_substr = substr($command_str, $i, 2);
        $cost += memoized_calculate_cost($command_substr, $count);
    }

    return $cost;
}

my %cost_memo;

sub memoized_calculate_cost {
    my ($command_str, $count) = @_;
    
    if (exists $cost_memo{$command_str} && exists $cost_memo{$command_str}{$count}) {
        return $cost_memo{$command_str}{$count}
    }

    my $result = calculate_cost($command_str, $count);
    $cost_memo{$command_str}{$count} = $result;
    return $result;
}

sub get_all_possible_commands {
    my ($number_str, $i) = @_;

    if ($i >= length($number_str) -1) {
        return ("");
    }

    my $from = substr($number_str, $i, 1);
    my $to = substr($number_str, $i + 1, 1);
    my @paths = get_all_paths($from, $to, \%num_keypad, \%valid_num_key_pos);
    my @remaining_commands = get_all_possible_commands($number_str, $i + 1);
    my @possible_commands;

    foreach my $path (@paths) {
        foreach my $command_str (@remaining_commands) {
            push(@possible_commands, $path.$command_str);
        }
    }

    return @possible_commands
}

open (my $file, "<", "input/21.txt") or die $!;

my $total = 0;

while (my $line = <$file>) {
    chomp($line);

    my $lowest_cost = "inf" + 0;
    my @possible_commands = get_all_possible_commands("A".$line, 0);

    foreach my $command_str (@possible_commands) {
        my $cost = memoized_calculate_cost("A".$command_str, 24);

        if ($cost < $lowest_cost) {
            $lowest_cost = $cost;
        }
    }

    my $numbers = $line;
    $numbers =~ s/\D//g;
    $numbers += 0;
    $total += $lowest_cost * $numbers;
}

close ($file);
print("$total\n");