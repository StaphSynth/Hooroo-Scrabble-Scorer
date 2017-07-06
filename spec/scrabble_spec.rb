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

      it 'should raise an error if passed a string containing non-alpha characters' do
        expect{ Scrabble.new.score('!@#$%^&*()[]0123456789/*-+;""<>,./?\'\'') }.to(
          raise_error(ArgumentError, 'Illegal characters in word')
        )
      end
    end

    context 'if passed a legal word and bonus data' do

      it 'should raise an error if the bonus data is not an array' do
        expect{ Scrabble.new.score('abc', :dw) }.to(
          raise_error(ArgumentError, 'Bonus parameter must be an array')
        )
      end

      it 'should raise an error if bonus.legth does not equal word.length' do
        expect{ Scrabble.new.score('abc', [nil,:dw,nil,nil]) }.to(
          raise_error(ArgumentError, 'Bonus array.length must equal word.length')
        )
      end
    end
  end
end
