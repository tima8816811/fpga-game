`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/12/04 00:18:53
// Design Name: 
// Module Name: snake
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module snake
(
	input clk,
	input clr,
	input L,R,U,D,
	input [9:0]x_pos,
	input [9:0]y_pos, //���y����  ���G"�����I""	
	input add_cube,//�W�[����H��
	input s_start,s_play,s_die,

	output reg [1:0]snake,//�Ω��ܷ�e���y���y������ �|�ت��A 00�G�L 01�G�Y 10�G���� 11�G	
	output [5:0]head_x,	
	output [5:0]head_y,//�Y���槤��	
	output reg [6:0]cube_num,
	output reg hit_body,  //���쨭�l�H��
	output reg hit_wall   //������H��
);
	
	localparam UP = 2'b00;
	localparam DOWN = 2'b01;
	localparam LEFT = 2'b10;
	localparam RIGHT = 2'b11;
	
	localparam NONE = 2'b00;
	localparam HEAD = 2'b01;
	localparam BODY = 2'b10;
	localparam WALL = 2'b11;
	
    localparam RESTART = 2'b00;
	localparam PLAY = 2'b10;
	
	reg[31:0]cnt;
	
	wire[1:0]direct;
	reg [1:0]direct_r;     //�H�s��V
	assign direct = direct_r;//�H�s�U�@�Ӥ�V
	reg[1:0]direct_next;
	
	reg change_to_left;
	reg change_to_right;
	reg change_to_up;
	reg change_to_down;
	
	reg [5:0]cube_x[15:0];
	reg [5:0]cube_y[15:0];//������� ���G"��l"
    reg [15:0]is_exist;    //�Ω󱱨�l���G���A�Y����l����
	
	reg addcube_state;
	
	assign head_x = cube_x[0];
	assign head_y = cube_y[0]; 
	
	always @(posedge clk or posedge clr) begin		
		if(clr)
			direct_r <= RIGHT; //�q�{�@�X�ӦV�k����
		else
			direct_r <= direct_next;
	end

    
	always @(posedge clk or posedge clr) begin
		if(clr) begin
			cnt <= 0;
								
			cube_x[0] <= 10;
			cube_y[0] <= 5;
					
			cube_x[1] <= 9;
			cube_y[1] <= 5;
					
			cube_x[2] <= 8;
			cube_y[2] <= 5;

			cube_x[3] <= 0;
			cube_y[3] <= 0;
					
			cube_x[4] <= 0;
			cube_y[4] <= 0;
					
			cube_x[5] <= 0;
			cube_y[5] <= 0;
					
			cube_x[6] <= 0;
			cube_y[6] <= 0;
					
			cube_x[7] <= 0;
			cube_y[7] <= 0;
					
			cube_x[8] <= 0;
			cube_y[8] <= 0;
					
			cube_x[9] <= 0;
			cube_y[9] <= 0;					
					
			cube_x[10] <= 0;
			cube_y[10] <= 0;
					
			cube_x[11] <= 0;
			cube_y[11] <= 0;
					
            cube_x[12] <= 0;
			cube_y[12] <= 0;
					
			cube_x[13] <= 0;
			cube_y[13] <= 0;
					
			cube_x[14] <= 0;
			cube_y[14] <= 0;
					
			cube_x[15] <= 0;
			cube_y[15] <= 0;

			hit_wall <= 0;
			hit_body <= 0;//��l����3  ����16 ��l�Ʈɥu���3�Ӫ���-
		end		
		else begin
			cnt <= cnt + 1;
			if(cnt == 12500000) begin  //0.02us*12'500'000=0.25s   �C���ʥ|��
				cnt <= 0;
				if(s_play==1) begin
					if((direct == UP && cube_y[0] == 1)|(direct == DOWN && cube_y[0] == 28)|(direct == LEFT && cube_x[0] == 1)|(direct == RIGHT && cube_x[0] == 38))//
					   hit_wall <= 1; //�������
					else if((cube_y[0] == cube_y[1] && cube_x[0] == cube_x[1] && is_exist[1] == 1)|
							(cube_y[0] == cube_y[2] && cube_x[0] == cube_x[2] && is_exist[2] == 1)|
							(cube_y[0] == cube_y[3] && cube_x[0] == cube_x[3] && is_exist[3] == 1)|
							(cube_y[0] == cube_y[4] && cube_x[0] == cube_x[4] && is_exist[4] == 1)|
							(cube_y[0] == cube_y[5] && cube_x[0] == cube_x[5] && is_exist[5] == 1)|
							(cube_y[0] == cube_y[6] && cube_x[0] == cube_x[6] && is_exist[6] == 1)|
							(cube_y[0] == cube_y[7] && cube_x[0] == cube_x[7] && is_exist[7] == 1)|
							(cube_y[0] == cube_y[8] && cube_x[0] == cube_x[8] && is_exist[8] == 1)|
							(cube_y[0] == cube_y[9] && cube_x[0] == cube_x[9] && is_exist[9] == 1)|
							(cube_y[0] == cube_y[10] && cube_x[0] == cube_x[10] && is_exist[10] == 1)|
							(cube_y[0] == cube_y[11] && cube_x[0] == cube_x[11] && is_exist[11] == 1)|
							(cube_y[0] == cube_y[12] && cube_x[0] == cube_x[12] && is_exist[12] == 1)|
							(cube_y[0] == cube_y[13] && cube_x[0] == cube_x[13] && is_exist[13] == 1)|
							(cube_y[0] == cube_y[14] && cube_x[0] == cube_x[14] && is_exist[14] == 1)|
							(cube_y[0] == cube_y[15] && cube_x[0] == cube_x[15] && is_exist[15] == 1))
							hit_body <= 1;//�Y��Y����=���@�쨭�骺Y���� �B �Y��X����=���@�쨭�骺X���� �B ���骺�Ӫ��צ�s�b  �I�쨭��
					else begin
						cube_x[1] <= cube_x[0];
						cube_y[1] <= cube_y[0];
										
						cube_x[2] <= cube_x[1];
						cube_y[2] <= cube_y[1];
										
						cube_x[3] <= cube_x[2];
						cube_y[3] <= cube_y[2];
										
						cube_x[4] <= cube_x[3];
						cube_y[4] <= cube_y[3];
										
						cube_x[5] <= cube_x[4];
						cube_y[5] <= cube_y[4];
										
						cube_x[6] <= cube_x[5];
						cube_y[6] <= cube_y[5];
										
						cube_x[7] <= cube_x[6];
						cube_y[7] <= cube_y[6];
										
						cube_x[8] <= cube_x[7];
						cube_y[8] <= cube_y[7];
										
						cube_x[9] <= cube_x[8];
						cube_y[9] <= cube_y[8];
										
						cube_x[10] <= cube_x[9];
						cube_y[10] <= cube_y[9];
										
						cube_x[11] <= cube_x[10];
						cube_y[11] <= cube_y[10];
										
						cube_x[12] <= cube_x[11];
						cube_y[12] <= cube_y[11];
										 
						cube_x[13] <= cube_x[12];
						cube_y[13] <= cube_y[12];
										
						cube_x[14] <= cube_x[13];
						cube_y[14] <= cube_y[13];
										
						cube_x[15] <= cube_x[14];
						cube_y[15] <= cube_y[14];
						//����B�ʺ�k �����צ첾�ʪ��U�ӧ��Ь��U�@�Ӫ��צ��e���� �B�ʸ`������W�᪺�`��
						case(direct)		//					
							UP: begin
							    if(cube_y[0] == 1)
									hit_wall <= 1;
								else
									cube_y[0] <= cube_y[0]-1;
							end
									
							DOWN: begin
								if(cube_y[0] == 28)
									hit_wall <= 1;
								else
									cube_y[0] <= cube_y[0] + 1;
							end
										
							LEFT: begin
								if(cube_x[0] == 1)
									hit_wall <= 1;
								else
									cube_x[0] <= cube_x[0] - 1;											
							end

							RIGHT: begin
								if(cube_x[0] == 38)
									hit_wall <= 1;
                                else
									cube_x[0] <= cube_x[0] + 1;
							end
						endcase				//�ھګ��U����P�_�O�_���� �_�h���W�ߧ����Y������
					end
				end
			end
		end
	end
	
	always @(*) begin   //�ھڷ�e�B�ʪ��A�Y���U���P�_�U�@�B�B�ʱ��p
		direct_next = direct;		
        case(direct)	
		    UP: begin   //�ھګ���i��T�Ӥ�V����ܡA�o�̬O������U���ɭԡA�H���Ǿ�Direct_next�A�M���Direct_next�e��Direct_r�A�̫�A��ȵ�Direct
			    if(change_to_left)
				    direct_next = LEFT;
			    else if(change_to_right)
				    direct_next = RIGHT;
			    else
				    direct_next = UP;			
		    end		
			
		    DOWN: begin
			    if(change_to_left)
				    direct_next = LEFT;
			    else if(change_to_right)
			        direct_next = RIGHT;
			    else
				    direct_next = DOWN;			
		    end		
			
		    LEFT: begin
			    if(change_to_up)
				    direct_next = UP;
			    else if(change_to_down)
    			    direct_next = DOWN;
			    else
				    direct_next = LEFT;			
		    end
		
		    RIGHT: begin
			    if(change_to_up)
				    direct_next = UP;
			    else if(change_to_down)
				    direct_next = DOWN;
			    else
				    direct_next = RIGHT;
		    end	
	    endcase
	end
	
	always @(posedge clk) begin     //���|�ӫ�����
		if(L == 1)
			change_to_left <= 1;
		else if(R == 1)
			change_to_right <= 1;
		else if(U == 1)
			change_to_up <= 1;
		else if(D == 1)
			change_to_down <= 1;
		else begin
			change_to_left <= 0;
			change_to_right <= 0;
			change_to_up <= 0;
			change_to_down <= 0;
		end
	end
	
	always @(posedge clk or posedge clr) begin
//�Y�Uī�G�S�H �A�Y�U�hadd_cube==1�A�������W�[�@��A"is_exixt[cube_num]<=1",����cube_num��"�X�{"	
		if(clr) begin
			is_exist <= 16'd7;
			cube_num <= 3;
			addcube_state <= 0; //��l��ܪ��׬�3�Ais_exist=0000_0000_0111,��ܫe�T��X�{
		end  
		else begin			
			case(addcube_state) //�P�_�D�Y�Pī�G���ЬO�_���X
				0:begin
					if(add_cube) begin
						cube_num <= cube_num + 1;
						is_exist[cube_num] <= 1;
						addcube_state <= 1;
					end						//"�Y�U"�H��
				end
				1:begin
					if(!add_cube)
						addcube_state <= 0;				
				end
			endcase
		end
	end
	
	reg[3:0]lox;
	reg[3:0]loy;
	
	always @(x_pos or y_pos ) begin				
		if(x_pos >= 0 && x_pos < 640 && y_pos >= 0 && y_pos < 480) begin
			if(x_pos[9:4] == 0 | y_pos[9:4] == 0 | x_pos[9:4] == 39 | y_pos[9:4] == 29)
				snake = WALL;//���y��
			else if(x_pos[9:4] == cube_x[0] && y_pos[9:4] == cube_y[0] && is_exist[0] == 1) 
				snake =  HEAD;//���y�Y
			else if
				((x_pos[9:4] == cube_x[1] && y_pos[9:4] == cube_y[1] && is_exist[1] == 1)|
				 (x_pos[9:4] == cube_x[2] && y_pos[9:4] == cube_y[2] && is_exist[2] == 1)|
				 (x_pos[9:4] == cube_x[3] && y_pos[9:4] == cube_y[3] && is_exist[3] == 1)|
				 (x_pos[9:4] == cube_x[4] && y_pos[9:4] == cube_y[4] && is_exist[4] == 1)|
				 (x_pos[9:4] == cube_x[5] && y_pos[9:4] == cube_y[5] && is_exist[5] == 1)|
				 (x_pos[9:4] == cube_x[6] && y_pos[9:4] == cube_y[6] && is_exist[6] == 1)|
				 (x_pos[9:4] == cube_x[7] && y_pos[9:4] == cube_y[7] && is_exist[7] == 1)|
				 (x_pos[9:4] == cube_x[8] && y_pos[9:4] == cube_y[8] && is_exist[8] == 1)|
				 (x_pos[9:4] == cube_x[9] && y_pos[9:4] == cube_y[9] && is_exist[9] == 1)|
				 (x_pos[9:4] == cube_x[10] && y_pos[9:4] == cube_y[10] && is_exist[10] == 1)|
				 (x_pos[9:4] == cube_x[11] && y_pos[9:4] == cube_y[11] && is_exist[11] == 1)|
				 (x_pos[9:4] == cube_x[12] && y_pos[9:4] == cube_y[12] && is_exist[12] == 1)|
				 (x_pos[9:4] == cube_x[13] && y_pos[9:4] == cube_y[13] && is_exist[13] == 1)|
				 (x_pos[9:4] == cube_x[14] && y_pos[9:4] == cube_y[14] && is_exist[14] == 1)|
				 (x_pos[9:4] == cube_x[15] && y_pos[9:4] == cube_y[15] && is_exist[15] == 1))
				 snake = BODY ;//���y����
			else snake = NONE;
		end
	end
endmodule
