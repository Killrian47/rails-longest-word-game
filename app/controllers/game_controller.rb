require 'open-uri'
require 'json'

class GameController < ApplicationController
  def new
    # Dictionnary API
    # https://dictionary.lewagon.com/apple

    @letters = []
    10.times { @letters << ("A".."Z").to_a.sample }
  end

  def score
    if session[:score].nil?
      session[:score] = 0
      @score = 0
    else
      @score = session[:score]
    end
    @word = params[:word].downcase.chars
    @letters = params[:letters].downcase.split(" ")
    if call_api(params[:word])["found"]
      @word.each do |letter|
        if @letters.include?(letter)
          @letters.delete_at(@letters.index(letter))
          session[:score] += @word.size**2
          @score = session[:score]
        else
          @error = "Sorry but #{params[:word].upcase} can't be built out of #{params[:letters].upcase}"
        end
      end
    else
      @error = "Sorry but #{params[:word].upcase} does not seem to be a valid English word..."
    end
  end

  private

  def call_api(word)
    url = "https://dictionary.lewagon.com/#{word}"
    response = URI.open(url).read
    JSON.parse(response)
  end
end
