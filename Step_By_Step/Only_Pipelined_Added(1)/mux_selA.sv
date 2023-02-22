module mux_selA (
    input logic         sel_AE, //from controller
    input logic  [31:0] rdata1E,AddrE,
    output logic [31:0] SrcA
);
always_comb begin 
    case (sel_AE)
       1'b0 : SrcA = AddrE;
       1'b1 : SrcA = rdata1E;
    endcase  
end
endmodule

