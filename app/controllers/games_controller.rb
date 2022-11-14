
require "JSON"
require "open-URI"

class GamesController < ApplicationController
  def new
    @pick_letters = []
    10.times do
      @letter = [*?a..?z].shuffle.first
      @pick_letters << @letter
    end
    @pick_letters
  end


  def score
    if session[:comptor].present?
      @comptor = session[:comptor]
    else
      @comptor = 0
    end

    @word = params[:word]
    @url = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_serialized = URI.open(@url).read
    word_check = JSON.parse(word_serialized)
    @check = word_check["found"]
    @word_length = (word_check["length"]).to_i
    if @check == true
    @score_sentence = "Congrats! You found a #{@word_length} letters word."
    @comptor += @word_length
    session[:comptor] = @comptor
    else @check == false
    @score_sentence = "Nice tryyyyy, but no."
    end

  end
end
