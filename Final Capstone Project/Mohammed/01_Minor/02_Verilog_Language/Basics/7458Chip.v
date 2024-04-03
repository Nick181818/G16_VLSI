module top_module ( 
	    input p1a, p1b, p1c, p1d, p1e, p1f,
	        output p1y,
		    input p2a, p2b, p2c, p2d,
		        output p2y );
		    wire p,q,r,s;
		        assign p = p2a & p2b;
			    assign r = p2c & p2d;
			        assign p2y = p|r;
				    assign q = p1a & p1b & p1c;
				        assign s = p1f & p1e & p1d;
					    assign p1y = q|s;


					    endmodule
