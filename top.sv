module top(
    input logic clk, reset
);
    logic [31:0] PC, A_out, Immediate_Value, Instruction, A, B, ALU_result, rdata, wdata;
    logic [4:0] rs1, rs2, rd;
    logic [6:0] opcode;
    logic [3:0] alu_op;
    logic [2:0] br_type;
    logic [1:0] wb_sel;
    logic reg_wr, rd_en, wr_en, br_taken, sel_A, sel_B;

    assign opcode = Instruction[6:0];
    assign rs1 = Instruction[19:15];
    assign rs2 = Instruction[24:20];
    assign rd = Instruction[11:7];
    assign A_out = br_taken ? ALU_result : PC + 4;

    always_comb begin
        case (wb_sel)
            2'b00: wdata = PC + 4;
            2'b01: wdata = ALU_result;
            2'b10: wdata = rdata;
        endcase
    end

    // Instantiation
    Program_Counter pc_0 (
        .clk(clk),
        .reset(reset),
        .A_out(A_out),
        .PC(PC)
    );

    Instruction_Memory inst_mem_0 (
        .Address(PC),
        .Instruction(Instruction)
    );

    reg_file reg_file_0 (
		.clk(clk),
		.reset(reset),
		.reg_wr(reg_wr),
		.raddr1(rs1),
		.raddr2(rs2),
		.waddr(rd),
		.wdata(wdata),
		.rdata1(A),
		.rdata2(B)
);

    ALU alu_0 (
        .A(sel_A ? B : PC),
        .B(sel_B ? Immediate_Value : A),
        .alu_op(alu_op),
        .ALU_out(ALU_result)
    );

    Data_Memory data_mem_0 (
        .clk(clk),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .addr(ALU_result),
        .wdata(B),
        .rdata(rdata)
    );

    Branch_Condition branch_cond_0 (
        .A(A),
        .B(B),
        .br_type(br_type),
        .br_taken(br_taken)
    );

    Controller controller_0 (
        .Instruction(Instruction),
        .reg_wr(reg_wr),
        .rd_en(rd_en),
        .wr_en(wr_en),
        .sel_A(sel_A),
        .sel_B(sel_B),
        .wb_sel(wb_sel),
        .alu_op(alu_op),
        .br_type(br_type)
    );

    Immediate_Generator imd_generator_0 (
        .Instructions(Instruction),
        .Immediate_Value(Immediate_Value)
    );

endmodule