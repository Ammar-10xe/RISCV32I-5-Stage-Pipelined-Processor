module third_register (
    input logic         clk,rst,reg_wrE,
    input logic  [1:0]  wb_selE,
    input logic  [2:0]  funct3E,
    input logic  [6:0]  instr_opcodeE,
    input logic  [31:0] AddrE,ALUResult,rdata2E,InstE,
    output logic        reg_wrM,
    output logic [1:0]  wb_selM,
    output logic [2:0]  funct3M,
    output logic [6:0]  instr_opcodeM,
    output logic [31:0] AddrM,ALUResultM,rdata2M,InstM
);
  always_ff @( posedge clk ) begin
    if ( rst ) begin
        AddrM         <= 32'b0;
        ALUResultM    <= 32'b0;
        rdata2M       <= 32'b0;
        InstM         <= 32'b0;
        reg_wrM       <= 1'b0;
        wb_selM       <= 2'bx;
        funct3M       <= 3'bx;
        instr_opcodeM <= 7'bx;
  end
    else begin
        AddrM         <= AddrE;
        ALUResultM    <= ALUResult;
        rdata2M       <= rdata2E;
        InstM         <= InstE;
        reg_wrM       <= reg_wrE;
        wb_selM       <= wb_selE;
        funct3M       <= funct3E;
        instr_opcodeM <= instr_opcodeE;
      end
  end
    
endmodule

