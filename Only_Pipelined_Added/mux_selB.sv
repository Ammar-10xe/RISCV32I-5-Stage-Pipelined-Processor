module mux_selB (
    input logic         sel_BE, //from controller
    input logic  [31:0] ImmExtE,rdata2E,
    output logic [31:0] SrcB
);

always_comb begin 
    case (sel_BE)
       1'b0 : SrcB = rdata2E;
       1'b1 : SrcB = ImmExtE;
    endcase
    
end
    
endmodule

