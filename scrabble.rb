
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

  #returns the word score. Takes arg word: string containing only alpha characters.
  #arg bonus: array of length == word, descibing any special tiles the letters occupy.
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
      bonus = Array.new(word.length)
    end

    score = compute_score(word, bonus)
    @total_score += score
    return score
  end

  private
    def compute_score(word, bonus)
      score = 0

      word = word.chars.zip(bonus)
      word.each do |char, bonus|
        score += @@letter_scores[char.upcase]
      end
      return score
    end
end

puts Scrabble.new.score("oxidizes")
