module reg_file(
    input logic clk, reset, reg_wr,
    input logic [4:0] raddr1, raddr2, waddr,
    input logic [31:0] wdata,
    output logic [31:0] rdata1, rdata2
);
    logic [31:0] register_file [0:31];

    always_ff @(negedge clk or posedge reset) begin
        if (reset) begin
            // Initialize registers
            for (int i = 0; i < 32; i++) begin
                register_file[i] <= 32'b0;
            end
        end else begin
            if (reg_wr && waddr != 0)  // Register 0 is always 0
                register_file[waddr] <= wdata;
        end
    end

    always_comb begin
        rdata1 = register_file[raddr1];
        rdata2 = register_file[raddr2];
    end
endmodule