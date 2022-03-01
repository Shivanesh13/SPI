module slave_tb (
);
    reg rst,sclk,read_en,write_en,select,MOSI;
    reg [7:0]data_in;
    wire MISO;
    wire [7:0]data_out;
    parameter T = 5;

    slave DUT(rst,sclk,read_en,write_en,select,MOSI,data_in,MISO,data_out);

    initial begin
        sclk = 0;
        forever begin
            #(T) sclk = ~sclk;
        end
    end

    initial begin
        initialize;
        delay;
        reset;
        delay;
        read;
        delay;
        write;
        delay;
        $finish;
    end

    task reset;
    begin
        @(negedge sclk) rst = 1;
        @(negedge sclk) rst = 0;
    end
    endtask

    task delay;
    begin
        #(2*T);
    end
    endtask

    task initialize;
    begin
        rst = 0;
        read_en = 0;
        write_en = 0;
        select = 1;
        MOSI = 0;
        data_in = 0;
    end
    endtask

    task read;
    integer i;
    begin
        @(negedge sclk);
        select = 1;
        read_en = 1;
        data_in = {$random}%256;
        for(i=0;i<8;i=i+1)begin
            delay;
        end
        @(negedge sclk) read_en = 0;
    end
    endtask

    task write;
    reg [7:0]write_val;
    integer i;
    begin
        @(negedge sclk) select = 1;
        write_en = 1;
        write_val = 8'b11000100;
        for (i=0;i<8;i=i+1 ) begin
            MOSI = write_val[7-i];
            
            delay;
        end
        @(negedge sclk) write_en = 0;
     end
    endtask

endmodule