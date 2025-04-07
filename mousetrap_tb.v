`include "mousetrap.v"

module mousetrap_Nbit_tb;

    reg [`DATA_WIDTH:0] data_in;
    reg ack_in, req_in, reset;
    wire [`DATA_WIDTH:0] data_out;
    wire req_out, ack_out;

    // Instantiate the mousetrap module
    mousetrap_Nbit uut (
        .data_out(data_out),
        .data_in(data_in),
        .ack_in(ack_in),
        .ack_out(ack_out),
        .req_in(req_in),
        .req_out(req_out),
        .reset(reset)
    );

    initial begin
        // Initialize inputs
        data_in = 4'b0000; ack_in = 0; req_in = 0; reset = 1;
        $dumpfile("mousetrap_Nbit_waveform.vcd");
        $dumpvars(0, mousetrap_Nbit_tb);
        
        #10 reset = 0;
        // Apply test vectors
        #5 req_in = 1; data_in = 4'b0011;
        #5 ack_in = 1;
        #5 req_in = 0; data_in = 4'b1010;
        #5 ack_in = 0;
        #5 req_in = 1; data_in = 4'b1111;
        #5 ack_in = 1;
        #5 req_in = 0; data_in = 4'b0101;
        #5 ack_in = 0;
        #5 req_in = 1; data_in = 4'b0001;
        #5 ack_in = 1;
        #5 $finish;
    end

    initial begin
        $monitor("At time %t: data_in = %b, ack_in = %b, req_in = %b, data_out = %b, ack_out = %b, req_out = %b", $time, data_in, ack_in, req_in, data_out, ack_out, req_out);
    end

endmodule
