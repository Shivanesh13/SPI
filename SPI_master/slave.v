// Implementation of SPI protocol
// Slave 
// Name: G.Shivanesh
// Date: 28-02-2022

module slave (
    input rst,sclk,read_en,write_en,select,MOSI,input [7:0]data_in,output reg MISO,output reg [7:0]data_out
);
    reg [2:0]w_counter,r_counter;   // points to the next location where it has to read or written
    always @(posedge sclk, posedge rst) begin
        if(select || rst) begin
            if(rst) begin
                MISO <= 1'b0;
                data_out <= 8'b0;
                r_counter <= 3'b0;
                w_counter <= 3'b0;
            end    
            else begin
            if (write_en) begin
                data_out[7 - w_counter] <= MOSI;
                w_counter <= w_counter + 1;
            end    
            if (read_en) begin
                MISO <= data_in[r_counter];
                r_counter <= r_counter + 1;
            end
            if(~write_en) begin
                w_counter <= 0;
            end
            if(~read_en) begin
                r_counter <= 0;
            end
            end
        end 
    end
endmodule