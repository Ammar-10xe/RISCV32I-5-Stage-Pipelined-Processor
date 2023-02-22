module MuxResult (
    input logic  [1:0]  wb_selW, //From controller
    input logic  [31:0] ALUResultW,rdataW,AddrWB,
    output logic [31:0] wdata
);

always_comb begin 
    case (wb_selW)
       2'b00 : wdata = AddrWB;
       2'b01 : wdata = ALUResultW;
       2'b10 : wdata = rdataW;
    endcase
    end
endmodule

