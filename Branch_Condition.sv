module Branch_Condition (
    output reg br_taken,
    input [31:0] A, B,
    input [2:0] br_type
);
    always_comb begin
        case(br_type)
            3'b000: br_taken = A == B;
            3'b001: br_taken = A != B;
            3'b010: br_taken = A < B;
            3'b011: br_taken = A >= B;
            3'b100: br_taken = ($signed(A) < $signed(B));
            3'b101: br_taken = ($signed(A) >= $signed(B));
            3'b110: br_taken = 1;
            3'b111: br_taken = 0;
            default: br_taken = 0;
        endcase
    end
endmodule