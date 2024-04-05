module top_module (
    input ring,
    input vibrate_mode,
    output ringer,       // Make sound
    output motor         // Vibrate
);
    always @ (ring) begin
        if(ring == 1'b1)begin
            {ringer, motor} = vibrate_mode? 2'b01 : 2'b10;
        end
        else {ringer, motor} = 2'b00;
            
    end

endmodule