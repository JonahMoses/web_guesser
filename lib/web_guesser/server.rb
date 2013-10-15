require 'sinatra'
require 'sinatra/reloader'

get '/' do
  "Hello, World. The random number is #{ rand(100) }"
end
