module master_tb (
);
    reg clk,rst,read_en,write_en,MISO;
    reg [1:0]slave_sel;
    reg [7:0]data_in;
    wire MOSI,SS_1,SS_2,SS_3,SS_4,sclk;
    wire [7:0]data_out;
    parameter T = 5;

    master DUT(rst,clk,read_en,write_en,MISO,slave_sel,data_in,MOSI,SS_1,SS_2,SS_3,SS_4,sclk,data_out);

    initial begin
        clk = 0;
        forever begin
            #(T) clk = ~clk;
        end
    end

    initial begin
        initialize;
        delay;
        reset;
        delay;
        write;
        repeat(9) begin
            delay;
        end
        @(negedge clk) write_en = 0;
        delay;
        read;
        delay;
        $finish;
    end

    task write;
    integer i;
    begin
        @(negedge clk) write_en = 1;
        slave_sel = {$random}%4;
        //data_in = {$random}%256;
        data_in = 8'b00001101;
        $display("Data in: %b",data_in);
    end
    endtask


    task read;
    integer i;
    begin
        @(negedge clk) read_en = 1;
        slave_sel = {$random}%4;
        for (i = 0;i<8;i=i+1 ) begin
            MISO = {$random}%2;
            $display("MISO : %b",MISO);
            delay;
        end
    end
    endtask

    task reset;
    begin
        @(negedge clk) rst = 1;
        @(negedge clk) rst = 0;
    end
    endtask


    task delay;
    begin
        #(2*T);
    end
    endtask


    task initialize;
    begin
        rst = 1'b0;
        read_en = 1'b0;
        write_en = 1'b0;
        MISO = 1'b0;
        slave_sel = 2'b0;
        data_in = 8'b0;
    end
    endtask
endmodule