# Hooroo-Scrabble-Scorer

A simple TDD coding exercise to create a Scrabble scorer. Written in Ruby 2.3.1

### Usage
```ruby
game = Scrabble.new
game.score("word")
=> 8
game.total_score
=> 8
#optional bonuses array. :dw = double word score. :n = none
bonus = [:n,:n,:dw,:n,:n,:n,:n]
game.score("cabbage", bonus)
=> 28
game.total_score
=> 36
```

### Running the tests
```terminal
$ cd path/to/repo
$ bundle install
$ bundle exec rspec
```
