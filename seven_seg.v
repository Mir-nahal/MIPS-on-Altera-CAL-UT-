module seven_seg(input[3:0] number, output[6:0] seven_seg_in);
 assign seven_seg_in = ~((number == 4'd0) ? 7'h3F:
     (number == 4'd1) ? 7'h06 :
     (number == 4'd2) ? 7'h5B :
     (number == 4'd3) ? 7'h4F :
     (number == 4'd4) ? 7'h66 :
     (number == 4'd5) ? 7'h6D :
     (number == 4'd6) ? 7'h7D :
     (number == 4'd7) ? 7'h07 :
     (number == 4'd8) ? 7'h7F :
     (number == 4'd9) ? 7'h6F :
     (number == 4'd10) ? 7'h5F:
     (number == 4'd11) ? 7'h7C:
     (number == 4'd12) ? 7'h58:
     (number == 4'd13) ? 7'h5E:
     (number == 4'd14) ? 7'h79:
     7'h71);
endmodule