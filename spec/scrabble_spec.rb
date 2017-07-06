require 'rspec'
require_relative '../scrabble'

#test spec for scrabble.rb Scrabble word scorer

describe 'Scrabble class' do

  describe 'Score method' do

    it 'should return zero if word argument is empty' do
      expect(Scrabble.new().score('')).to eq(0)
    end

    it 'should return zero if word argument is nil' do
      expect(Scrabble.new().score nil).to eq(0)
    end
  end
end
