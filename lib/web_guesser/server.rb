require 'sinatra'
require 'sinatra/reloader'

number = rand(100)

get '/' do
  guess = params[:guess].to_i
  message = feedback_for(number, guess)
  erb  :index, :locals => { :secret_number => number,
                            :guess => guess,
                            :message => message }
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
