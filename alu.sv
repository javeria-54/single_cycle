module ALU (
    output reg [31:0] ALU_out,
    input [31:0] A, B,
    input [3:0] alu_op
);
    always_comb begin
        case(alu_op)
            4'b0000: ALU_out = A + B;  // addi
            4'b0001: ALU_out = A << B[4:0];  // slli
            4'b0010: ALU_out = A ^ B;  // xor
            4'b0011: ALU_out = A >> B[4:0];  // srli
            4'b0100: ALU_out = ($signed(A) >>> $signed(B));  // srai
            4'b0101: ALU_out = A | B;  // or
            4'b0110: ALU_out = A & B;  // and
            4'b0111: ALU_out = A - B;  // sub
            4'b1000: ALU_out = ($signed(A) < $signed(B)) ? 1 : 0;  // SLT
            4'b1001: ALU_out = B;  // Pass B
            4'b1010: ALU_out = A;  // Pass A
            4'b1011: ALU_out = (A < B) ? 1 : 0;  // SLTU
            default: ALU_out = 32'b0;
        endcase
    end
endmodule
        
