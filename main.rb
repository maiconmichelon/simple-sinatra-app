require 'sinatra'
require 'sinatra/base'
require 'slim'

require_relative 'processador'

get '/' do
	@processor = Processador.new
	@processor.processar
	slim :'index'
end