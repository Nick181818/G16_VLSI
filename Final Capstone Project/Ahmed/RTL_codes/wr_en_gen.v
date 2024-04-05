module wr_en_gen (
    input wr_en_reg_in,         // Input Write Request for Register Memory
    input flush_in,             // Flush Signal
    output wr_en_reg_file_out   // Output Write Request for Register Memory
);      
    assign wr_en_reg_file_out = flush_in ? 1'b0 : wr_en_reg_in;
endmodule