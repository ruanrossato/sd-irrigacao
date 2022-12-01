module regador (
	input clk, //clock at 60Hz
	input btCima,
	input btBaixo,
	input btConfirma,
	input btDelete,
	inout estado;
	output [11:0] display,
	output pump1,
	output pump2,
	output pump3
	);

	reg plantaAtual [2:0] = 00;
	reg planta1Timer [4:0] = 0000;
	reg planta2Timer [4:0] = 0000;
	reg planta3Timer [4:0] = 0000;
	reg atualizaHora [4:0] = 0001;
	display = 000100100001; //1

	@always(estado == 0  ) begin // selecionar numero da planta
		if(btCima == 1) begin
			plantaAtual = plantaAtual +1
		end

		if(btBaixo == 1) begin
			plantaAtual = plantaAtual -1
		end

		if(plantaAtual == 11)begin
			plantaAtual = 00;
		end

		if(plantaAtual == 0)begin

			display = 000100100001; //1
		
		else if(plantaAtual == 01)begin

			display = 110010100011; //2
		
		else if(plantaAtual == 10)begin

			display = 010110100011; //3
		end

		if(btConfirma) begin
			estado = 1;
		end

	end

	@always(estado == 1  ) begin // selecionar período de rega em dias
		display = 000100100001; //1
		
		if(btCima == 1) begin
			atualizaHora = atualizaHora +1;
		end

		if(btBaixo == 1) begin
			atualizaHora = atualizaHora -1;
		end

		
		if(atualizaHora == 0)begin
			display = 000100100001; //1
		
		else if(plantaAtual == 01)begin

			display = 110010100011; //2
		
		else if(plantaAtual == 10)begin

			display = 010110100011; //3
		end

		if(btConfirma) begin
			if(plantaAtual == 00) begin
				planta1Timer = atualizaHora;

			else if(plantaAtual == 01) begin
				planta2Timer = atualizaHora;

			else if(plantaAtual == 10) begin
				planta3Timer = atualizaHora;
			end

			estado = 0;
		end
		
	end		



end module