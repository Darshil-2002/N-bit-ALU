module top
	#(parameter N = 8)// Here N can be changed as the number of bits required.
	(input [N-1:0]A,B,
	 input c_in,
	 input [3:0]control,
	 output reg [N-1:0]result,
	 output reg c_out,
	 output zero,
	 output parity,
	 output reg invalid,
	 output reg borrow);
			 		 

localparam ADD = 4'd0;// discard carry
localparam ADD_C = 4'd1;// ADD with carry
localparam SUB = 4'd2;// Substraction
localparam SUB_B = 4'd3; // Substraction with Borrow
localparam AND = 4'd4; // bitwise AND  
localparam OR = 4'd5;	// bitwise OR
localparam XOR = 4'd6; // bitwise XOR
localparam SHIFT_L = 4'd7; // Logical shift left
localparam SHIFT_R = 4'd8; // Logical shift right
localparam ROT_L = 4'd9; // Rotate left A
localparam ROT_R = 4'd10; // Rotate right A
localparam G_T = 4'd11; // Check if A>B
localparam L_T = 4'd12; // Check if A<B
localparam NOT_A = 4'd13; // negate A
localparam NOT_B = 4'd14; // negate B
localparam XOR_P = 4'd15; // To get Parity Bit

	always @ (*)
		begin
			result = 0; c_out = 0; 
			invalid = 0; borrow = 0;
			case (control)
				ADD : result = A + B;
				ADD_C : {c_out,result} = A + B + c_in;
				SUB : result = A - B;
				SUB_B : {borrow,result} = A - B;
				AND : result = A & B ;
				OR : result = A | B;
				XOR : result = A ^ B;
				SHIFT_L : result = A <<< 1;
				SHIFT_R : result = A >>> 1;
				ROT_L : result = {A[N-2:0],A[N-1]};
				ROT_R : result = {A[0],A[N-1:1]};
				G_T : result = A > B;
				L_T : result = A < B;
				NOT_A : result = ~A;
				NOT_B : result = ~B;
				XOR_P : result = ^A;
				default : invalid = 1;
			endcase
		end	
		
		assign parity = ^result;
		assign zero = (result == 0);
		

endmodule
