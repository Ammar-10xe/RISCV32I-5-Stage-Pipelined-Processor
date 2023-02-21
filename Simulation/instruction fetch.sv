module Instruction_Fetch (
    input logic [31:0] InstD,
    output logic [4:0] raddr1,raddr2,waddrD
);

always_comb begin
        raddr1 = InstD [19:15];
        raddr2 = InstD [24:20];
        waddrD = InstD [11:7];
end
endmodule