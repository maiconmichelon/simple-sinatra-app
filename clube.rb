require_relative 'desempenho'

class Clube
	attr_accessor :id, :nome, :desempenho_visitante, :desempenho_mandante

	def initialize 
		@desempenho_mandante = Desempenho.new
		@desempenho_visitante = Desempenho.new
	end

	def gols_feitos_mandante
		@desempenho_mandante.gols_feitos
	end

	def gols_sofridos_mandante
		@desempenho_mandante.gols_sofridos
	end

	def gols_feitos_visitante
		@desempenho_visitante.gols_feitos
	end

	def gols_sofridos_visitante
		@desempenho_visitante.gols_sofridos
	end

	def aproveitamento_mandante
		@desempenho_mandante.calcAproveitamento
	end

	def aproveitamento_visitante
		@desempenho_visitante.calcAproveitamento
	end
end
