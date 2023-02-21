module Hazard_Unit (
    input  logic       reg_wrM,reg_wrW,
    input  logic [4:0] rdata1E,rdata2E,waddrM,waddrW, 
    output logic [1:0] forwardAE,forwardBE
    
);

// Check the validity of the source operands from EXE stage
  logic rs1_valid;
  logic rs2_valid;
  assign rs1_valid = |rdata1E;
  assign rs2_valid = |rdata2E;

// Hazard detection for forwarding 
  always_comb begin
    if ((( rdata1E == waddrM )  & (reg_wrM)) & (rs1_valid)) begin
      forwardAE = 2'b00;
    end
    else if ((( rdata1E == waddrW )  & (reg_wrW)) & (rs1_valid)) begin
      forwardAE = 2'b10;
    end
    else begin
      forwardAE = 2'b01;
    end

  end

  always_comb begin
    if ((( rdata2E == waddrM )  & (reg_wrM)) & (rs2_valid)) begin
      forwardBE = 2'b00;
    end
    else if ((( rdata2E == waddrW )  & (reg_wrW)) & (rs2_valid)) begin
      forwardBE = 2'b10;
    end
    else begin
      forwardBE = 2'b01;
    end

  end

// //   always_comb begin
// //     if (((Rs1E == RdM) && RegWriteM) && (Rs1E != 0) ) begin
// //       ForwardAE <= 2'b10;
// //     end
// //     else if ( ((Rs1E == RdW) && RegWriteW) && (Rs1E != 0) ) begin
// //       ForwardAE <= 2'b01;
// //     end
// //     else begin
// //       ForwardAE <= 2'b00;
// //     end

// //   end

// //   always_comb begin
// //     if (((Rs2E == RdM) && RegWriteM) && (Rs2E != 0) ) begin
// //       ForwardBE <= 2'b10;
// //     end
// //     else if ( ((Rs2E == RdW) && RegWriteW) && (Rs2E != 0) ) begin
// //       ForwardBE <= 2'b01;
// //     end
// //     else begin
// //       ForwardBE <= 2'b00;
// //     end
  
// // Hazard detection for Stalling
//   logic lwStall;
//   assign  lwStall  = ( wb_selMW[1] & (( raddr1 == waddr_MW ) | ( raddr2 == waddr_MW )) & ( valid == 0) & (reg_wrMW));
//   assign  Stall    = lwStall;
//   assign  Stall_MW = lwStall;  

// //Flush When a branch is taken or a load initroduces a bubble
// always_comb begin
//    if (PCsrc)
//       Flush  = 1'b1;
// end

endmodule