
class Scrabble
  def initialize
    @@letter_scores = {
      'A' => 1, 'B' => 3, 'C' => 3, 'D' => 2,
      'E' => 1, 'F' => 4, 'G' => 2, 'H' => 4,
      'I' => 1, 'J' => 8, 'K' => 5, 'L' => 1,
      'M' => 3, 'N' => 1, 'O' => 1, 'P' => 3,
      'Q' => 10, 'R' => 1, 'S' => 1, 'T' => 1,
      'U' => 1, 'V' => 4, 'W' => 4, 'X' => 8,
      'Y' => 4, 'Z' => 10
    }

    @@bonus_multipliers = {
      n: 1, dw: 2,
      tw: 3, dl: 2,
      tl: 3
    }

    @total_score = 0
  end

  attr_reader :total_score

  #returns the word score and adds to the total. Takes arg word: string containing only alpha characters.
  #arg bonus: optional array of length == word, descibing any special tiles the letters occupy.
  #Symobols used: :dw = double word score, :tw = tripple word score
  #               :dl = double letter score, :tl = tripple letter score
  #               :n = no bonus on that tile
  #
  #EG: [:n, :dw, :n, :n], [:n, :tl, :n, :dw, :n, :n, :n], etc
  def score(word, bonus = nil)
    if(!word || word.empty?)
      return 0
    end

    if(/[^a-zA-Z]/.match(word))
      raise ArgumentError, 'Illegal characters in word'
    end

    if(bonus)
      if(!bonus.kind_of?(Array))
        raise ArgumentError, 'Bonus parameter must be an array'
      elsif(bonus.length != word.length)
        raise ArgumentError, 'Bonus array.length must equal word.length'
      end
    else
      #if no bonus array exists, create an 'empty' one
      bonus = Array.new(word.length, :n)
    end

    #zip the word chars with the bonus array so that letters are associated with their bonuses
    word_layout = word.chars.zip(bonus)
    score = compute_score(word_layout)
    @total_score += score
    return score
  end

  private

    #returns the word score including the effects of any bonus squares
    #accepts a nested array of arrays containing the letter and bonus info
    #Eg: word_layout = [['f', :n], ['u', :dw], ['n', :n]]
    def compute_score(word_layout)
      score = 0
      word_multiplier = 1
      letter_multiplier = 1

      #loop over the layout array and apply the bonus logic and maths
      word_layout.each do |char, bonus|
        letter_multiplier = 1

        case bonus
        when nil, :n
        when :dl, :tl
          letter_multiplier = @@bonus_multipliers[bonus]
        when :dw, :tw
          word_multiplier *= @@bonus_multipliers[bonus]
        end

        score += @@letter_scores[char.upcase] * letter_multiplier
      end

      return score * word_multiplier
    end
end
