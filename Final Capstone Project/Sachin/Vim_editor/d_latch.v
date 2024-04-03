
module d_latch_multibit(idata, i_en, odata);
        input [15:0] idata;
        input i_en;
        output reg [15:0] odata;

        always @(idata, i_en)
             begin
                  if(!i_en)

                        odata = idata;
                  else
                        odata = odata;

             end
endmodule


