module cordic (
    input  logic i_clk, i_reset, i_mode, i_t, i_valid,
    input  logic [31:0] i_x, i_y, i_z,
    output logic [31:0] o_x, o_y, o_z,
    output logic o_stall
);

logic angle_0_360, angle_90_270, angle_180_180, angle_270_90;
logic [3:0] check_angle;
logic [1:0] check7;
logic check1, check2, check3, check4, check5, check6;
logic [5:0] start_check, check;
logic [5:0] o_check1,  o_check2, o_check3, o_check4;
logic [5:0] o_check5,  o_check6, o_check7, o_check8;
logic [5:0] o_check9,  o_check10, o_check11, o_check12;
logic [5:0] o_check13, o_check14, o_check15, o_check16;

logic [31:0] pre_i_x1, pre_i_y1, pre_i_z1;

logic [31:0] z1, z2, z3_1, z3_2, z4;

logic [31:0] start_x, start_y, start_z;
logic [31:0] i_x1,  o_x1,  i_y1,  o_y1,  i_z1,  o_z1;
logic [31:0] i_x2,  o_x2,  i_y2,  o_y2,  i_z2,  o_z2;
logic [31:0] i_x3,  o_x3,  i_y3,  o_y3,  i_z3,  o_z3;
logic [31:0] i_x4,  o_x4,  i_y4,  o_y4,  i_z4,  o_z4;
logic [31:0] i_x5,  o_x5,  i_y5,  o_y5,  i_z5,  o_z5;
logic [31:0] i_x6,  o_x6,  i_y6,  o_y6,  i_z6,  o_z6;
logic [31:0] i_x7,  o_x7,  i_y7,  o_y7,  i_z7,  o_z7;
logic [31:0] i_x8,  o_x8,  i_y8,  o_y8,  i_z8,  o_z8;
logic [31:0] i_x9,  o_x9,  i_y9,  o_y9,  i_z9,  o_z9;
logic [31:0] i_x10, o_x10, i_y10, o_y10, i_z10, o_z10;
logic [31:0] i_x11, o_x11, i_y11, o_y11, i_z11, o_z11;
logic [31:0] i_x12, o_x12, i_y12, o_y12, i_z12, o_z12;
logic [31:0] i_x13, o_x13, i_y13, o_y13, i_z13, o_z13;
logic [31:0] i_x14, o_x14, i_y14, o_y14, i_z14, o_z14;
logic [31:0] i_x15, o_x15, i_y15, o_y15, i_z15, o_z15;
logic [31:0] i_x16, o_x16, i_y16, o_y16, i_z16, o_z16;

logic [31:0] delay19_x, delay19_y;
logic [31:0] x1, y1;

logic sign_x_stage1,  sign_yz_stage1;
logic sign_x_stage2,  sign_yz_stage2;
logic sign_x_stage3,  sign_yz_stage3;
logic sign_x_stage4,  sign_yz_stage4;
logic sign_x_stage5,  sign_yz_stage5;
logic sign_x_stage6,  sign_yz_stage6;
logic sign_x_stage7,  sign_yz_stage7;
logic sign_x_stage8,  sign_yz_stage8;
logic sign_x_stage9,  sign_yz_stage9;
logic sign_x_stage10, sign_yz_stage10;
logic sign_x_stage11, sign_yz_stage11;
logic sign_x_stage12, sign_yz_stage12;
logic sign_x_stage13, sign_yz_stage13;
logic sign_x_stage14, sign_yz_stage14;
logic sign_x_stage15, sign_yz_stage15;

logic [31:0] arc1, arc2, arc3,  arc4,  arc5,  arc6,  arc7;
logic [31:0] arc8, arc9, arc10, arc11, arc12, arc13, arc14, arc15;

logic [4:0] wait_count;
logic is_busy;

assign o_stall = (i_valid & ~is_busy) | (is_busy & (wait_count > 0));

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        wait_count <= 5'd0;
        is_busy    <= 1'b0;
    end else begin
        if (i_valid && !is_busy) begin
            is_busy    <= 1'b1;  
            wait_count <= 5'd19; 
        end 
        else if (is_busy) begin
            if (wait_count > 0) begin
                wait_count <= wait_count - 5'd1;
            end else begin
                is_busy <= 1'b0; 
            end
        end
    end
end

//      _                _            _       _  _            _                       _   
//     / \   _ __   __ _| | ___      / \   __| |(_)_   _ ___| |_ _ __ ___   ___ _ __ | |_ 
//    / _ \ | '_ \ / _` | |/ _ \    / _ \ / _` || | | | / __| __| '_ ` _ \ / _ \ '_ \| __|
//   / ___ \| | | | (_| | |  __/   / ___ \ (_| || | |_| \__ \ |_| | | | | |  __/ | | | |_ 
//  /_/   \_\_| |_|\__, |_|\___|  /_/   \_\__,_|/ |\__,_|___/\__|_| |_| |_|\___|_| |_|\__|
//                 |___/                      |__/                                        

fadder fpu_i_z (
   .i_a(i_z), 
   .i_b(32'h40c90fdb), 
   .i_rm(2'b00), 
   .i_sub(1'b0), 
   
   .o_s(z1)
); // z + 360

always @(*) begin
    if (i_z[31]) z2 = z1;
    else         z2 = i_z;
end

comparator cmp1 (
   .a(z2), 
   .b(32'h3fc90fdb), 
   .signed_mode(1'b0), 
   
   .Gr(check1)
);
comparator cmp2 (
   .a(z2), 
   .b(32'h4096cbe4), 
   .signed_mode(1'b0), 
   
   .Lt(check2), 
   .Gr(check3)
); //90 < z2 < 270
comparator cmp3 (
   .a(z2), 
   .b(32'h40c90fdb), 
   .signed_mode(1'b0), 
   
   .Lt(check4)
);

fadder fpuz1 (
   .i_a(z2), 
   .i_b(32'h40490fdb), 
   .i_rm(2'b00), 
   .i_sub(1'b1), 
   
   .o_s(z3_1)
); // z2 - 180
fadder fpuz2 (
   .i_a(z2), 
   .i_b(32'h40c90fdb), 
   .i_rm(2'b00), 
   .i_sub(1'b1), 
   
   .o_s(z3_2)
); // z2 - 360

assign check5 = check1 & check2;
assign check6 = check3 & check4;
assign check7 = {check6, check5};

mux4to1 muxcheck (
   .i_data_0(z2), 
   .i_data_1(z3_1), 
   .i_data_2(z3_2), 
   .i_data_3(32'b0), 
   .i_sel(check7), 
   
   .o_data(z4)
);

assign angle_0_360   = (~i_z[30] & ~i_z[29] & ~i_z[28] &
                        ~i_z[27] & ~i_z[26] & ~i_z[25] & ~i_z[24] &
                        ~i_z[23] & ~i_z[22] & ~i_z[21] & ~i_z[20] &
                        ~i_z[19] & ~i_z[18] & ~i_z[17] & ~i_z[16] &
                        ~i_z[15] & ~i_z[14] & ~i_z[13] & ~i_z[12] &
                        ~i_z[11] & ~i_z[10] & ~i_z[9]  & ~i_z[8]  &
                        ~i_z[7]  & ~i_z[6]  & ~i_z[5]  & ~i_z[4]  &
                        ~i_z[3]  & ~i_z[2]  & ~i_z[1]  & ~i_z[0]) | /*0*/
                       
                       ( i_z[30] & ~i_z[29] & ~i_z[28] &
                        ~i_z[27] & ~i_z[26] & ~i_z[25] & ~i_z[24] &
                         i_z[23] &  i_z[22] & ~i_z[21] & ~i_z[20] &
                         i_z[19] & ~i_z[18] & ~i_z[17] &  i_z[16] &
                        ~i_z[15] & ~i_z[14] & ~i_z[13] & ~i_z[12] &
                         i_z[11] &  i_z[10] &  i_z[9]  &  i_z[8]  &
                         i_z[7]  &  i_z[6]  & ~i_z[5]  &  i_z[4]  &
                         i_z[3]  & ~i_z[2]  &  i_z[1]  &  i_z[0]);  /*360 -360*/
assign angle_90_270  = (~i_z[31] & ~i_z[30] &  i_z[29] &  i_z[28] &
                         i_z[27] &  i_z[26] &  i_z[25] &  i_z[24] &
                         i_z[23] &  i_z[22] & ~i_z[21] & ~i_z[20] &
                         i_z[19] & ~i_z[18] & ~i_z[17] &  i_z[16] &
                        ~i_z[15] & ~i_z[14] & ~i_z[13] & ~i_z[12] &
                         i_z[11] &  i_z[10] &  i_z[9]  &  i_z[8]  &
                         i_z[7]  &  i_z[6]  & ~i_z[5]  &  i_z[4]  &
                         i_z[3]  & ~i_z[2]  &  i_z[1]  &  i_z[0]) | /*90*/
                        
                       ( i_z[31] &  i_z[30] & ~i_z[29] & ~i_z[28] &
                        ~i_z[27] & ~i_z[26] & ~i_z[25] & ~i_z[24] &
                         i_z[23] & ~i_z[22] & ~i_z[21] &  i_z[20] &
                        ~i_z[19] &  i_z[18] &  i_z[17] & ~i_z[16] &
                         i_z[15] &  i_z[14] & ~i_z[13] & ~i_z[12] &
                         i_z[11] & ~i_z[10] &  i_z[9]  &  i_z[8]  &
                         i_z[7]  &  i_z[6]  &  i_z[5]  & ~i_z[4]  &
                        ~i_z[3]  &  i_z[2]  & ~i_z[1]  & ~i_z[0]); /*-270*/
assign angle_180_180 = ( i_z[30] & ~i_z[29] & ~i_z[28] &
                        ~i_z[27] & ~i_z[26] & ~i_z[25] & ~i_z[24] &
                        ~i_z[23] &  i_z[22] & ~i_z[21] & ~i_z[20] &
                         i_z[19] & ~i_z[18] & ~i_z[17] &  i_z[16] &
                        ~i_z[15] & ~i_z[14] & ~i_z[13] & ~i_z[12] &
                         i_z[11] &  i_z[10] &  i_z[9]  &  i_z[8]  &
                         i_z[7]  &  i_z[6]  & ~i_z[5]  &  i_z[4]  &
                         i_z[3]  & ~i_z[2]  &  i_z[1]  &  i_z[0]) ; //180 -180
assign angle_270_90  = ( i_z[31] & ~i_z[30] &  i_z[29] &  i_z[28] &
                         i_z[27] &  i_z[26] &  i_z[25] &  i_z[24] &
                         i_z[23] &  i_z[22] & ~i_z[21] & ~i_z[20] &
                         i_z[19] & ~i_z[18] & ~i_z[17] &  i_z[16] &
                        ~i_z[15] & ~i_z[14] & ~i_z[13] & ~i_z[12] &
                         i_z[11] &  i_z[10] &  i_z[9]  &  i_z[8]  &
                         i_z[7]  &  i_z[6]  & ~i_z[5]  &  i_z[4]  &
                         i_z[3]  & ~i_z[2]  &  i_z[1]  &  i_z[0]) | /*-90*/
                        
                       (~i_z[31] &  i_z[30] & ~i_z[29] & ~i_z[28] &
                        ~i_z[27] & ~i_z[26] & ~i_z[25] & ~i_z[24] &
                         i_z[23] & ~i_z[22] & ~i_z[21] &  i_z[20] &
                        ~i_z[19] &  i_z[18] &  i_z[17] & ~i_z[16] &
                         i_z[15] &  i_z[14] & ~i_z[13] & ~i_z[12] &
                         i_z[11] & ~i_z[10] &  i_z[9]  &  i_z[8]  &
                         i_z[7]  &  i_z[6]  &  i_z[5]  & ~i_z[4]  &
                        ~i_z[3]  &  i_z[2]  & ~i_z[1]  & ~i_z[0]); /*270*/

assign check_angle = {angle_270_90, angle_180_180, angle_90_270, angle_0_360};
assign check = {check_angle, check7};

delay_19 delay19x (
   .i_clk(i_clk), 
   .i_reset(i_reset), 
   .i_data(i_x), 
   
   .o_data(delay19_x)
);
delay_19 delay19y (
   .i_clk(i_clk), 
   .i_reset(i_reset), 
   .i_data(i_y), 
   
   .o_data(delay19_y)
); 

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        start_x     <= 32'b0;
        start_y     <= 32'b0;
        start_z     <= 32'b0;
        start_check <= 6'b0;
    end else begin
        start_x     <= i_x;
        start_y     <= i_y;
        start_z     <= i_t ? z4 : i_z;
        start_check <= check;
    end
end
        
//      ____  _                      ___  
//     / ___|| |_ __ _  __ _  ___   / _ \ 
//     \___ \| __/ _` |/ _` |/ _ \ | | | |
//      ___) | || (_| | (_| |  __/ | |_| |
//     |____/ \__\__,_|\__, |\___|  \___/ 
//                     |___/              

fadder fpu_x0 (
   .i_a(start_x), 
   .i_b(start_y), 
   .i_rm(2'b00), 
   .i_sub(~start_z[31]), 
   
   .o_s(pre_i_x1)
);

fadder fpu_y0 (
   .i_a(start_y), 
   .i_b(start_x), 
   .i_rm(2'b00), 
   .i_sub(start_z[31]), 
   .o_s(pre_i_y1)
);

fadder fpu_z0 (
   .i_a(start_z), 
   .i_b(32'h3f490fdb), 
   .i_rm(2'b00), 
   .i_sub(~start_z[31]), 
   
   .o_s(pre_i_z1)
); // arctan(2^-0) = 0.7853981634

always @(*) begin
   if (i_t) begin
      i_x1 = pre_i_x1;
      i_y1 = pre_i_y1;
      i_z1 = pre_i_z1;
   end else begin
      i_x1 = start_x;
      i_y1 = start_y;
      i_z1 = start_z;
   end
end

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        o_x1     <= 32'b0; 
        o_y1     <= 32'b0; 
        o_z1     <= 32'b0; 
        o_check1 <= 0;
    end else begin
        o_x1     <= i_x1;  
        o_y1     <= i_y1;  
        o_z1     <= i_z1;  
        o_check1 <= start_check;
    end
end

//      ____  _                     _ 
//     / ___|| |_ __ _  __ _  ___  / |
//     \___ \| __/ _` |/ _` |/ _ \ | |
//      ___) | || (_| | (_| |  __/ | |
//     |____/ \__\__,_|\__, |\___| |_|
//                     |___/          
sig_gen sig_gen_stage1 (
   .i_sign_y(o_y1[31]),
   .i_sign_z(o_z1[31]),
   .i_mode(i_mode),
   .i_t(i_t),
   
   .o_sel_x(sign_x_stage1),
   .o_sel_y(sign_yz_stage1)
);

always @(*) begin
   if (i_t) arc1 = 32'h3eed6338; // arctan (2^-1) = 0.463647609
   else     arc1 = 32'h3f0c9f54; // arctanh(2^-1) = 0.5493061443
end

logic [31:0] shift_o_x1, shift_o_y1;

always @(*) begin
    if (o_x1[30:23] <= 8'h1) begin
        shift_o_x1 = 32'b0;
    end else begin
        shift_o_x1 = {o_x1[31], o_x1[30:23] - 8'h1, o_x1[22:0]};
    end
    
    if (o_y1[30:23] <= 8'h1) begin
        shift_o_y1 = 32'b0;
    end else begin
        shift_o_y1 = {o_y1[31], o_y1[30:23] - 8'h1, o_y1[22:0]};
    end
end

fadder fpu_x1 (
   .i_a(o_x1), 
   .i_b(shift_o_y1), 
   .i_rm(2'b00), 
   .i_sub(sign_x_stage1), 
   
   .o_s(i_x2)
);
 
fadder fpu_y1 (
   .i_a(o_y1), 
   .i_b(shift_o_x1), 
   .i_rm(2'b00), 
   .i_sub(sign_yz_stage1), 
   
   .o_s(i_y2)
);

fadder fpu_z1 (
   .i_a(o_z1), 
   .i_b(arc1), 
   .i_rm(2'b00), 
   .i_sub(~sign_yz_stage1), 
   
   .o_s(i_z2)
);

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        o_x2     <= 32'b0; 
        o_y2     <= 32'b0; 
        o_z2     <= 32'b0; 
        o_check2 <= 0;
    end else begin
        o_x2     <= i_x2;  
        o_y2     <= i_y2;  
        o_z2     <= i_z2;  
        o_check2 <= o_check1;
    end
end

//      ____  _                     ____  
//     / ___|| |_ __ _  __ _  ___  |___ \ 
//     \___ \| __/ _` |/ _` |/ _ \   __) |
//      ___) | || (_| | (_| |  __/  / __/ 
//     |____/ \__\__,_|\__, |\___| |_____|
//                     |___/              
sig_gen sig_gen_stage2 (
   .i_sign_y(o_y2[31]),
   .i_sign_z(o_z2[31]),
   .i_mode(i_mode),
   .i_t(i_t),
   
   .o_sel_x(sign_x_stage2),
   .o_sel_y(sign_yz_stage2)
);

always @(*) begin
   if (i_t) arc2 = 32'h3e7adbb0; // arctan(2^-2) = 0.2449786631
   else     arc2 = 32'h3e82c578; // arctanh(2^-2) = 0.2554128119
end

logic [31:0] shift_o_x2, shift_o_y2;

always @(*) begin
    if (o_x2[30:23] <= 8'h2) begin
        shift_o_x2 = 32'b0;
    end else begin
        shift_o_x2 = {o_x2[31], o_x2[30:23] - 8'h2, o_x2[22:0]};
    end
    if (o_y2[30:23] <= 8'h2) begin
        shift_o_y2 = 32'b0;
    end else begin
        shift_o_y2 = {o_y2[31], o_y2[30:23] - 8'h2, o_y2[22:0]};
    end
end

fadder fpu_x2 (
    .i_a(o_x2), 
    .i_b(shift_o_y2), 
    .i_rm(2'b00), 
    .i_sub(sign_x_stage2), 
    
    .o_s(i_x3)
);
 
fadder fpu_y2 (
    .i_a(o_y2), 
    .i_b(shift_o_x2), 
    .i_rm(2'b00), 
    .i_sub(sign_yz_stage2), 
    
    .o_s(i_y3)
);

fadder fpu_z2 (
    .i_a(o_z2), 
    .i_b(arc2), 
    .i_rm(2'b00), 
    .i_sub(~sign_yz_stage2),
    
    .o_s(i_z3)
);

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        o_x3     <= 32'b0; 
        o_y3     <= 32'b0; 
        o_z3     <= 32'b0; 
        o_check3 <= 6'b0;
    end else begin
        o_x3     <= i_x3;  
        o_y3     <= i_y3;  
        o_z3     <= i_z3;  
        o_check3 <= o_check2; 
    end
end

//      ____  _                     _____ 
//     / ___|| |_ __ _  __ _  ___  |___ / 
//     \___ \| __/ _` |/ _` |/ _ \   |_ \ 
//      ___) | || (_| | (_| |  __/  ___) |
//     |____/ \__\__,_|\__, |\___| |____/ 
//                     |___/              
sig_gen sig_gen_stage3 (
    .i_sign_y(o_y3[31]),
    .i_sign_z(o_z3[31]),
    .i_mode(i_mode),
    .i_t(i_t),
    
    .o_sel_x(sign_x_stage3),
    .o_sel_y(sign_yz_stage3)
);

always @(*) begin
    if (i_t) arc3 = 32'h3dfeadd5; // arctan(2^-3) = 0.1243549945
    else     arc3 = 32'h3e00ac49; // arctanh(2^-3) = 0.1256572141
end

logic [31:0] shift_o_x3, shift_o_y3;

always @(*) begin
    if (o_x3[30:23] <= 8'h3) begin
        shift_o_x3 = 32'b0;
    end else begin
        shift_o_x3 = {o_x3[31], o_x3[30:23] - 8'h3, o_x3[22:0]};
    end
    if (o_y3[30:23] <= 8'h3) begin
        shift_o_y3 = 32'b0;
    end else begin
        shift_o_y3 = {o_y3[31], o_y3[30:23] - 8'h3, o_y3[22:0]};
    end
end

fadder fpu_x3 (
    .i_a(o_x3), 
    .i_b(shift_o_y3), 
    .i_rm(2'b00), 
    .i_sub(sign_x_stage3), 
    
    .o_s(i_x4)
);
 
fadder fpu_y3 (
    .i_a(o_y3), 
    .i_b(shift_o_x3), 
    .i_rm(2'b00), 
    .i_sub(sign_yz_stage3), 
    
    .o_s(i_y4)
);

fadder fpu_z3 (
    .i_a(o_z3), 
    .i_b(arc3), 
    .i_rm(2'b00), 
    .i_sub(~sign_yz_stage3), 
    
    .o_s(i_z4)
);

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        o_x4     <= 32'b0; 
        o_y4     <= 32'b0; 
        o_z4     <= 32'b0; 
        o_check4 <= 6'b0;
    end else begin
        o_x4     <= i_x4;  
        o_y4     <= i_y4;  
        o_z4     <= i_z4;  
        o_check4 <= o_check3; 
    end
end

//      ____  _                     _  _   
//     / ___|| |_ __ _  __ _  ___  | || |  
//     \___ \| __/ _` |/ _` |/ _ \ | || |_ 
//      ___) | || (_| | (_| |  __/ |__   _|
//     |____/ \__\__,_|\__, |\___|    |_|  
//                     |___/                
sig_gen sig_gen_stage4 (
    .i_sign_y(o_y4[31]),
    .i_sign_z(o_z4[31]),
    .i_mode(i_mode),
    .i_t(i_t),
    
    .o_sel_x(sign_x_stage4),
    .o_sel_y(sign_yz_stage4)
);

always @(*) begin
    if (i_t) arc4 = 32'h3d7faade; // arctan(2^-4)  = 0.06241881
    else     arc4 = 32'h3d802ac4; // arctanh(2^-4) = 0.06258157148
end

logic [31:0] shift_o_x4, shift_o_y4;

always @(*) begin
    if (o_x4[30:23] <= 8'h4) begin
        shift_o_x4 = 32'b0;
    end else begin
        shift_o_x4 = {o_x4[31], o_x4[30:23] - 8'h4, o_x4[22:0]};
    end
    if (o_y4[30:23] <= 8'h4) begin
        shift_o_y4 = 32'b0;
    end else begin
        shift_o_y4 = {o_y4[31], o_y4[30:23] - 8'h4, o_y4[22:0]};
    end
end

fadder fpu_x4 (
    .i_a(o_x4), 
    .i_b(shift_o_y4), 
    .i_rm(2'b00), 
    .i_sub(sign_x_stage4), 
    
    .o_s(i_x5)
);
 
fadder fpu_y4 (
    .i_a(o_y4), 
    .i_b(shift_o_x4), 
    .i_rm(2'b00), 
    .i_sub(sign_yz_stage4), 
    
    .o_s(i_y5)
);

fadder fpu_z4 (
    .i_a(o_z4), 
    .i_b(arc4), 
    .i_rm(2'b00), 
    .i_sub(~sign_yz_stage4), 
    
    .o_s(i_z5)
);

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        o_x5     <= 32'b0; 
        o_y5     <= 32'b0; 
        o_z5     <= 32'b0; 
        o_check5 <= 6'b0;
    end else begin
        o_x5     <= i_x5;  
        o_y5     <= i_y5;  
        o_z5     <= i_z5;  
        o_check5 <= o_check4; 
    end
end

//      ____  _                     _  _     ____                       _   
//     / ___|| |_ __ _  __ _  ___  | || |   |  _ \ ___ _ __   ___  __ _| |_ 
//     \___ \| __/ _` |/ _` |/ _ \ | || |_  | |_) / _ \ '_ \ / _ \/ _` | __|
//      ___) | || (_| | (_| |  __/ |__   _| |  _ <  __/ |_) |  __/ (_| | |_ 
//     |____/ \__\__,_|\__, |\___|    |_|   |_| \_\___| .__/ \___|\__,_|\__|
//                     |___/                          |_|                   

logic sign_x_stage4_rep, sign_yz_stage4_rep;
logic [31:0] arc4_rep;

sig_gen sig_gen_stage4_rep (
    .i_sign_y(o_y5[31]),
    .i_sign_z(o_z5[31]),
    .i_mode(i_mode),
    .i_t(i_t),
    
    .o_sel_x(sign_x_stage4_rep),
    .o_sel_y(sign_yz_stage4_rep)
);

assign arc4_rep = 32'h3d802ac4; // arctanh(2^-4) = 0.06258157148

logic [31:0] shift_o_x4_rep, shift_o_y4_rep;

always @(*) begin
    if (o_x5[30:23] <= 8'h4) begin
        shift_o_x4_rep = 32'b0;
    end else begin
        shift_o_x4_rep = {o_x5[31], o_x5[30:23] - 8'h4, o_x5[22:0]};
    end
    if (o_y5[30:23] <= 8'h4) begin
        shift_o_y4_rep = 32'b0;
    end else begin
        shift_o_y4_rep = {o_y5[31], o_y5[30:23] - 8'h4, o_y5[22:0]};
    end
end

logic [31:0] i_x5_rep_calc, i_y5_rep_calc, i_z5_rep_calc;

fadder fpu_x4_rep (
    .i_a(o_x5), 
    .i_b(shift_o_y4_rep), 
    .i_rm(2'b00), 
    .i_sub(sign_x_stage4_rep), 
    
    .o_s(i_x5_rep_calc)
);
 
fadder fpu_y4_rep (
    .i_a(o_y5), 
    .i_b(shift_o_x4_rep), 
    .i_rm(2'b00), 
    .i_sub(sign_yz_stage4_rep), 
    
    .o_s(i_y5_rep_calc)
);

fadder fpu_z4_rep (
    .i_a(o_z5), 
    .i_b(arc4_rep), 
    .i_rm(2'b00), 
    .i_sub(~sign_yz_stage4_rep), 
    
    .o_s(i_z5_rep_calc)
);

logic [31:0] i_x5_rep, i_y5_rep, i_z5_rep;

always @(*) begin
    if (i_t) begin
        i_x5_rep = o_x5;
        i_y5_rep = o_y5;
        i_z5_rep = o_z5;
    end else begin
        i_x5_rep = i_x5_rep_calc;
        i_y5_rep = i_y5_rep_calc;
        i_z5_rep = i_z5_rep_calc;
    end
end

logic [31:0] o_x5_rep, o_y5_rep, o_z5_rep;
logic [5:0] o_check5_rep;

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        o_x5_rep     <= 32'b0; 
        o_y5_rep     <= 32'b0; 
        o_z5_rep     <= 32'b0; 
        o_check5_rep <= 6'b0;
    end else begin
        o_x5_rep     <= i_x5_rep;  
        o_y5_rep     <= i_y5_rep;  
        o_z5_rep     <= i_z5_rep;  
        o_check5_rep <= o_check5; 
    end
end

//      ____  _                     ____  
//     / ___|| |_ __ _  __ _  ___  | ___| 
//     \___ \| __/ _` |/ _` |/ _ \ |___ \ 
//      ___) | || (_| | (_| |  __/  ___) |
//     |____/ \__\__,_|\__, |\___| |____/ 
//                     |___/              
sig_gen sig_gen_stage5 (
    .i_sign_y(o_y5_rep[31]),
    .i_sign_z(o_z5_rep[31]),
    .i_mode(i_mode),
    .i_t(i_t),
    
    .o_sel_x(sign_x_stage5),
    .o_sel_y(sign_yz_stage5)
);

always @(*) begin
    if (i_t) arc5 = 32'h3cffeaae; // arctan(2^-5)  = 0.03123983343
    else     arc5 = 32'h3d000aac; // arctanh(2^-5) = 0.03126017849
end

logic [31:0] shift_o_x5, shift_o_y5;

always @(*) begin
    if (o_x5_rep[30:23] <= 8'h5) begin
        shift_o_x5 = 32'b0;
    end else begin
        shift_o_x5 = {o_x5_rep[31], o_x5_rep[30:23] - 8'h5, o_x5_rep[22:0]};
    end
    if (o_y5_rep[30:23] <= 8'h5) begin
        shift_o_y5 = 32'b0;
    end else begin
        shift_o_y5 = {o_y5_rep[31], o_y5_rep[30:23] - 8'h5, o_y5_rep[22:0]};
    end
end

fadder fpu_x5 (
    .i_a(o_x5_rep), 
    .i_b(shift_o_y5), 
    .i_rm(2'b00), 
    .i_sub(sign_x_stage5), 
    
    .o_s(i_x6)
);
 
fadder fpu_y5 (
    .i_a(o_y5_rep), 
    .i_b(shift_o_x5), 
    .i_rm(2'b00), 
    .i_sub(sign_yz_stage5), 
    
    .o_s(i_y6)
);

fadder fpu_z5 (
    .i_a(o_z5_rep), 
    .i_b(arc5), 
    .i_rm(2'b00), 
    .i_sub(~sign_yz_stage5), 
    
    .o_s(i_z6)
);

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        o_x6     <= 32'b0; 
        o_y6     <= 32'b0; 
        o_z6     <= 32'b0; 
        o_check6 <= 6'b0;
    end else begin
        o_x6     <= i_x6;  
        o_y6     <= i_y6;  
        o_z6     <= i_z6;  
        o_check6 <= o_check5_rep;
    end
end

//      ____  _                      __   
//     / ___|| |_ __ _  __ _  ___   / /_  
//     \___ \| __/ _` |/ _` |/ _ \ | '_ \ 
//      ___) | || (_| | (_| |  __/ | (_) |
//     |____/ \__\__,_|\__, |\___|  \___/ 
//                     |___/              
sig_gen sig_gen_stage6 (
    .i_sign_y(o_y6[31]),
    .i_sign_z(o_z6[31]),
    .i_mode(i_mode),
    .i_t(i_t),
    
    .o_sel_x(sign_x_stage6),
    .o_sel_y(sign_yz_stage6)
);

always @(*) begin
    if (i_t) arc6 = 32'h3c7ffaab; // arctan(2^-6)  = 0.01562372862
    else     arc6 = 32'h3c8002ab; // arctanh(2^-6) = 0.01562627175
end

logic [31:0] shift_o_x6, shift_o_y6;

always @(*) begin
    if (o_x6[30:23] <= 8'h6) begin
        shift_o_x6 = 32'b0;
    end else begin
        shift_o_x6 = {o_x6[31], o_x6[30:23] - 8'h6, o_x6[22:0]};
    end
    if (o_y6[30:23] <= 8'h6) begin
        shift_o_y6 = 32'b0;
    end else begin
        shift_o_y6 = {o_y6[31], o_y6[30:23] - 8'h6, o_y6[22:0]};
    end
end

fadder fpu_x6 (
    .i_a(o_x6), 
    .i_b(shift_o_y6), 
    .i_rm(2'b00), 
    .i_sub(sign_x_stage6), 
    
    .o_s(i_x7)
);
 
fadder fpu_y6 (
    .i_a(o_y6), 
    .i_b(shift_o_x6), 
    .i_rm(2'b00), 
    .i_sub(sign_yz_stage6), 
    
    .o_s(i_y7)
);

fadder fpu_z6 (
    .i_a(o_z6), 
    .i_b(arc6), 
    .i_rm(2'b00), 
    .i_sub(~sign_yz_stage6), 
    
    .o_s(i_z7)
);

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        o_x7     <= 32'b0; 
        o_y7     <= 32'b0; 
        o_z7     <= 32'b0; 
        o_check7 <= 6'b0;
    end else begin
        o_x7     <= i_x7;  
        o_y7     <= i_y7;  
        o_z7     <= i_z7;  
        o_check7 <= o_check6; 
    end
end

//      ____  _                     _____ 
//     / ___|| |_ __ _  __ _  ___  |___  |
//     \___ \| __/ _` |/ _` |/ _ \    / / 
//      ___) | || (_| | (_| |  __/   / /  
//     |____/ \__\__,_|\__, |\___|  /_/   
//                     |___/              
sig_gen sig_gen_stage7 (
    .i_sign_y(o_y7[31]),
    .i_sign_z(o_z7[31]),
    .i_mode(i_mode),
    .i_t(i_t),
    
    .o_sel_x(sign_x_stage7),
    .o_sel_y(sign_yz_stage7)
);

always @(*) begin
    if (i_t) arc7 = 32'h3bfffeab; // arctan(2^-7)  = 0.00781234106
    else     arc7 = 32'h3c0000ab; // arctanh(2^-7) = 0.007812658952
end

logic [31:0] shift_o_x7, shift_o_y7;

always @(*) begin
    if (o_x7[30:23] <= 8'h7) begin
        shift_o_x7 = 32'b0;
    end else begin
        shift_o_x7 = {o_x7[31], o_x7[30:23] - 8'h7, o_x7[22:0]};
    end
    if (o_y7[30:23] <= 8'h7) begin
        shift_o_y7 = 32'b0;
    end else begin
        shift_o_y7 = {o_y7[31], o_y7[30:23] - 8'h7, o_y7[22:0]};
    end
end

fadder fpu_x7 (
    .i_a(o_x7), 
    .i_b(shift_o_y7), 
    .i_rm(2'b00), 
    .i_sub(sign_x_stage7), 
    
    .o_s(i_x8)
);
 
fadder fpu_y7 (
    .i_a(o_y7), 
    .i_b(shift_o_x7), 
    .i_rm(2'b00), 
    .i_sub(sign_yz_stage7), 
    
    .o_s(i_y8)
);

fadder fpu_z7 (
    .i_a(o_z7), 
    .i_b(arc7), 
    .i_rm(2'b00), 
    .i_sub(~sign_yz_stage7), 
    
    .o_s(i_z8)
);

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        o_x8     <= 32'b0; 
        o_y8     <= 32'b0; 
        o_z8     <= 32'b0; 
        o_check8 <= 6'b0;
    end else begin
        o_x8     <= i_x8;  
        o_y8     <= i_y8;  
        o_z8     <= i_z8;  
        o_check8 <= o_check7; 
    end
end

//      ____  _                      ___  
//     / ___|| |_ __ _  __ _  ___   ( _ ) 
//     \___ \| __/ _` |/ _` |/ _ \  / _ \ 
//      ___) | || (_| | (_| |  __/ | (_) |
//     |____/ \__\__,_|\__, |\___|  \___/ 
//                     |___/              
sig_gen sig_gen_stage8 (
    .i_sign_y(o_y8[31]),
    .i_sign_z(o_z8[31]),
    .i_mode(i_mode),
    .i_t(i_t),
    
    .o_sel_x(sign_x_stage8),
    .o_sel_y(sign_yz_stage8)
);

always @(*) begin
    if (i_t) arc8 = 32'h3b7fffab; // arctan(2^-8)  = 0.003906230132
    else     arc8 = 32'h3b80002b; // arctanh(2^-8) = 0.003906269868
end

logic [31:0] shift_o_x8, shift_o_y8;

always @(*) begin
    if (o_x8[30:23] <= 8'h8) begin
        shift_o_x8 = 32'b0;
    end else begin
        shift_o_x8 = {o_x8[31], o_x8[30:23] - 8'h8, o_x8[22:0]};
    end
    if (o_y8[30:23] <= 8'h8) begin
        shift_o_y8 = 32'b0;
    end else begin
        shift_o_y8 = {o_y8[31], o_y8[30:23] - 8'h8, o_y8[22:0]};
    end
end

fadder fpu_x8 (
    .i_a(o_x8), 
    .i_b(shift_o_y8), 
    .i_rm(2'b00), 
    .i_sub(sign_x_stage8), 
    
    .o_s(i_x9)
);
 
fadder fpu_y8 (
    .i_a(o_y8), 
    .i_b(shift_o_x8), 
    .i_rm(2'b00), 
    .i_sub(sign_yz_stage8), 
    
    .o_s(i_y9)
);

fadder fpu_z8 (
    .i_a(o_z8), 
    .i_b(arc8), 
    .i_rm(2'b00), 
    .i_sub(~sign_yz_stage8), 
    
    .o_s(i_z9)
);

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        o_x9     <= 32'b0; 
        o_y9     <= 32'b0; 
        o_z9     <= 32'b0; 
        o_check9 <= 6'b0;
    end else begin
        o_x9     <= i_x9;  
        o_y9     <= i_y9;  
        o_z9     <= i_z9;  
        o_check9 <= o_check8; 
    end
end

//      ____  _                      ___  
//     / ___|| |_ __ _  __ _  ___   / _ \ 
//     \___ \| __/ _` |/ _` |/ _ \ | (_) |
//      ___) | || (_| | (_| |  __/  \__, |
//     |____/ \__\__,_|\__, |\___|    /_/ 
//                     |___/              
sig_gen sig_gen_stage9 (
    .i_sign_y(o_y9[31]),
    .i_sign_z(o_z9[31]),
    .i_mode(i_mode),
    .i_t(i_t),
    
    .o_sel_x(sign_x_stage9),
    .o_sel_y(sign_yz_stage9)
);

always @(*) begin
    if (i_t) arc9 = 32'h3affffeb; // arctan(2^-9)  = 0.001953122516
    else     arc9 = 32'h3b00000b; // arctanh(2^-9) = 0.001953127484
end

logic [31:0] shift_o_x9, shift_o_y9;

always @(*) begin
    if (o_x9[30:23] <= 8'h9) begin
        shift_o_x9 = 32'b0;
    end else begin
        shift_o_x9 = {o_x9[31], o_x9[30:23] - 8'h9, o_x9[22:0]};
    end
    if (o_y9[30:23] <= 8'h9) begin
        shift_o_y9 = 32'b0;
    end else begin
        shift_o_y9 = {o_y9[31], o_y9[30:23] - 8'h9, o_y9[22:0]};
    end
end

fadder fpu_x9 (
    .i_a(o_x9), 
    .i_b(shift_o_y9), 
    .i_rm(2'b00), 
    .i_sub(sign_x_stage9), 
    
    .o_s(i_x10)
);
 
fadder fpu_y9 (
    .i_a(o_y9), 
    .i_b(shift_o_x9), 
    .i_rm(2'b00), 
    .i_sub(sign_yz_stage9), 
    
    .o_s(i_y10)
);

fadder fpu_z9 (
    .i_a(o_z9), 
    .i_b(arc9), 
    .i_rm(2'b00), 
    .i_sub(~sign_yz_stage9), 
    
    .o_s(i_z10)
);

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        o_x10     <= 32'b0; 
        o_y10     <= 32'b0; 
        o_z10     <= 32'b0; 
        o_check10 <= 6'b0;
    end else begin
        o_x10     <= i_x10;  
        o_y10     <= i_y10;  
        o_z10     <= i_z10;  
        o_check10 <= o_check9; 
    end
end

//      ____  _                     _  ___  
//     / ___|| |_ __ _  __ _  ___  / |/ _ \ 
//     \___ \| __/ _` |/ _` |/ _ \ | | | | |
//      ___) | || (_| | (_| |  __/ | | |_| |
//     |____/ \__\__,_|\__, |\___| |_|\___/ 
//                     |___/                
sig_gen sig_gen_stage10 (
    .i_sign_y(o_y10[31]),
    .i_sign_z(o_z10[31]),
    .i_mode(i_mode),
    .i_t(i_t),
    
    .o_sel_x(sign_x_stage10),
    .o_sel_y(sign_yz_stage10)
);

always @(*) begin
    if (i_t) arc10 = 32'h3a7ffffb; // arctan(2^-10)  = 9.765621896e-4
    else     arc10 = 32'h3a800003; // arctanh(2^-10) = 9.765628104e-4
end

logic [31:0] shift_o_x10, shift_o_y10;

always @(*) begin
    if (o_x10[30:23] <= 8'hA) begin
        shift_o_x10 = 32'b0;
    end else begin
        shift_o_x10 = {o_x10[31], o_x10[30:23] - 8'hA, o_x10[22:0]};
    end
    if (o_y10[30:23] <= 8'hA) begin
        shift_o_y10 = 32'b0;
    end else begin
        shift_o_y10 = {o_y10[31], o_y10[30:23] - 8'hA, o_y10[22:0]};
    end
end

fadder fpu_x10 (
    .i_a(o_x10), 
    .i_b(shift_o_y10), 
    .i_rm(2'b00), 
    .i_sub(sign_x_stage10), 
    
    .o_s(i_x11)
);
 
fadder fpu_y10 (
    .i_a(o_y10), 
    .i_b(shift_o_x10), 
    .i_rm(2'b00), 
    .i_sub(sign_yz_stage10), 
    
    .o_s(i_y11)
);

fadder fpu_z10 (
    .i_a(o_z10), 
    .i_b(arc10), 
    .i_rm(2'b00), 
    .i_sub(~sign_yz_stage10), 
    
    .o_s(i_z11)
);

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        o_x11     <= 32'b0; 
        o_y11     <= 32'b0; 
        o_z11     <= 32'b0; 
        o_check11 <= 6'b0;
    end else begin
        o_x11     <= i_x11;  
        o_y11     <= i_y11;  
        o_z11     <= i_z11;  
        o_check11 <= o_check10; 
    end
end

//      ____  _                     _ _  
//     / ___|| |_ __ _  __ _  ___  / / | 
//     \___ \| __/ _` |/ _` |/ _ \ | | | 
//      ___) | || (_| | (_| |  __/ | | | 
//     |____/ \__\__,_|\__, |\___| |_|_| 
//                     |___/             
sig_gen sig_gen_stage11 (
    .i_sign_y(o_y11[31]),
    .i_sign_z(o_z11[31]),
    .i_mode(i_mode),
    .i_t(i_t),
    
    .o_sel_x(sign_x_stage11),
    .o_sel_y(sign_yz_stage11)
);

always @(*) begin
    if (i_t) arc11 = 32'h39ffffff; // arctan(2^-11)  = 4.882812112e-4
    else     arc11 = 32'h3a000001; // arctanh(2^-11) = 4.882812888e-4
end

logic [31:0] shift_o_x11, shift_o_y11;

always @(*) begin
    if (o_x11[30:23] <= 8'hB) begin
        shift_o_x11 = 32'b0;
    end else begin
        shift_o_x11 = {o_x11[31], o_x11[30:23] - 8'hB, o_x11[22:0]};
    end
    if (o_y11[30:23] <= 8'hB) begin
        shift_o_y11 = 32'b0;
    end else begin
        shift_o_y11 = {o_y11[31], o_y11[30:23] - 8'hB, o_y11[22:0]};
    end
end

fadder fpu_x11 (
    .i_a(o_x11), 
    .i_b(shift_o_y11), 
    .i_rm(2'b00), 
    .i_sub(sign_x_stage11), 
    
    .o_s(i_x12)
);
 
fadder fpu_y11 (
    .i_a(o_y11), 
    .i_b(shift_o_x11), 
    .i_rm(2'b00), 
    .i_sub(sign_yz_stage11), 
    
    .o_s(i_y12)
);

fadder fpu_z11 (
    .i_a(o_z11), 
    .i_b(arc11), 
    .i_rm(2'b00), 
    .i_sub(~sign_yz_stage11), 
    
    .o_s(i_z12)
);

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        o_x12     <= 32'b0; 
        o_y12     <= 32'b0; 
        o_z12     <= 32'b0; 
        o_check12 <= 6'b0;
    end else begin
        o_x12     <= i_x12;  
        o_y12     <= i_y12;  
        o_z12     <= i_z12;  
        o_check12 <= o_check11; 
    end
end

//      ____  _                     _ ____  
//     / ___|| |_ __ _  __ _  ___  / |___ \ 
//     \___ \| __/ _` |/ _` |/ _ \ | | __) |
//      ___) | || (_| | (_| |  __/ | |/ __/ 
//     |____/ \__\__,_|\__, |\___| |_|_____|
//                     |___/                
sig_gen sig_gen_stage12 (
    .i_sign_y(o_y12[31]),
    .i_sign_z(o_z12[31]),
    .i_mode(i_mode),
    .i_t(i_t),
    
    .o_sel_x(sign_x_stage12),
    .o_sel_y(sign_yz_stage12)
);

always @(*) begin
    if (i_t) arc12 = 32'h39800000; // arctan(2^-12)  = 2.441406201e-4
    else     arc12 = 32'h39800000; // arctanh(2^-12) = 2.441406299e-4
end

logic [31:0] shift_o_x12, shift_o_y12;

always @(*) begin
    if (o_x12[30:23] <= 8'hC) begin
        shift_o_x12 = 32'b0;
    end else begin
        shift_o_x12 = {o_x12[31], o_x12[30:23] - 8'hC, o_x12[22:0]};
    end
    if (o_y12[30:23] <= 8'hC) begin
        shift_o_y12 = 32'b0;
    end else begin
        shift_o_y12 = {o_y12[31], o_y12[30:23] - 8'hC, o_y12[22:0]};
    end
end

fadder fpu_x12 (
    .i_a(o_x12), 
    .i_b(shift_o_y12), 
    .i_rm(2'b00), 
    .i_sub(sign_x_stage12), 
    
    .o_s(i_x13)
);
 
fadder fpu_y12 (
    .i_a(o_y12), 
    .i_b(shift_o_x12), 
    .i_rm(2'b00), 
    .i_sub(sign_yz_stage12), 
    
    .o_s(i_y13)
);

fadder fpu_z12 (
    .i_a(o_z12), 
    .i_b(arc12), 
    .i_rm(2'b00), 
    .i_sub(~sign_yz_stage12), 
    
    .o_s(i_z13)
);

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        o_x13     <= 32'b0; 
        o_y13     <= 32'b0; 
        o_z13     <= 32'b0; 
        o_check13 <= 6'b0;
    end else begin
        o_x13     <= i_x13;  
        o_y13     <= i_y13;  
        o_z13     <= i_z13;  
        o_check13 <= o_check12; 
    end
end

//      ____  _                     _ _____ 
//     / ___|| |_ __ _  __ _  ___  / |___ / 
//     \___ \| __/ _` |/ _` |/ _ \ | | |_ \ 
//      ___) | || (_| | (_| |  __/ | |___) |
//     |____/ \__\__,_|\__, |\___| |_|____/ 
//                     |___/                
sig_gen sig_gen_stage13 (
    .i_sign_y(o_y13[31]),
    .i_sign_z(o_z13[31]),
    .i_mode(i_mode),
    .i_t(i_t),
    
    .o_sel_x(sign_x_stage13),
    .o_sel_y(sign_yz_stage13)
);

always @(*) begin
    if (i_t) arc13 = 32'h39000000; // arctan(2^-13)  = 1.220703119e-4
    else     arc13 = 32'h39000000; // arctanh(2^-13) = 1.220703131e-4
end

logic [31:0] shift_o_x13, shift_o_y13;

always @(*) begin
    if (o_x13[30:23] <= 8'hD) begin
        shift_o_x13 = 32'b0;
    end else begin
        shift_o_x13 = {o_x13[31], o_x13[30:23] - 8'hD, o_x13[22:0]};
    end
    if (o_y13[30:23] <= 8'hD) begin
        shift_o_y13 = 32'b0;
    end else begin
        shift_o_y13 = {o_y13[31], o_y13[30:23] - 8'hD, o_y13[22:0]};
    end
end

fadder fpu_x13 (
    .i_a(o_x13), 
    .i_b(shift_o_y13), 
    .i_rm(2'b00), 
    .i_sub(sign_x_stage13), 
    
    .o_s(i_x14)
);
 
fadder fpu_y13 (
    .i_a(o_y13), 
    .i_b(shift_o_x13), 
    .i_rm(2'b00), 
    .i_sub(sign_yz_stage13), 
    
    .o_s(i_y14)
);

fadder fpu_z13 (
    .i_a(o_z13), 
    .i_b(arc13), 
    .i_rm(2'b00), 
    .i_sub(~sign_yz_stage13), 
    
    .o_s(i_z14)
);

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        o_x14     <= 32'b0; 
        o_y14     <= 32'b0; 
        o_z14     <= 32'b0; 
        o_check14 <= 6'b0;
    end else begin
        o_x14     <= i_x14;  
        o_y14     <= i_y14;  
        o_z14     <= i_z14;  
        o_check14 <= o_check13; 
    end
end

//      ____  _                     _ _____   ____                       _   
//     / ___|| |_ __ _  __ _  ___  / |___ /  |  _ \ ___ _ __   ___  __ _| |_ 
//     \___ \| __/ _` |/ _` |/ _ \ | | |_ \  | |_) / _ \ '_ \ / _ \/ _` | __|
//      ___) | || (_| | (_| |  __/ | |___) | |  _ <  __/ |_) |  __/ (_| | |_ 
//     |____/ \__\__,_|\__, |\___| |_|____/  |_| \_\___| .__/ \___|\__,_|\__|
//                     |___/                           |_|                   
logic sign_x_stage13_rep, sign_yz_stage13_rep;
logic [31:0] arc13_rep;

sig_gen sig_gen_stage13_rep (
    .i_sign_y(o_y14[31]),
    .i_sign_z(o_z14[31]),
    .i_mode(i_mode),
    .i_t(i_t),
    
    .o_sel_x(sign_x_stage13_rep),
    .o_sel_y(sign_yz_stage13_rep)
);

assign arc13_rep = 32'h39000000;

logic [31:0] shift_o_x13_rep, shift_o_y13_rep;

always @(*) begin
    if (o_x14[30:23] <= 8'hD) begin
        shift_o_x13_rep = 32'b0;
    end else begin
        shift_o_x13_rep = {o_x14[31], o_x14[30:23] - 8'hD, o_x14[22:0]};
    end
    if (o_y14[30:23] <= 8'hD) begin
        shift_o_y13_rep = 32'b0;
    end else begin
        shift_o_y13_rep = {o_y14[31], o_y14[30:23] - 8'hD, o_y14[22:0]};
    end
end

logic [31:0] i_x14_rep_calc, i_y14_rep_calc, i_z14_rep_calc;

fadder fpu_x13_rep (
    .i_a(o_x14), 
    .i_b(shift_o_y13_rep), 
    .i_rm(2'b00), 
    .i_sub(sign_x_stage13_rep), 
    
    .o_s(i_x14_rep_calc)
);
 
fadder fpu_y13_rep (
    .i_a(o_y14), 
    .i_b(shift_o_x13_rep), 
    .i_rm(2'b00), 
    .i_sub(sign_yz_stage13_rep), 
    
    .o_s(i_y14_rep_calc)
);

fadder fpu_z13_rep (
    .i_a(o_z14), 
    .i_b(arc13_rep), 
    .i_rm(2'b00), 
    .i_sub(~sign_yz_stage13_rep), 
    
    .o_s(i_z14_rep_calc)
);

logic [31:0] i_x14_rep, i_y14_rep, i_z14_rep;

always @(*) begin
    if (i_t) begin
        i_x14_rep = o_x14;
        i_y14_rep = o_y14;
        i_z14_rep = o_z14;
    end else begin
        i_x14_rep = i_x14_rep_calc;
        i_y14_rep = i_y14_rep_calc;
        i_z14_rep = i_z14_rep_calc;
    end
end

logic [31:0] o_x14_rep, o_y14_rep, o_z14_rep;
logic [ 5:0] o_check14_rep;

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        o_x14_rep     <= 32'b0; 
        o_y14_rep     <= 32'b0; 
        o_z14_rep     <= 32'b0; 
        o_check14_rep <= 6'b0;
    end else begin
        o_x14_rep     <= i_x14_rep;  
        o_y14_rep     <= i_y14_rep;  
        o_z14_rep     <= i_z14_rep;  
        o_check14_rep <= o_check14; 
    end
end

//      ____  _                     _ _  _   
//     / ___|| |_ __ _  __ _  ___  / | || |  
//     \___ \| __/ _` |/ _` |/ _ \ | | || |_ 
//      ___) | || (_| | (_| |  __/ | |__   _|
//     |____/ \__\__,_|\__, |\___| |_|  |_|  
//                     |___/                 
sig_gen sig_gen_stage14 (
    .i_sign_y(o_y14_rep[31]),
    .i_sign_z(o_z14_rep[31]),
    .i_mode(i_mode),
    .i_t(i_t),
    
    .o_sel_x(sign_x_stage14),
    .o_sel_y(sign_yz_stage14)
);

always @(*) begin
    if (i_t) arc14 = 32'h38800000; // arctan(2^-14)  = 6.103515617e-5
    else     arc14 = 32'h38800000; // arctanh(2^-14) = 6.103515633e-5
end

logic [31:0] shift_o_x14, shift_o_y14;

always @(*) begin
    if (o_x14_rep[30:23] <= 8'hE) begin
        shift_o_x14 = 32'b0;
    end else begin
        shift_o_x14 = {o_x14_rep[31], o_x14_rep[30:23] - 8'hE, o_x14_rep[22:0]};
    end
    if (o_y14_rep[30:23] <= 8'hE) begin
        shift_o_y14 = 32'b0;
    end else begin
        shift_o_y14 = {o_y14_rep[31], o_y14_rep[30:23] - 8'hE, o_y14_rep[22:0]};
    end
end

fadder fpu_x14 (
    .i_a(o_x14_rep), 
    .i_b(shift_o_y14), 
    .i_rm(2'b00), 
    .i_sub(sign_x_stage14), 
    
    .o_s(i_x15)
);
 
fadder fpu_y14 (
    .i_a(o_y14_rep), 
    .i_b(shift_o_x14), 
    .i_rm(2'b00), 
    .i_sub(sign_yz_stage14), 
    
    .o_s(i_y15)
);

fadder fpu_z14 (
    .i_a(o_z14_rep), 
    .i_b(arc14), 
    .i_rm(2'b00), 
    .i_sub(~sign_yz_stage14),
    
    .o_s(i_z15)
);

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        o_x15     <= 32'b0; 
        o_y15     <= 32'b0; 
        o_z15     <= 32'b0; 
        o_check15 <= 6'b0;
    end else begin
        o_x15     <= i_x15;  
        o_y15     <= i_y15;  
        o_z15     <= i_z15;  
        o_check15 <= o_check14_rep;
    end
end

//      ____  _                     _ ____  
//     / ___|| |_ __ _  __ _  ___  / | ___| 
//     \___ \| __/ _` |/ _` |/ _ \ | |___ \ 
//      ___) | || (_| | (_| |  __/ | |___) |
//     |____/ \__\__,_|\__, |\___| |_|____/ 
//                     |___/                      
sig_gen sig_gen_stage15 (
    .i_sign_y(o_y15[31]),
    .i_sign_z(o_z15[31]),
    .i_mode(i_mode),
    .i_t(i_t),
    
    .o_sel_x(sign_x_stage15),
    .o_sel_y(sign_yz_stage15)
);

always @(*) begin
    if (i_t) arc15 = 32'h38000000; // arctan(2^-15)  = 3.051757812e-5
    else     arc15 = 32'h38000000; // arctanh(2^-15) = 3.051757813e-5
end

logic [31:0] shift_o_x15, shift_o_y15;

always @(*) begin
    if (o_x15[30:23] <= 8'hF) begin
        shift_o_x15 = 32'b0;
    end else begin
        shift_o_x15 = {o_x15[31], o_x15[30:23] - 8'hF, o_x15[22:0]};
    end
    if (o_y15[30:23] <= 8'hF) begin
        shift_o_y15 = 32'b0;
    end else begin
        shift_o_y15 = {o_y15[31], o_y15[30:23] - 8'hF, o_y15[22:0]};
    end
end

fadder fpu_x15 (
    .i_a(o_x15), 
    .i_b(shift_o_y15), 
    .i_rm(2'b00), 
    .i_sub(sign_x_stage15), 
    
    .o_s(i_x16)
);
 
fadder fpu_y15 (
    .i_a(o_y15), 
    .i_b(shift_o_x15), 
    .i_rm(2'b00), 
    .i_sub(sign_yz_stage15), 
    
    .o_s(i_y16)
);

fadder fpu_z15 (
    .i_a(o_z15), 
    .i_b(arc15), 
    .i_rm(2'b00), 
    .i_sub(~sign_yz_stage15), 
    
    .o_s(i_z16)
);

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        o_x16     <= 32'b0; 
        o_y16     <= 32'b0; 
        o_z16     <= 32'b0; 
        o_check16 <= 6'b0;
    end else begin
        o_x16     <= i_x16;  
        o_y16     <= i_y16;  
        o_z16     <= i_z16;  
        o_check16 <= o_check15; 
    end
end

//      __  __       _    ____  _                    ____  _             _                        _        
//     |  \/  |_   _| | / ___|| |_ __ _  __ _  ___  / ___|(_)_ __   __ _| | ___         ___ _  _  ___| | ___  
//     | |\/| | | | | | \___ \| __/ _` |/ _` |/ _ \ \___ \| | '_ \ / _` | |/ _ \_____ / __| | | |/ __| |/ _ \ 
//     | |  | | |_| | |  ___) | || (_| | (_| |  __/  ___) | | | | | (_| | |  __/_____| (__| |_| | (__| |  __/ 
//     |_|  |_|\__,_|_| |____/ \__\__,_|\__, |\___| |____/|_|_| |_|\__, |_|\___|      \___|\__, |\___|_|\___| 
//                                      |___/                      |___/                   |___/             

logic [31:0] k_factor;
always @(*) begin //K_c = 0.60725296 (3f1b74ee), K_h = 1.20735 (3f9a8a72)
   if (i_t) k_factor = 32'h3f1b74ee;
   else     k_factor = 32'h3f9a8a72;
end

logic [31:0] x_mul, y_mul;

fmul fmul_k_x (.i_a(o_x16), .i_b(k_factor), .i_rm(2'b00), .o_s(x_mul));
fmul fmul_k_y (.i_a(o_y16), .i_b(k_factor), .i_rm(2'b00), .o_s(y_mul));

//      ____                 _ _        _       _  _                               _ 
//     |  _ \ ___  ___ _   _| | |_     / \   __| |(_)_  _ ___ _ __ ___   ___ _ __ | |_
//     | |_) / _ \/ __| | | | | __|   / _ \ / _` || | | | / __| '_ ` _ \ / _ \ '_ \| __|
//     |  _ <  __/\__ \ |_| | | |_   / ___ \ (_| || | |_| \__ \ | | | | |  __/ | | | |_
//     |_| \_\___||___/\__,_|_|\__| /_/   \_\__,_|/ |\__,_|___/_| |_| |_|\___|_| |_|\__|
//                                              |__/                                  

always @(*) begin
    if (o_check16[1:0] == 2'b01 && i_t) begin
        x1 = {~x_mul[31], x_mul[30:0]}; 
        y1 = {~y_mul[31], y_mul[30:0]}; 
    end else begin
        x1 = x_mul;
        y1 = y_mul;
    end
end

logic bypass_enable;
assign bypass_enable = i_t & (~i_mode); 

logic [31:0] next_o_x, next_o_y; 

always @(*) begin
    if (bypass_enable) begin
        case (o_check16[5:2])
            4'b0001: begin 
                        next_o_x = delay19_x; 
                        next_o_y = delay19_y; 
                     end
            4'b0010: begin 
                        next_o_x = {~delay19_y[31], delay19_y[30:0]}; 
                        next_o_y = delay19_x; 
                     end
            4'b0100: begin 
                        next_o_x = {~delay19_x[31], delay19_x[30:0]}; 
                        next_o_y = {~delay19_y[31], delay19_y[30:0]}; 
                     end
            4'b1000: begin 
                        next_o_x = delay19_y; 
                        next_o_y = {~delay19_x[31], delay19_x[30:0]}; 
                     end
            default: begin 
                        next_o_x = x1; 
                        next_o_y = y1; 
                     end
        endcase
    end else begin
        next_o_x = x1;
        next_o_y = y1;
    end
end

always_ff @(posedge i_clk or negedge i_reset) begin
    if (~i_reset) begin
        o_x <= 32'b0;
        o_y <= 32'b0;
        o_z <= 32'b0;
    end else begin
        o_x <= next_o_x;
        o_y <= next_o_y;
        o_z <= o_z16;
    end
end

endmodule
