module max_count_gen (
	input wire [7:0] switches,
	output reg [27:0] max_count,
	output wire [15:0] segment_num_max,
	output wire [7:0] redundancy
);

reg [16:0] max_counter_samepacket = 17'd50;
always @(switches) begin
	if (switches[3:0] != 4'b0000) begin
		case (switches[3:0])
			4'b0000:	max_count <= 27'd124999999; // 1 pps , 0.0115Mbps
			4'b0001:	max_count <= 27'd62499999; // 2 pps, 0.023Mbps
			4'b0010:	max_count <= 27'd12499999; // 10 pps, 0.115Mbps
			4'b0011:	max_count <= 27'd6249999; //20 pps   0.23Mbps
			4'b0100:	max_count <= 27'd2499999; // 50 pps, 0.5756Mbps 
			4'b0101:	max_count <= 27'd1249999; //100 pps, 1.15Mbps
			4'b0110:	max_count <= 27'd624999; // 200pps, 2.30Mbps
			4'b0111:	max_count <= 27'd249999; //500 pps, 5.72Mbps
			4'b1000:	max_count <= 27'd124999; // 1000 pps, 11.388Mbps
			4'b1001:	max_count <= 27'd62499; //2000 pps, 22.52Mbps
			4'b1010:	max_count <= 27'd24999; //5000 pps, 54.46Mbps
			4'b1011:	max_count <= 27'd12499; //10000 pps, 103.307Mbps
			4'b1100:	max_count <= 27'd6249; //20000 pps, 187.28Mbps
			4'b1101:	max_count <= 27'd2499; //50000 pps, 365.575Mbps
			4'b1110:	max_count <= 27'd1249; //100000pps, 535.515Mbps
			default:	max_count <= 27'd30; //ok? 979.59Mbps
		endcase
	end
	else begin
		max_count <= 27'd30;
	end

end

assign segment_num_max = (switches[7:6] == 2'b00) ? 1:
															switches[7:6] == 2'b01 ? 3:
															switches[7:6] == 2'b10 ? 100:
															switches[7:6] == 2'b11 ? 150 : 1;
assign redundancy = switches[5:4] == 2'b00 ? 1:
												switches[5:4] == 2'b01 ? 3:
												switches[5:4] == 2'b10 ? 5:
												switches[5:4] == 2'b11 ? 7 : 1;

endmodule