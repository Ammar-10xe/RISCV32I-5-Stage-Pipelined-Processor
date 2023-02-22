module fourt_register (
    input logic         clk,rst,reg_wrM,
    input logic  [1:0]  wb_selM,
    input logic  [31:0] AddrM,ALUResultM,rdata,InstM,
    output logic        reg_wrW,
    output logic [1:0]  wb_selW,
    output logic [4:0]  waddr,
    output logic [31:0] AddrW,ALUResultW,rdataW,InstW
 
);

  assign waddr  = InstW [11:7]; 

  always_ff @(posedge clk) begin
    if( rst ) begin
        AddrW      <= 32'b0;
        ALUResultW <= 32'b0;
        rdataW     <= 32'b0;
        InstW      <= 32'b0;
        reg_wrW    <= 1'b0;
        wb_selW    <= 2'bx;
  end
    else begin
        AddrW      <= AddrM;
        ALUResultW <= ALUResultM;
        rdataW     <= rdata;
        InstW      <= InstM;
        reg_wrW    <= reg_wrM;
        wb_selW    <= wb_selM;
      end
  end

    
endmodule