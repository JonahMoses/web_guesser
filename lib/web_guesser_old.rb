require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(0...100)

get '/' do
  guess = params["guess"]
  message = check_guess(guess)
  erb :index, :locals => {:number => SECRET_NUMBER, :message => message}
end

def check_guess(guess)
  if params["guess"].to_i == 0
    message = "Make a guess"
    number = "Between 0 and 100"
  elsif params["guess"].to_i > SECRET_NUMBER + 5
    message = "Way too high!"
    number = "A secret!"
  elsif params["guess"].to_i > SECRET_NUMBER
    message = "Too High!"
    number = "A secret!"
  elsif params["guess"].to_i == SECRET_NUMBER
    message = "You got it right!"
  elsif params["guess"].to_i < SECRET_NUMBER - 5
    message = "Way too low!"
    number = "A secret!"
  elsif params["guess"].to_i < SECRET_NUMBER
    message = "Too Low!"
    number = "A secret!"
  end
end


