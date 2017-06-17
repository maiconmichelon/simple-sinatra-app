require 'json'
require 'rest-client'

require_relative 'clube'
require_relative 'partida'
require_relative 'processador_desempenho'

class Processador
	attr_accessor :clubes, :partidas, :rodada_atual

	def processar
		json_rodada_atual = request('https://api.cartolafc.globo.com/partidas')

		processa_rodada_atual(json_rodada_atual)
		processar_clubes(json_rodada_atual)
		processar_partidas_todas_rodadas()

		ProcessadorDesempenho.new.processar(@partidas)
	end

	private 
	def request(url)
		JSON.parse(RestClient.get(url))
	end

	def processar_clubes(json_rodada_atual)
		@clubes = Hash.new

		json_rodada_atual["clubes"].each do |clube_response|
			clube = Clube.new
			clube.id = clube_response[1]["id"]
			clube.nome = clube_response[1]["nome"]

			@clubes[clube.id] = clube
		end
	end

	def processa_rodada_atual(json_rodada_atual) 
		@rodada_atual = json_rodada_atual["rodada"]
	end

	def processar_partidas_todas_rodadas
		@partidas = Array.new
		rodadas_completas = @rodada_atual - 1
		(1..rodadas_completas).each do |rodada|
			json_rodada = request("https://api.cartolafc.globo.com/partidas/#{rodada}")
			processar_partidas_rodada(json_rodada)
		end
	end

	def processar_partidas_rodada(json_rodada)
		json_rodada["partidas"].each do |json_partida|
			partida = Partida.new

			partida.mandante = @clubes[json_partida["clube_casa_id"]]
			partida.visitante = @clubes[json_partida["clube_visitante_id"]]

			partida.gols_mandante = json_partida["placar_oficial_mandante"]
			partida.gols_visitante = json_partida["placar_oficial_visitante"]

			@partidas << partida
		end
	end

end