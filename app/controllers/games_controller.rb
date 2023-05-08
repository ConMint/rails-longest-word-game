require 'open-uri'

class GamesController < ApplicationController
  def new
    @letters = (0..9).map { (65 + rand(26)).chr }
  end

  def score
    @guess = params[:guess].upcase
    @letters = params[:letters].split(' ')
    booleans = @guess.chars.map do |char|
      @guess.count(char) <= @letters.count(char.upcase)
    end
    url = "https://wagon-dictionary.herokuapp.com/#{@guess.downcase}"
    word_data = JSON.parse(URI.open(url).read)
    if @guess.length > 10
      @message = 'That word is too long!'
    elsif booleans.include?(false)
      @message = 'Not in the grid'
    elsif word_data['found']
      @message = 'Well done!'
    else
      @message = 'Not an English word'
    end
  end
end
