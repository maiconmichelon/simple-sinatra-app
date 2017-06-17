require 'json'
require 'rest-client'

require_relative 'clube'
require_relative 'partida'
require_relative 'processador_desempenho'

class Processador
	attr_accessor :clubes, :partidas_terminadas, :partidas_rodada_atual, :rodada_atual

	def processar
		json_rodada_atual = request('https://api.cartolafc.globo.com/partidas')

		processa_numero_rodada_atual(json_rodada_atual)
		processar_clubes(json_rodada_atual)
		processar_partidas_todas_rodadas(json_rodada_atual)

		ProcessadorDesempenho.new.processar(@partidas_terminadas)
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

	def processa_numero_rodada_atual(json_rodada_atual) 
		@rodada_atual = json_rodada_atual["rodada"]
	end

	def processar_partidas_todas_rodadas(json_rodada_atual)
		@partidas_terminadas = Array.new
		@partidas_rodada_atual = Array.new

		rodadas_completas = @rodada_atual - 1
		(1..rodadas_completas).each do |rodada|
			json_rodada = request("https://api.cartolafc.globo.com/partidas/#{rodada}")
			processar_partidas_rodada(json_rodada, @partidas_terminadas)
		end

		processar_partidas_rodada(json_rodada_atual, @partidas_rodada_atual)
	end

	def processar_partidas_rodada(json_rodada, array_partidas)
		json_rodada["partidas"].each do |json_partida|
			partida = Partida.new

			partida.mandante = @clubes[json_partida["clube_casa_id"]]
			partida.visitante = @clubes[json_partida["clube_visitante_id"]]

			partida.gols_mandante = json_partida["placar_oficial_mandante"]
			partida.gols_visitante = json_partida["placar_oficial_visitante"]

			array_partidas << partida
		end
	end

end