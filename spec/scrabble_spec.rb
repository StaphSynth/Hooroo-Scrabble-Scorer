require 'rspec'
require_relative '../scrabble'

#test spec for scrabble.rb Scrabble word scorer

describe 'Scrabble class' do

  describe 'Score method' do

    it 'should return zero if word argument is empty' do
      expect(Scrabble.new.score('')).to eq(0)
    end

    it 'should return zero if word argument is nil' do
      expect(Scrabble.new.score(nil)).to eq(0)
    end

    context 'if passed only a word string and no bonuses data' do

      it 'should not return zero if a string of letters is passed' do
        expect(Scrabble.new.score('abc')).not_to eq(0)
      end

      it 'should return the sum of the letter score values' do
        expect(Scrabble.new.score('abc')).to eq(7)
      end

    end
  end
end
