module TopLevel (input logic clk,rst);

    logic        reg_wr,reg_wrE,reg_wrM,reg_wrW,sel_A,sel_AE,sel_B,sel_BE,cs,wr,br_taken;
    logic [1:0]  wb_sel,wb_selE,wb_selM,wb_selW;
    logic [2:0]  ImmSrcD,funct3,funct3E,funct3M;
    logic [3:0]  mask;
    logic [4:0]  raddr1,raddr2,waddr,alu_op,alu_opE;
    logic [6:0]  instr_opcode,instr_opcodeE,instr_opcodeM;
    logic [31:0] Addr,AddrD,AddrE,AddrM,AddrW,AddrWB,PC,Inst,InstD,InstE,InstM,InstW,PCF,wdata,rdata1,rdata1E,rdata2,rdata2E,rdata2M,ImmExtD,ImmExtE,SrcA,SrcB,ALUResult,ALUResultM,ALUResultW,rdata,rdataW,data_rd,addr,data_wr;




Mux_PC MuxPC(
    .br_taken(br_taken),
    .PCF(PCF),
    .ALUResultM(ALUResultM),
    .PC(PC));

PCPlus4 PCplus4 (
    .Addr(Addr),
    .PCF(PCF));

program_counter ProgCouner (
    .clk(clk),
    .rst(rst),
    .PC(PC),
    .Addr(Addr));

Instruction_Memory InstMem(
    .Addr(Addr),
    .Inst(Inst));

first_register FirstReg(
    .clk(clk),
    .rst(rst),
    .Addr(Addr),
    .Inst(Inst),
    .AddrD(AddrD),
    .InstD(InstD)); 

Instruction_Fetch Fetch(
    .InstD(InstD),
    .raddr1(raddr1),
    .raddr2(raddr2));

Register_file RegsiterFile(
    .clk(clk),
    .rst(rst),
    .reg_wrW(reg_wrW),
    .raddr1(raddr1),
    .raddr2(raddr2),
    .waddr(waddr),
    .wdata(wdata),
    .rdata1(rdata1),
    .rdata2(rdata2));

immediate_gen Immediate(
    .InstD(InstD),
    .ImmSrcD(ImmSrcD),
    .ImmExtD(ImmExtD));

second_register SecondReg(
    .clk(clk),
    .rst(rst),
    .reg_wr(reg_wr),
    .sel_A(sel_A),
    .sel_B(sel_B),
    .wb_sel(wb_sel),
    .funct3(funct3),
    .alu_op(alu_op),
    .instr_opcode(instr_opcode),
    .AddrD(AddrD),
    .rdata1(rdata1),
    .rdata2(rdata2),
    .ImmExtD(ImmExtD),
    .InstD(InstD),
    .reg_wrE(reg_wrE),
    .sel_AE(sel_AE),
    .sel_BE(sel_BE),
    .wb_selE(wb_selE),
    .funct3E(funct3E),
    .alu_opE(alu_opE),
    .instr_opcodeE(instr_opcodeE),
    .AddrE(AddrE),
    .rdata1E(rdata1E),
    .rdata2E(rdata2E),
    .ImmExtE(ImmExtE),
    .InstE(InstE));

mux_selA MuxselA(
    .sel_AE(sel_AE),
    .rdata1E(rdata1E),
    .AddrE(AddrE),
    .SrcA(SrcA));

mux_selB MuxselB(
    .sel_BE(sel_BE),
    .ImmExtE(ImmExtE),
    .rdata2E(rdata2E),
    .SrcB(SrcB));

BranchCond Branchcond(
    .funct3E(funct3E),
    .instr_opcodeE(instr_opcodeE),
    .rdata1E(rdata1E),
    .rdata2E(rdata2E),
    .br_taken(br_taken));

ALU Alu(
    .alu_opE(alu_opE),
    .SrcA(SrcA),
    .SrcB(SrcB),
    .ALUResult(ALUResult));

third_register ThirdReg(
    .clk(clk),
    .rst(rst),
    .reg_wrE(reg_wrE),
    .wb_selE(wb_selE),
    .funct3E(funct3E),
    .instr_opcodeE(instr_opcodeE),
    .AddrE(AddrE),
    .ALUResult(ALUResult),
    .rdata2E(rdata2E),
    .InstE(InstE),
    .reg_wrM(reg_wrM),
    .wb_selM(wb_selM),
    .funct3M(funct3M),
    .instr_opcodeM(instr_opcodeM),
    .AddrM(AddrM),
    .ALUResultM(ALUResultM),
    .rdata2M(rdata2M),
    .InstM(InstM));

LoadStore_Unit loadstore(
    .funct3M(funct3M),
    .instr_opcodeM(instr_opcodeM),
    .data_rd(data_rd),
    .rdata2M(rdata2M),
    .ALUResultM(ALUResultM),
    .cs(cs),
    .wr(wr),
    .mask(mask),
    .addr(addr),
    .data_wr(data_wr),
    .rdata(rdata));


Data_Memory Dmem(
    .clk(clk),
    .rst(rst),
    .cs(cs),
    .wr(wr),
    .mask(mask),
    .addr(addr),
    .data_wr(data_wr),
    .data_rd(data_rd));


fourt_register FourtReg(
    .clk(clk),
    .rst(rst),
    .reg_wrM(reg_wrM),
    .wb_selM(wb_selM),
    .AddrM(AddrM),
    .ALUResultM(ALUResultM),
    .rdata(rdata),
    .InstM(InstM),
    .reg_wrW(reg_wrW),
    .wb_selW(wb_selW),
    .waddr(waddr),
    .AddrW(AddrW),
    .ALUResultW(ALUResultW),
    .rdataW(rdataW),
    .InstW(InstW));


AddrW_Plus4 addrW_Plus4(
    .AddrW(AddrW),
    .AddrWB(AddrWB));

MuxResult Muxresult(
    .wb_selW(wb_selW),
    .ALUResultW(ALUResultW),
    .rdataW(rdataW),
    .AddrWB(AddrWB),
    .wdata(wdata));

controller Controller(
    .InstD(InstD),
    .reg_wr(reg_wr),
    .sel_A(sel_A),
    .sel_B(sel_B),
    .wb_sel(wb_sel),
    .ImmSrcD(ImmSrcD),
    .funct3(funct3),
    .alu_op(alu_op),
    .instr_opcode(instr_opcode));



endmodule