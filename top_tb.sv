module processor_tb;

    logic clk;
    logic reset;

    // Instantiate the Processor
    top dut (
        .clk(clk),
        .reset(reset)
    );

    // Clock Generation
    always begin
        #5 clk = ~clk;  // 10ns clock period
    end

    // Testbench
    initial begin
        // Initialize signals
        clk = 0;
        reset = 1;

        // Initialize Instruction Memory
        dut.inst_mem_0.data_memory[0] = 32'hfe010113;
        dut.inst_mem_0.data_memory[1] = 32'h02812623;
        dut.inst_mem_0.data_memory[2] = 32'h03010413;
        dut.inst_mem_0.data_memory[3] = 32'h00500793;
        dut.inst_mem_0.data_memory[4] = 32'hfef42023;
        dut.inst_mem_0.data_memory[5] = 32'h00a00793;
        dut.inst_mem_0.data_memory[6] = 32'hfcf42e23;
        dut.inst_mem_0.data_memory[7] = 32'hfe042703;
        dut.inst_mem_0.data_memory[8] = 32'hfdc42783;
        dut.inst_mem_0.data_memory[9] = 32'h00f707b3;
        dut.inst_mem_0.data_memory[10] = 32'hfcf42c23;
        dut.inst_mem_0.data_memory[11] = 32'hfd842703;
        dut.inst_mem_0.data_memory[12] = 32'hfe042783;
        dut.inst_mem_0.data_memory[13] = 32'h40f707b3;
        dut.inst_mem_0.data_memory[14] = 32'hfcf42a23;
        dut.inst_mem_0.data_memory[15] = 32'hfe042623;
        dut.inst_mem_0.data_memory[16] = 32'hfe042423;
        dut.inst_mem_0.data_memory[17] = 32'hfe042223;
        dut.inst_mem_0.data_memory[18] = 32'h0200006f;
        dut.inst_mem_0.data_memory[19] = 32'hfec42703;
        dut.inst_mem_0.data_memory[20] = 32'hfd442783;
        dut.inst_mem_0.data_memory[21] = 32'h00f707b3;
        dut.inst_mem_0.data_memory[22] = 32'hfef42623;
        dut.inst_mem_0.data_memory[23] = 32'hfe442783;
        dut.inst_mem_0.data_memory[24] = 32'h00178793;
        dut.inst_mem_0.data_memory[25] = 32'hfef42223;
        dut.inst_mem_0.data_memory[26] = 32'hfe442703;
        dut.inst_mem_0.data_memory[27] = 32'hfdc42783;
        dut.inst_mem_0.data_memory[28] = 32'hfcf74ee3;
        dut.inst_mem_0.data_memory[29] = 32'h0200006f;
        dut.inst_mem_0.data_memory[30] = 32'hfec42703;
        dut.inst_mem_0.data_memory[31] = 32'hfe042783;
        dut.inst_mem_0.data_memory[32] = 32'h40f707b3;
        dut.inst_mem_0.data_memory[33] = 32'hfef42623;
        dut.inst_mem_0.data_memory[34] = 32'hfe842783;
        dut.inst_mem_0.data_memory[35] = 32'h00178793;
        dut.inst_mem_0.data_memory[36] = 32'hfef42423;
        dut.inst_mem_0.data_memory[37] = 32'hfec42703;
        dut.inst_mem_0.data_memory[38] = 32'hfe042783;
        dut.inst_mem_0.data_memory[39] = 32'hfcf75ee3;
        dut.inst_mem_0.data_memory[40] = 32'h0000006f;

        // Initialize Data Memory
        dut.data_mem_0.data_memory[0] = 32'd5;
        dut.data_mem_0.data_memory[1] = 32'd10;
        dut.data_mem_0.data_memory[2] = 32'd20;
        dut.data_mem_0.data_memory[3] = 32'd30;
        dut.data_mem_0.data_memory[4] = 32'd40;

        // Deassert reset
        #10 reset = 0;

        // Display
        #125 $display("MEM[2] = %h", dut.data_mem_0.data_memory[2]);

        // Run simulation for a set number of clock cycles
        #220;
        $finish;
    end

endmodule