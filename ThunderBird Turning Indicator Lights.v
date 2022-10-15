`timescale 1ns / 1ps
////module to simulate rear turn indicator lights on a Ford Thunderbird

module thunderbird (output [2:0] L, output [2:0] R,
input clock, input reset, input sign_left, input sign_right);
reg div_clk;
reg [26:0] delay_count;
reg [2:0] L; reg [2:0]R;
// LEFT INDICATOR 
reg [3:0]s0 = 3'b001;
reg [3:0]s1 = 3'b011;
reg [3:0]s2 = 3'b111;
// RIGHT INDICATOR
reg [3:0]s3 = 3'b100;
reg [3:0]s4 = 3'b110;
reg [3:0]s5 = 3'b111;
// TURNED OFF 
reg [3:0]s6 = 3'b000;

always @(posedge clock or posedge reset) // Clock division code
begin 
if(reset)
begin 
delay_count <=27'd0;
div_clk <= 1'b0;
end 
else
if(delay_count==27'd67108863)          // around 1 sec delay produced between change of states
begin
delay_count<=27'd0;
div_clk <= ~div_clk;
end
else delay_count <= delay_count+1;
end


always @(posedge div_clk or posedge reset)
begin
if(reset) begin
    L <=s6; R <=s6;
end
else if (sign_left==1 & sign_right==0) begin //for left turn
    R <= s6;
    case(L)
    3'b000: L <= s0;
    3'b001: L <= s1;
    3'b011: L <= s2;
    3'b111: L <= s6;
    default: L <=s6;
    endcase
 end

else if (sign_left==0 & sign_right==1) begin //for right turn
    L<=s6;
    case(R)
    3'b000: R <= s3;
    3'b100: R <= s4;
    3'b110: R <= s5;
    3'b111: R <= s6;
    default: R <=s6;
    endcase
end

else begin//when both sign_right and sign_left are either 0 or 1
    L<=s6; R<=s6;
end
end
endmodule

