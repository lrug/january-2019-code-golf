# Welcome to the LRUG January Ruby Golf Competition!

The idea in golf is to score as low as possible. In Ruby Golf, that means using as
few characters as possible. There are a number of different challenges, or "holes"
to continue the golf metaphor; you don't need to tackle them all, just do what you
can.

It'll probably be more fun to work in teams -- this is a great opportunity to
meet some new people and pick up some new Ruby tricks.

Since you'll need to use the method parameters in your implementation, we've kept
them as short as possible, so as not to waste any precious characters for you :-)

## Get started

In this repository, you should care about two files: `golf.rb` and `golf_test.rb`.
In the former, you write your short implementations. The latter contains tests to make
sure that your implementations work, and also some helper code to count how many
characters you've used.

To get started, take a look at the tests in `golf_test.rb` for "Hole 1", and then
start writing your implementation in the `Golf.hole1` method implementation.

You don't need to attempt all of the holes; if you're stuck or not having fun, just try a different one!

## Scoring

When we calculate your score, we will strip out comments and blank lines, and the
'def' and 'end' lines of the method, but leave everything else. So, to try out
different solutions, just comment out your original one and try a new one underneath
in the same method body

To check your score, simply run the tests using `ruby golf_test.rb`.

## Troubleshooting

If you don't think the scoring is working, run with the `--debug` flag to see some
more information about how we are counting your characters. To avoid breaking this
please ensure the last line of your method is "end # Hole x" - don't remove that
comment!

