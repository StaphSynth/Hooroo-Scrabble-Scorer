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
        expect{ Scrabble.new.score('abc', [:n,:dw,:n,:n]) }.to(
          raise_error(ArgumentError, 'Bonus array.length must equal word.length')
        )
      end

      it 'should apply the letter bonuses correctly' do
        #without letter bonus
        expect(Scrabble.new.score('oxidizes', [:n,:n,:n,:n,:n,:n,:n,:n])).to eq(25)
        #with single letter bonus
        expect(Scrabble.new.score('oxidizes', [:n,:n,:n,:n,:n,:tl,:n,:n])).to eq(45)
        #with multiple letter bonus
        expect(Scrabble.new.score('oxidizes', [:n,:dl,:n,:n,:n,:tl,:n,:n])).to eq(53)
      end

      it 'should apply the word bonuses correctly' do
        #without word bonus
        expect(Scrabble.new.score('oxidizes', [:n,:n,:n,:n,:n,:n,:n,:n])).to eq(25)
        #single word bonus
        expect(Scrabble.new.score('oxidizes', [:n,:n,:dw,:n,:n,:n,:n,:n])).to eq(50)
        #multiple word bonus
        expect(Scrabble.new.score('oxidizes', [:n,:n,:dw,:n,:n,:tw,:n,:n])).to eq(150)
      end

      it 'should apply both letter and word bonuses correctly' do
        #without bonus
        expect(Scrabble.new.score('oxidizes', [:n,:n,:n,:n,:n,:n,:n,:n])).to eq(25)
        #with letter bonus
        expect(Scrabble.new.score('oxidizes', [:n,:n,:n,:n,:n,:tl,:n,:n])).to eq(45)
        #with word and letter bonus
        expect(Scrabble.new.score('oxidizes', [:n,:dw,:n,:n,:n,:tl,:n,:n])).to eq(90)
      end
    end
  end
end
