class Desempenho
	attr_accessor :jogos, :pontos, :gols_feitos, :gols_sofridos

	def initialize
		@jogos = @pontos = @gols_feitos = @gols_sofridos = 0
	end

	def calcAproveitamento
		@pontos * 100 / (@jogos * 3)
	end
end
