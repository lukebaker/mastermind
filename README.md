# Praetorian Bootcamp - Mastermind

This code solves the [Mastermind challenge](https://www.praetorian.com/challenges/mastermind/) using Ruby 2.2.2.

## Description

The challenge is a variation on the [board game known as Mastermind](https://en.wikipedia.org/wiki/Mastermind_%28board_game%29). My primary approach is similar to the [algorithm demonstrated by Knuth](https://en.wikipedia.org/wiki/Mastermind_%28board_game%29#Five-guess_algorithm). However, instead of applying the minimax technique to determine the next best guess, I simply select a random guess from the remaining possible options. This random guess approach has surprising good results in the Mastermind board game according to Swaszek (1999-2000) and worked well enough here. Level 6 occasionally failed due to too many guesses, but succeeded more often than not in my attempts.

The other wrinkle is that Level 4 included many more possible permutations (~127.5 million) than could be achieved within the time constraints (no more than 10 seconds between each guess). However, the level also allowed for more total guesses than would be needed for an optimal solution. For this level, I chose to use less optimal guesses in an attempt to reduce the number of possible "weapons", which will in turn reduce the total number of remaining possible permutations to a reasonable number. Once I have a manageable set of remaining possible guesses, I can continue with the usual algorithm to complete the level. Reducing the number of possible weapons is similar to the algorithm used elsewhere, except it is concerned only with unique weapon combinations (rather than all permutations) and unconcerned with the accurate order of weapon used.
