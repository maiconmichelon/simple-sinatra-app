require_relative 'desempenho'

class Clube
	attr_accessor :id, :nome, :desempenho_visitante, :desempenho_mandante

	def initialize 
		@desempenho_mandante = Desempenho.new
		@desempenho_visitante = Desempenho.new
	end

end
