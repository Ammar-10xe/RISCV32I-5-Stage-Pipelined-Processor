module ALU (
    input logic  [4:0]  alu_opE,
    input logic  [31:0] SrcAE,SrcBE,
    output logic [31:0] ALUResult
);


 always_comb begin
    case(alu_opE)
    
    5'b00000: ALUResult = SrcAE + SrcBE ;                             //Addition

    5'b00001: ALUResult = SrcAE - SrcBE ;                             //Subtraction

    5'b00010: ALUResult = SrcAE << SrcBE[4:0];                        //Shift Left Logical

    5'b00011: ALUResult = ($signed(SrcAE) < $signed(SrcBE)) ? 1 : 0;  //Set Less than

    5'b00100: ALUResult = (SrcAE < SrcBE) ? 1 : 0;                    //Set Less than unsigned

    5'b00101: ALUResult = SrcAE ^ SrcBE;                              //LOgical xor

    5'b00110: ALUResult = SrcAE >> SrcBE;                             //Shift Right Logical

    5'b00111: ALUResult = SrcAE >>> SrcBE[4:0];                       //Shift Right Arithmetic

    5'b01000: ALUResult = SrcAE | SrcBE;                              //Logical Or

    5'b01001: ALUResult = SrcAE & SrcBE;                              //Logical and

    5'b01010: ALUResult = SrcBE;                                      //Load Upper Immediate
  
    default:  ALUResult = SrcAE + SrcBE;
    endcase

  end
endmodule