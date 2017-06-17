class ProcessadorDesempenho

	def processar(partidas)
		partidas.each do |partida|
			desempenho_mandante = partida.mandante.desempenho_mandante
			desempenho_visitante = partida.visitante.desempenho_visitante

			desempenho_mandante.jogos+=1
			desempenho_mandante.gols_feitos+= partida.gols_mandante
			desempenho_mandante.gols_sofridos+= partida.gols_visitante

			desempenho_visitante.jogos+=1
			desempenho_visitante.gols_feitos += partida.gols_visitante
			desempenho_visitante.gols_sofridos += partida.gols_mandante

			if partida.gols_visitante.eql? partida.gols_mandante
			   desempenho_mandante.pontos+=1;
			   desempenho_visitante.pontos+=1;
			elsif partida.gols_visitante < partida.gols_mandante
			   desempenho_mandante.pontos+= 3
			else
			   desempenho_visitante.pontos+=3
			end

			if partida.mandante.id.eql? 265 
				puts desempenho_mandante.gols_sofridos
			end
		end
	end
end