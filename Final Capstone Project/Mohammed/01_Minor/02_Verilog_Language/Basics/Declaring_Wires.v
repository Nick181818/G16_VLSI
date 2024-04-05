module top_module(
	    input a,
	        input b,
		    input c,
		        input d,
			    output out,
			        output out_n   ); 
			    wire p,q,r;
			        assign out = r;
				    assign out_n = ~r;
				        assign r = p|q;
					    assign p = a & b;
					        assign q = c & d;

						endmodule
