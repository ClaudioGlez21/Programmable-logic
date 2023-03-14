module PWM_Servo(
input rst_a, clk,
input [9:0] SW,
output reg PWM_out
);

reg[31:0]counter_aux;
reg[31:0] comparador;
wire clk_div_wire;

ClockDivider CLKDIV(
.clk(clk),
.rst_a(rst_a),
.clk_div(clk_div_wire)
);

parameter C_MAX= 20000;

always @(posedge clk_div_wire or negedge rst_a)
begin
	if(!rst_a)
	begin
		counter_aux <=0;
	end
	else
	begin
		if(counter_aux>=C_MAX-1)
		begin
			counter_aux<=0;
		end
		else
		begin
			counter_aux<=counter_aux+1;
		end
	end
end


always @(SW)
	begin
		comparador =(2000*SW)/1023  + 500;
	end

always @(posedge clk)
begin
	if(counter_aux < comparador)
		PWM_out <=1;
	else
		PWM_out <=0;
end

//PWM_out = counter_aux > comparador?1:0;

endmodule