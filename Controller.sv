module Controller (
    input logic [31:0] Instruction,
    output logic [3:0] alu_op,
    output logic reg_wr, sel_A, sel_B, wr_en, rd_en, unsign,
    output logic [2:0] br_type,
    output logic [1:0] wb_sel
);
    logic [6:0] opcode, func7;
    logic [2:0] func3;
    logic [4:0] rs1, rs2, rd;

    assign opcode = Instruction[6:0];
    assign func7 = Instruction[31:25];
    assign func3 = Instruction[14:12];
    assign rd = Instruction[11:7];
    assign rs1 = Instruction[19:15];
    assign rs2 = Instruction[24:20];

    always_comb begin
        // Default values
        reg_wr = 0;
        sel_A = 0;
        sel_B = 0;
        wr_en = 0;
        rd_en = 0;
        unsign = 0;
        alu_op = 4'b0000;
        br_type = 3'b000;
        wb_sel = 2'b00;

        // R-Type
        if (opcode == 7'b0110011) begin
            reg_wr = 1;
            sel_A = 1;
            sel_B = 0;
            wb_sel = 2'b01;
            case(func3)
                3'b000: alu_op = (func7 == 7'b0000000) ? 4'b0000 : 4'b0111;  // ADD or SUB
                3'b001: alu_op = 4'b0001;  // SLL
                3'b101: alu_op = (func7 == 7'b0000000) ? 4'b0011 : 4'b0100;  // SRL or SRA
                3'b010: alu_op = 4'b1000;  // SLT
                3'b011: alu_op = 4'b1001;  // SLTU
                3'b100: alu_op = 4'b0010;  // XOR
                3'b110: alu_op = 4'b0101;  // OR
                3'b111: alu_op = 4'b0110;  // AND
            endcase
        end

        // I-Type
        else if (opcode == 7'b0010011) begin
            reg_wr = 1;
            sel_A = 1;
            sel_B = 1;
            wb_sel = 2'b01;
            case(func3)
                3'b000: alu_op = 4'b0000;  // ADDI
                3'b001: alu_op = 4'b0001;  // SLLI
                3'b101: alu_op = (func7 == 7'b0000000) ? 4'b0011 : 4'b0100;  // SRLI or SRAI
                3'b010: alu_op = 4'b1000;  // SLTI
                3'b011: alu_op = 4'b1001;  // SLTIU
                3'b100: alu_op = 4'b0010;  // XORI
                3'b110: alu_op = 4'b0101;  // ORI
                3'b111: alu_op = 4'b0110;  // ANDI
            endcase
        end

        // I-Type (Load)
        else if (opcode == 7'b0000011) begin
            reg_wr = 1;
            rd_en = 1;
            sel_A = 1;
            sel_B = 1;
            wb_sel = 2'b11;
            alu_op = 4'b0000;
        end

        // S-Type
        else if (opcode == 7'b0100011) begin
            wr_en = 1;
            sel_A = 1;
            sel_B = 1;
            alu_op = 4'b0000;
        end

        // B-Type
        else if (opcode == 7'b1100011) begin
            sel_A = 0;
            sel_B = 1;
            case(func3)
                3'b000: br_type = 3'b000;  // BEQ
                3'b001: br_type = 3'b001;  // BNE
                3'b100: br_type = 3'b010;  // BLT
                3'b101: br_type = 3'b011;  // BGE
                3'b110: br_type = 3'b100;  // BLTU
                3'b111: br_type = 3'b101;  // BGEU
            endcase
        end

        // U-Type
        else if (opcode == 7'b0110111) begin  // LUI
            reg_wr = 1;
            sel_A = 0;
            sel_B = 1;
            wb_sel = 2'b01;
            alu_op = 4'b1010;
        end
        else if (opcode == 7'b0010111) begin  // AUIPC
            reg_wr = 1;
            sel_A = 0;
            sel_B = 1;
            wb_sel = 2'b01;
            alu_op = 4'b0000;
        end

        // J-Type
        else if (opcode == 7'b1101111) begin  // JAL
            reg_wr = 1;
            sel_A = 0;
            sel_B = 1;
            wb_sel = 2'b00;
            br_type = 3'b111;
            alu_op = 4'b0000;
        end
        else if (opcode == 7'b1100111) begin  // JALR
            reg_wr = 1;
            sel_A = 1;
            sel_B = 1;
            wb_sel = 2'b00;
            br_type = 3'b111;
            alu_op = 4'b0000;
        end
    end
endmodule