`timescale 1ns / 1ps

module thunderbird_tb();
reg clock,reset;
reg sign_left, sign_right;
wire [2:0] L,R;

thunderbird c1(L,R,clock,reset,sign_left, sign_right);  //Instantiation

initial begin                                          // Clock Circuit
clock=1'b0;
repeat(32)
begin
#5 clock=~clock;
end
$finish;
end

initial begin
reset=0;                                            
#2 reset=1'b1;  
#2 reset=1'b0;
sign_left =1; sign_right=0;                             //Test Cases
#50 sign_left =0; sign_right=0;                                     
#50 sign_left =0; sign_right =1;
#50 sign_left =1; sign_right=1;
end
endmodule
