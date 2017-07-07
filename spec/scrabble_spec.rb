require 'rspec'
require_relative '../scrabble'

#test spec for scrabble.rb Scrabble word scorer

describe 'Scrabble class' do

  describe 'Score method' do

    context 'if passed an empty word parameter' do

      it 'should return zero if word argument is empty' do
        expect(Scrabble.new.score('')).to eq(0)
      end

      it 'should return zero if word argument is nil' do
        expect(Scrabble.new.score(nil)).to eq(0)
      end
    end

    context 'if passed only a word string and no bonuses data' do

      it 'should not return zero if a string of letters is passed' do
        expect(Scrabble.new.score('abc')).not_to eq(0)
      end

      it 'should raise an error if passed a string containing non-alpha characters' do
        expect{ Scrabble.new.score('!@#$%^&*()[]0123456789/*-+;""<>,./?\'\'') }.to(
          raise_error(ArgumentError, 'Illegal characters in word')
        )
      end
    end

    context 'if passed a legal word, but illegal bonus data' do

      it 'should raise an error if the bonus data is not an array' do
        expect{ Scrabble.new.score('abc', :dw) }.to(
          raise_error(ArgumentError, 'Bonus parameter must be an array')
        )
      end

      it 'should raise an error if bonus.length does not equal word.length' do
        expect{ Scrabble.new.score('abc', [:n,:dw,:n,:n]) }.to(
          raise_error(ArgumentError, 'Bonus array.length must equal word.length')
        )
      end
    end
  end

  describe 'compute_score method' do

    context 'when passed a word and a bonus array' do

      #set empty bonus array
      before(:each) do
        @bonus = [:n,:n,:n,:n,:n,:n,:n,:n]
      end

      it 'should apply the letter bonuses correctly' do
        #without letter bonus
        expect(Scrabble.new.score('oxidizes', @bonus)).to eq(25)
        #with single letter bonus
        @bonus[5] = :tl
        expect(Scrabble.new.score('oxidizes', @bonus)).to eq(45)
        #with multiple letter bonus
        @bonus[1] = :dl
        expect(Scrabble.new.score('oxidizes', @bonus)).to eq(53)
      end

      it 'should apply the word bonuses correctly' do
        #without word bonus
        expect(Scrabble.new.score('oxidizes', @bonus)).to eq(25)
        #single word bonus
        @bonus[2] = :dw
        expect(Scrabble.new.score('oxidizes', @bonus)).to eq(50)
        #multiple word bonus
        @bonus[5] = :tw
        expect(Scrabble.new.score('oxidizes', @bonus)).to eq(150)
      end

      it 'should apply both letter and word bonuses correctly' do
        #without bonus
        expect(Scrabble.new.score('oxidizes', @bonus)).to eq(25)
        #with letter bonus
        @bonus[5] = :tl
        expect(Scrabble.new.score('oxidizes', @bonus)).to eq(45)
        #with word and letter bonus
        @bonus[1] = :dw
        expect(Scrabble.new.score('oxidizes', @bonus)).to eq(90)
      end
    end
  end
end
