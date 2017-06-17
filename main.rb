# require 'sinatra'

require_relative 'processador'

processor = Processador.new
processor.processar

# get '/' do
#   'Hello World'
# end