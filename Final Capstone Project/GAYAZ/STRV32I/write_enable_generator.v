module write_enable_generator(
                        input wr_en_g_in,
                        input flush_in,
                        output wr_en_g_file_out
    );
    assign wr_en_g_file_out = flush_in ? wr_en_g_in : 1'b0;
endmodule
