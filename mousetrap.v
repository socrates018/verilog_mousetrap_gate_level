`define DATA_WIDTH 3

module latch_d(d, en, q);

	input d, en;
	output q;

	wire q_n, d_n;
	wire d1, d2;

	not(d_n, d);
	nand(d1, d, en);
	nand(d2, d_n, en);
	nand(q, d1, q_n);
	nand(q_n, q, d2);

endmodule


module latch_d_Nbit #(parameter WIDTH = 3) (d, en, q);

	input [WIDTH:0] d;
	input en;
	output [WIDTH:0] q;
	wire [WIDTH: 0] qwire; 
	
	assign q = qwire;	

	genvar i;
	generate
	for (i = 0; i <= WIDTH; i = i + 1) begin : latch_gen
		latch_d ld(d[i], en, qwire[i]);
	end
	endgenerate

endmodule


module mux2to1_1bit(out, in1, in2, sel);

	input in1, in2, sel;
	output out;
	
	wire sel_n;
	wire and1, and2;

	not(sel_n, sel);
	and(and1, in2, sel);
	and(and2, in1, sel_n);
	or(out, and1, and2); 

endmodule


module mousetrap_Nbit(data_out, data_in, ack_in, ack_out, req_in, req_out, reset);
	input [`DATA_WIDTH:0] data_in; 
	input ack_in, req_in;
	input reset;

	output [`DATA_WIDTH:0] data_out;
	output req_out, ack_out;
	
	wire xor_out;

	latch_d_Nbit #(`DATA_WIDTH) data_latch (data_in, latch_en, data_out);
	latch_d_Nbit #(0) req_latch   (req_in, latch_en, req_out);

	xnor(xor_out, req_out, ack_in);
	mux2to1_1bit mux21(latch_en, xor_out, 1'b1, reset); 
	
	assign ack_out = req_out;

	
endmodule
