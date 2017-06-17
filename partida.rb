class Partida
	attr_accessor :mandante, :visitante, :gols_mandante, :gols_visitante

	def initialize
		gols_mandante = 0
		gols_visitante = 0
	end

	def calcularAproveitamento
		desempenho_mandante.aproveitamento - desempenho_visitante.aproveitamento
	end

	private
	def desempenho_mandante
		@mandante.desempenho_mandante
	end

	def desempenho_visitante
		@mandante.desempenho_visitante
	end

end