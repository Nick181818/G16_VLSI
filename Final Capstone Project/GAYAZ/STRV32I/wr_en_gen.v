module wr_en_gen (
    input wr_en_reg_in,
    input flush_in,
    output wr_en_reg_out
);

assign wr_en_reg_out = flush_in ? wr_en_reg_in : 1'b0;

endmodule