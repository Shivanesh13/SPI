module master (
    input rst,clk,read_en,write_en,MISO,input [1:0]slave_sel, input [7:0]data_in,output MOSI,output reg SS_1,SS_2,SS_3,SS_4, output sclk,output reg [7:0]data_out
);
    parameter S1 =2'b00,S2 =2'b01,S3 =2'b10,S4 =2'b11 ;
    reg [2:0]counter;
    assign sclk <= clk;
    always @(clk) begin
        if(rst) begin
            MOSI <= 1'b0;
            SS_1 <= 1'b0;
            SS_2 <= 1'b0;
            SS_3 <= 1'b0;
            SS_4 <= 1'b0;
            counter <= 3'b0;
            data_out <= 8'b0;
        end
        else begin
        if (write_en) begin
            case (slave_sel)
                S1: begin
                    SS_1 <= 1'b1;
                    MOSI <= data_in[3'b111 - counter];
                    counter <= counter + 1;
                end 
                S2: begin
                    SS_2 <= 1'b1;
                    MOSI <= data_in[3'b111 - counter];
                    counter <= counter + 1;
                end
                S3: begin
                    SS_3 <= 1'b1;
                    MOSI <= data_in[3'b111 - counter];
                    counter <= counter + 1;
                end
                S4: begin
                    SS_4 <= 1'b1;
                    MOSI <= data_in[3'b111 - counter];
                    counter <= counter + 1;
                end
                default: begin
                    SS_1 <= 1'b0;
                    SS_2 <= 1'b0;
                    SS_3 <= 1'b0;
                    SS_4 <= 1'b0;
                end
            endcase
        end
        if(read_en) begin
            case (slave_sel)
                S1: begin
                    SS_1 <= 1'b1;
                    data_out[counter] <= MISO;
                    counter <= counter + 1;
                end 
                S2: begin
                    SS_2 <= 1'b1;
                    data_out[counter] <= MISO;
                    counter <= counter + 1;
                end
                S3: begin
                    SS_3 <= 1'b1;
                    data_out[counter] <= MISO;
                    counter <= counter + 1;
                end
                S4: begin
                    SS_4 <= 1'b1;
                    data_out[counter] <= MISO;
                    counter <= counter + 1;
                end
                default: begin
                    SS_1 <= 1'b0;
                    SS_2 <= 1'b0;
                    SS_3 <= 1'b0;
                    SS_4 <= 1'b0;
                end
            endcase
        end
        end
    end
endmodule