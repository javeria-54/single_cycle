module Instruction_Memory (
    output reg [31:0] Instruction,
    input [31:0] Address
);
	logic [31:0] data_memory [0:1023];

	assign Instruction = data_memory[Address[11:2]];

endmodule



