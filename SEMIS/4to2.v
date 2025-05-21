module priority_encoder_4to2(
    input D0, D1, D2, D3,  // Separate inputs instead of a 4-bit vector
    output reg A, B, v     // Encoded output and valid signal
);

always @(*) begin
    casez ({D3, D2, D1, D0})  // Check inputs in priority order
        4'b0000: {A, B, v} = 3'b000; // No valid input
        4'b0001: {A, B, v} = 3'b001; // D0 active
        4'b001?: {A, B, v} = 3'b011; // D1 active (overrides D0)
        4'b01??: {A, B, v} = 3'b101; // D2 active (overrides D1:0)
        4'b1???: {A, B, v} = 3'b111; // D3 active (highest priority)
        default: {A, B, v} = 3'b000;
    endcase
end

endmodule