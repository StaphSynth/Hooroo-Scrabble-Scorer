# Hooroo-Scrabble-Scorer

A simple TDD coding exercise to create a Scrabble scorer. Written in Ruby 2.3.1

### Usage
Instantiate a Scrabble object and pass #score a word, it will return the score for that word as well as keep track of the total sum of the scores returned by that instance.
```ruby
game = Scrabble.new
game.score("word")
=> 8
game.total_score
=> 8
```

Optionally, you may also pass a bonuses array and it will apply the bonuses to the word score. The array must be as long as the word, with each element consisting of a symbol that represents the bonus status of the corresponding letter. For example: word = "cat", bonus array = `[:dw,:n,:n]`. The word is "cat" and a double word score is associated with the letter "c". No bonuses are applied to the other letters. The symbols used in the array are: `:n` = nothing, `:dl` = double letter, `:tl` = triple letter, `:dw` = double word, and `:tw` = triple word score.
```ruby
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
