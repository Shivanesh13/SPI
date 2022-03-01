module system_tb (
);
    reg clk,s_rst,m_rst,m_read,s_read,m_write,s_write;
    reg [1:0]slave_sel;
    reg [7:0]m_data_in,s_data_in;
    wire [7:0]m_data_out,s_data_out_1;
    parameter T = 5;
    integer i;

    system DUT(clk,s_rst,m_rst,m_read,s_read,m_write,s_write,slave_sel,m_data_in,s_data_in,m_data_out,s_data_out_1);

    initial begin
        clk = 0;
        forever begin
            #(T) clk = ~clk;
        end
    end

    initial begin
        initialize;
        delay;
        RESET;
        delay;
        // Op_1;
        // $display("Data_out from Slave = %b",s_data_out_1);
        // delay;
        Op_2;
        $display("Data_out from Master = %b",m_data_out);
        delay;
        $finish;
    end

    task Op_1;
    begin
        @(negedge clk) m_write = 1'b1;
        s_write = 1'b1;
        m_data_in = ({$random}%256);
        for (i=0;i<10;i=i+1) begin
            delay;
        end
        @(negedge clk) m_write = 1'b0;
        s_write = 1'b0;
    end
    endtask

    task Op_2;
    begin
        @(negedge clk) m_read = 1'b1;
        s_read = 1'b1;
        s_data_in = 8'b01010111;   
        for (i=0;i<10;i=i+1) begin
            delay;
        end
        @(negedge clk) m_read = 1'b0;
        s_read = 1'b0;
    end
    endtask

    task RESET;
    begin
        @(negedge clk) s_rst = 1'b1;
        m_rst = 1'b1;
        @(negedge clk) s_rst = 1'b0;
        m_rst = 1'b0;
    end
    endtask


    task delay;
    begin
       #(2*T); 
    end
    endtask

    task initialize;
    begin
        slave_sel = 2'b00;
        s_rst = 0;
        m_rst = 0;
        m_read = 0;
        s_read = 0;
        m_write = 0;
        s_write = 0;
        m_data_in = 8'b0;
        s_data_in = 8'b0;
    end
    endtask


endmodule