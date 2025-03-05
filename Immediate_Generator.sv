module Immediate_Generator (
output logic [31:0] Immediate_Value,
input logic [31:0] Instructions
);
logic [6:0] opcode;
always_comb begin
    opcode = Instructions[6:0];
    case(opcode)
        //S-TYPE
        7'b0100011 : Immediate_Value = {{20{Instructions[31]}}, Instructions[31:25], Instructions[11:7]};
        //R-TYPE
        7'b0110011 : Immediate_Value = 32'b0;
        //J-TYPE
        7'b1101111 : Immediate_Value = {{11{Instructions[31]}}, Instructions[31], Instructions[19:12], Instructions[20], Instructions[30:21], 1'b0};
        //B-TYPE
        7'b1100011 : Immediate_Value = {{19{Instructions[31]}}, Instructions[31], Instructions[7], Instructions[30:25], Instructions[11:8], 1'b0};
        //U-TYPE
        7'b0110111 : Immediate_Value = {Instructions[31:12], 12'b0};
        //AUPIC
        7'b0010111 : Immediate_Value = {Instructions[31:12], 12'b0};
        //I-TYPE(Load)
        7'b0000011 : Immediate_Value = {{20{Instructions[31]}},Instructions[31:20]};
        //I-TYPE
        7'b0010011 : Immediate_Value = {{20{Instructions[31]}},Instructions[31:20]};
    endcase
end


endmodule