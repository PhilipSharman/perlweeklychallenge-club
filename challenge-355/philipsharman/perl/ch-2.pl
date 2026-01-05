#!/usr/local/bin/perl
##############################################################################################################
#	Perl Weekly Challenge 355 - Task 2
#	===================================
#	"You are given an array of integers, @ints.
#	Write a script to return true if the given array is a valid mountain array."
#
#	Note:
#	- We assume the input is all non-negative.
#
# 	See:
#		https://theweeklychallenge.org/blog/perl-weekly-challenge-355/#TASK2
#
# 	v 1.0 	- Written by Philip Sharman, 2026-01-05
##############################################################################################################
use 5.36.0;
use strict;
use boolean qw(true false);
use Test::More 'tests' => 8;

##############################################################################################################
###     GLOBALS                                                                                            ###
##############################################################################################################
my $VERBOSE = true;

##############################################################################################################
###     MAIN                                                                                               ###
##############################################################################################################
test_1();
test_2();
test_3();
test_4();
test_5();
test_6();
test_7();
test_8();

say "Done.";

##############################################################################################################
##      TESTS	                                                                                           ###
##############################################################################################################
sub test_1 {
	my @input          = (1, 2, 3, 4, 5);
	my $result         = examine( @input );
	my $expectedResult = false;
	is( $result, $expectedResult, 'Test 1' );
}

sub test_2 {
	my @input          =  ( 0, 2, 4, 6, 4, 2, 0 ); 
	my $result         = examine(@input);
	my $expectedResult = true;
	is( $result, $expectedResult, 'Test 2' );
}

sub test_3 {
	my @input          = (5, 4, 3, 2, 1);
	my $result         = examine(@input);
	my $expectedResult = false;
	is( $result, $expectedResult, 'Test 3' );
}

sub test_4 {
	my @input          = (1, 3, 5, 5, 4, 2);
	my $result         = examine(@input);
	my $expectedResult = false;
	is( $result, $expectedResult, 'Test 4' );
}

sub test_5 {
	my @input          = (1, 3, 2);
	my $result         = examine(@input);
	my $expectedResult = true;
	is( $result, $expectedResult, 'Test 5' );
}

# Check short input
sub test_6 {
	my @input          = (1, 2);
	my $result         = examine(@input);
	my $expectedResult = false;
	is( $result, $expectedResult, 'Test 6' );
}

# Check all-equal input
sub test_7 {
	my @input          = (9, 9, 9);
	my $result         = examine(@input);
	my $expectedResult = false;
	is( $result, $expectedResult, 'Test 7' );
}

# Check empty input
sub test_8 {
	my @input          = ();
	my $result         = examine(@input);
	my $expectedResult = false;
	is( $result, $expectedResult, 'Test 8' );
}

##############################################################################################################
##      SUBROUTINES                                                                                        ###
##############################################################################################################
sub examine( @array ) {
	if ( scalar( @array ) < 3 ) {
		return false;
	}
	say "Examining array: " . join(',', @array) if $VERBOSE;

	# 1) Find the maximum
	my $max = 0;
	my $position;
	my $i = 0;
	for my $element ( @array ) {
		die if $element < 0;    # We assume all the input is positive
		if ( $element > $max ) {
			$position = $i;
			$max      = $element;
		}
		$i++;
	}
	say "Found maximum $max at position $position." if $VERBOSE;

	# The maximum must not be at the beginning
	return false if $position == 0;
	
	# The maximum must not be at the end
	return false if $position == scalar(@array) - 1;

	# 2) Check the positions before and including the maximum
	for ( my $i = 0 ; $i < $position ; $i++ ) {
		my $element1 = $array[ $i ];
		my $element2 = $array[ $i + 1 ];
		say "Checking ascent: $element1 versus $element2" if $VERBOSE;
		if ( $element1 >= $element2 ) {
			return false;
		}
	}

	# 3) Check the positions at the maximum and after it
	for ( my $i = $position ; $i < scalar( @array ) - 1 ; $i++ ) {
		my $element1 = $array[ $i ];
		my $element2 = $array[ $i + 1 ];
		say "Checking descent: $element1 versus $element2" if $VERBOSE;
		if ( $element1 <= $element2 ) {
			return false;
		}
	}

	return true;
}

##############################################################################################################
