module Data_Memory (
    output reg [31:0] rdata,
    input [31:0] wdata, addr,
    input wr_en, rd_en, clk
);
    logic [31:0] data_memory [0:1023];

    always_ff @(negedge clk) begin
        if (wr_en)
            data_memory[addr] <= wdata;
    end

    always_comb begin
        if (rd_en)
            rdata = data_memory[addr];
        else
            rdata = 32'b0;
    end
endmodule