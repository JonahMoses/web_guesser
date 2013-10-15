require 'sinatra'
require 'sinatra/reloader'

set :secret, rand(100)

set :guesses, 5

get '/' do
  settings.guesses = settings.guesses - 1
  guess = params[:guess].to_i
  message = feedback_for(settings.secret, guess)

  if correct_guess(settings.secret, guess) || settings.guesses == 0
    reset_game
    message += " A new number has been generated."
  end

  erb  :index, :locals => { :secret_number => settings.secret,
                            :guess => guess,
                            :guesses_left => settings.guesses,
                            :message => message }
end

def correct_guess(number, guess)
  guess == number
end

def reset_game
  settings.guesses = 5
  settings.secret = rand(100)
end

def feedback_for(number, guess)
  if guess == number
    message = "Correct!"
  elsif guess > number + 5
    "way too high!"
  elsif guess > number
    "too high!"
  elsif guess < number - 5
    "way too low!"
  elsif guess < number
    "too low!"
  end
end

