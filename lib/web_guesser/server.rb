require 'sinatra'
require 'sinatra/reloader'

set :secret, rand(100)

set :guesses, 5

get '/' do
  decrement_guesses
  guess = params[:guess].to_i
  message = feedback_for(settings.secret, guess)
  output_style = style_for(settings.secret, guess)

  if correct_guess(settings.secret, guess) || settings.guesses == 0
    reset_game
    message += " A new number has been generated."
  end

  erb  :index, :locals => { :secret_number => settings.secret,
                            :guess         => guess,
                            :guesses_left  => settings.guesses,
                            :message       => message,
                            :output_style  => output_style}
end

def decrement_guesses
  settings.guesses = settings.guesses - 1
end

def correct_guess(number, guess)
  guess == number
end

def reset_game
  settings.guesses = 5
  settings.secret = rand(100)
end

def evaluate_guess(number, guess)
  if guess == number
    :correct
  elsif guess > number + 5
    :way_too_high
  elsif guess > number
    :too_high
  elsif guess < number - 5
    :way_too_low
  else
    :too_low
  end
end

def feedback_for(number, guess)
  case evaluate_guess(number, guess)
    when :too_high then "too high"
    when :way_too_high then "way too high"
    when :too_low then "too low"
    when :way_too_low then "way too low"
    else "correct!"
  end
end

def style_for(number, guess)
  case evaluate_guess(number, guess)
    when :too_high then "too_high"
    when :way_too_high then "way_too_high"
    when :too_low then "too_low"
    when :way_too_low then "way_too_high"
    when :correct then "correct"
  end
end
