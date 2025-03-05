module Program_Counter (
    input [31:0] A_out,
    input clk, reset,
    output reg [31:0] PC
);
    always @(posedge clk) begin
        if (reset)
            PC <= 32'b0;  // Ensure 32-bit reset value
        else
            PC <= A_out;
    end
endmodule