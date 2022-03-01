module system (
    input clk,s_rst,m_rst,m_read,s_read,m_write,s_write,input [1:0]slave_sel,input [7:0]m_data_in,s_data_in,output [7:0]m_data_out,s_data_out_1
);
    
    wire sclk,MISO,MOSI,SS_1,SS_2,SS_3,SS_4;
    master Master(m_rst,clk,m_read,m_write,MISO,slave_sel,m_data_in,MOSI,SS_1,SS_2,SS_3,SS_4,sclk,m_data_out);
    slave Slave_1(s_rst,sclk,s_read,s_write,SS_1,MOSI,s_data_in,MISO,s_data_out_1);
    // slave Slave_2(s_rst,sclk,s_read,s_write,SS_2,MOSI,s_data_in,MISO,s_data_out_2);
    // slave Slave_3(s_rst,sclk,s_read,s_write,SS_3,MOSI,s_data_in,MISO,s_data_out_3);
    // slave Slave_4(s_rst,sclk,s_read,s_write,SS_4,MOSI,s_data_in,MISO,s_data_out_4);
endmodule