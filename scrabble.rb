
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
  end

  #returns the word score. Takes arg word: string containing only alpha characters.
  #arg bonus: array of length == word, descibing any special tiles the letters occupy.
  #Symobols used: :dw = double word score, :tw = tripple word score
  #               :dl = double letter score, :tl = tripple letter score
  #               nil = no bonus on that tile
  #
  #EG: [nil, :dw, 'nil', nil], [nil, :tl, nil, :dw, nil, nil, nil], etc
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
    end

    score = 0

    word.chars.each do |char|
      score += @@letter_scores[char.upcase]
    end

    return score
  end
end
