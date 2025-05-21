// Filename: binary_to_7seg_decoder.v
// Description: This module implements a 4-bit Binary to 7-Segment Display Decoder
//              based on the provided truth table (common cathode).
//              It also includes an 'H' output (segment_out[0]) which acts as an
//              LED indicator, active for binary inputs 8 through 15.

module binary_to_7seg_decoder ( // Start of the module definition for the 7-segment decoder
    input [3:0] binary_in,       // Declare a 4-bit input 'binary_in' for the binary number
                                 // binary_in[3] corresponds to 'A' (Most Significant Bit) from the truth table
                                 // binary_in[2] corresponds to 'B'
                                 // binary_in[1] corresponds to 'C'
                                 // binary_in[0] corresponds to 'D' (Least Significant Bit)
                                 // The order is important to match your truth table's A, B, C, D columns.

    output reg [7:0] segment_out // Declare an 8-bit output 'segment_out' as a 'reg' type (for use in always block)
                                 // This output controls the segments of the 7-segment display and the H_LED.
                                 // The bit assignments are:
                                 // segment_out[7] = A_segment (controls segment 'a' of the display)
                                 // segment_out[6] = B_segment (controls segment 'b')
                                 // segment_out[5] = C_segment (controls segment 'c')
                                 // segment_out[4] = D_segment (controls segment 'd')
                                 // segment_out[3] = E_segment (controls segment 'e')
                                 // segment_out[2] = F_segment (controls segment 'f')
                                 // segment_out[1] = G_segment (controls segment 'g')
                                 // segment_out[0] = H_LED (controls the decimal point or an extra LED, as requested)
);

    // Explicit wire declarations for individual input bits for better GTKWave visibility
    wire A_in = binary_in[3]; // Create a named wire 'A_in' for the MSB of binary_in
    wire B_in = binary_in[2]; // Create a named wire 'B_in' for the next bit
    wire C_in = binary_in[1]; // Create a named wire 'C_in'
    wire D_in = binary_in[0]; // Create a named wire 'D_in' for the LSB of binary_in

    // Explicit wire declarations for individual output segments for better GTKWave visibility
    wire SegA = segment_out[7]; // Create a named wire 'SegA' for segment 'a'
    wire SegB = segment_out[6]; // Create a named wire 'SegB' for segment 'b'
    wire SegC = segment_out[5]; // Create a named wire 'SegC' for segment 'c'
    wire SegD = segment_out[4]; // Create a named wire 'SegD' for segment 'd'
    wire SegE = segment_out[3]; // Create a named wire 'SegE' for segment 'e'
    wire SegF = segment_out[2]; // Create a named wire 'SegF' for segment 'f'
    wire SegG = segment_out[1]; // Create a named wire 'SegG' for segment 'g'
    wire H_out = segment_out[0]; // Create a named wire 'H_out' for the H_LED (decimal point)

    // Always block to define combinational logic for segment_out
    // This block describes how the output 'segment_out' behaves based on inputs.
    // The sensitivity list @(*) ensures that the block re-evaluates
    // whenever any input to the block (binary_in in this case) changes.
    always @(*) begin
        // Use a case statement to map each 4-bit binary input to its
        // corresponding 8-bit 7-segment output pattern.
        // This is a direct implementation of your provided truth table.
        case (binary_in) // The expression being evaluated by the case statement
            // Binary Input (ABCD, where binary_in[3]=A, binary_in[2]=B, etc.) -> 7-Segment Output (ABCDEFGH)
            // The 8-bit binary literal '8'b' corresponds to segment_out[7] down to segment_out[0].

            // Iteration 0: Binary 0000 -> Display '0' on 7-segment display
            // Truth table: A=1, B=1, C=1, D=1, E=1, F=1, G=0, H=0
            4'b0000: segment_out = 8'b11111100; // Output pattern for binary 0000

            // Iteration 1: Binary 0001 -> Display '1'
            // Truth table: A=0, B=1, C=1, D=0, E=0, F=0, G=0, H=0
            4'b0001: segment_out = 8'b01100000; // Output pattern for binary 0001

            // Iteration 2: Binary 0010 -> Display '2'
            // Truth table: A=1, B=1, C=0, D=1, E=1, F=0, G=1, H=0
            4'b0010: segment_out = 8'b11011010; // Output pattern for binary 0010

            // Iteration 3: Binary 0011 -> Display '3'
            // Truth table: A=1, B=1, C=1, D=1, E=0, F=0, G=1, H=0
            4'b0011: segment_out = 8'b11110010; // Output pattern for binary 0011

            // Iteration 4: Binary 0100 -> Display '4'
            // Truth table: A=0, B=1, C=1, D=0, E=0, F=1, G=1, H=0
            4'b0100: segment_out = 8'b01100110; // Output pattern for binary 0100

            // Iteration 5: Binary 0101 -> Display '5'
            // Truth table: A=1, B=0, C=1, D=1, E=0, F=1, G=1, H=0
            4'b0101: segment_out = 8'b10110110; // Output pattern for binary 0101

            // Iteration 6: Binary 0110 -> Display '6'
            // Truth table: A=1, B=0, C=1, D=1, E=1, F=1, G=1, H=0
            4'b0110: segment_out = 8'b10111110; // Output pattern for binary 0110

            // Iteration 7: Binary 0111 -> Display '7'
            // Truth table: A=1, B=1, C=1, D=0, E=0, F=0, G=0, H=0
            4'b0111: segment_out = 8'b11100000; // Output pattern for binary 0111

            // Iteration 8: Binary 1000 -> Display '8'
            // Truth table: A=1, B=1, C=1, D=1, E=1, F=1, G=0, H=1
            // CORRECTED: G segment is now '0' as per image_6b6ede.png
            // H_LED (segment_out[0]) is ON (1) as requested for iterations >= 8
            4'b1000: segment_out = 8'b11111101; // Output pattern for binary 1000

            // Iteration 9: Binary 1001 -> Display '9'
            // Truth table: A=0, B=1, C=1, D=0, E=0, F=0, G=0, H=1
            // H_LED (segment_out[0]) is ON (1)
            4'b1001: segment_out = 8'b01100001; // Output pattern for binary 1001

            // Iteration 10: Binary 1010 -> Display 'A' (Hex)
            // Truth table: A=1, B=1, C=0, D=1, E=1, F=0, G=1, H=1
            // H_LED (segment_out[0]) is ON (1)
            4'b1010: segment_out = 8'b11011011; // Output pattern for binary 1010

            // Iteration 11: Binary 1011 -> Display 'B' (Hex)
            // Truth table: A=1, B=1, C=1, D=1, E=0, F=0, G=1, H=1
            // H_LED (segment_out[0]) is ON (1)
            4'b1011: segment_out = 8'b11110011; // Output pattern for binary 1011

            // Iteration 12: Binary 1100 -> Display 'C' (Hex)
            // Truth table: A=0, B=1, C=1, D=0, E=0, F=1, G=1, H=1
            // H_LED (segment_out[0]) is ON (1)
            4'b1100: segment_out = 8'b01100111; // Output pattern for binary 1100

            // Iteration 13: Binary 1101 -> Display 'D' (Hex)
            // Truth table: A=1, B=0, C=1, D=1, E=0, F=1, G=1, H=1
            // H_LED (segment_out[0]) is ON (1)
            4'b1101: segment_out = 8'b10110111; // Output pattern for binary 1101

            // Iteration 14: Binary 1110 -> Display 'E' (Hex)
            // Truth table: A=1, B=0, C=1, D=1, E=1, F=1, G=1, H=1
            // H_LED (segment_out[0]) is ON (1)
            4'b1110: segment_out = 8'b10111111; // Output pattern for binary 1110

            // Iteration 15: Binary 1111 -> Display 'F' (Hex)
            // Truth table: A=1, B=1, C=1, D=0, E=0, F=0, G=0, H=1
            // H_LED (segment_out[0]) is ON (1)
            4'b1111: segment_out = 8'b11100001; // Output pattern for binary 1111

            // Default case: For any undefined inputs (e.g., X or Z states), turn all segments off.
            default: segment_out = 8'b00000000; // All segments off by default
        endcase // End of the case statement
    end // End of the always block

endmodule // End of the binary_to_7seg_decoder module

// Filename: tb_binary_to_7seg_decoder.v
// Description: Testbench for the binary_to_7seg_decoder module.
//              It applies all possible 4-bit binary inputs (0-15)
//              and monitors the 7-segment output, including the H_LED.

`timescale 1ns / 1ps // Define the timescale for simulation (1ns for time, 1ps for precision)

module tb_binary_to_7seg_decoder; // Start of the testbench module definition

    // Declare signals for inputs and outputs of the UUT (Unit Under Test)
    reg [3:0] binary_in;         // Declare 'binary_in' as a 4-bit register to drive the UUT's input
    wire [7:0] segment_out;      // Declare 'segment_out' as an 8-bit wire to receive the UUT's output

    // Instantiate the binary_to_7seg_decoder module
    // 'uut' (Unit Under Test) is a common naming convention for the instance
    binary_to_7seg_decoder uut ( // Instantiate the module named 'binary_to_7seg_decoder'
        .binary_in(binary_in),   // Connect the testbench's 'binary_in' to the UUT's 'binary_in' port
        .segment_out(segment_out)// Connect the testbench's 'segment_out' to the UUT's 'segment_out' port
    );

    // Initial block for stimulus generation
    // This block executes once at the beginning of the simulation.
    initial begin
        // Specify the VCD (Value Change Dump) file for waveform dumping
        $dumpfile("binary_to_7seg.vcd"); // Creates a file named 'binary_to_7seg.vcd'

        // Dump all signals in the current scope (tb_binary_to_7seg_decoder)
        // and all scopes below it (i.e., signals within the 'uut' instance).
        // The '0' indicates the depth of dumping (0 means all levels).
        $dumpvars(0, tb_binary_to_7seg_decoder); // Dumps all variables in the testbench and the UUT

        // $monitor displays values whenever any of its arguments change.
        // This is useful for observing the simulation flow in the console.
        // %0t: current simulation time
        // %b: binary format
        $monitor("Time=%0t | Input: A=%b B=%b C=%b D=%b | Output: SegA=%b SegB=%b SegC=%b SegD=%b SegE=%b SegF=%b SegG=%b H=%b",
                 $time, // Current simulation time
                 uut.A_in, uut.B_in, uut.C_in, uut.D_in, // Individual input bits using their explicit names (from uut instance)
                 uut.SegA, uut.SegB, uut.SegC, uut.SegD, // Individual segment bits using their explicit names (from uut instance)
                 uut.SegE, uut.SegF, uut.SegG, uut.H_out); // H_out is the H_LED segment

        // Apply test vectors with delays
        // Each #10 introduces a 10ns delay, allowing the combinational logic to settle
        // and for the $monitor to capture the stable output.

        // Test cases for inputs 0-7 (H_LED should be OFF for these)
        binary_in = 4'b0000; #10; // Set binary_in to 0 (0000), wait 10ns
        binary_in = 4'b0001; #10; // Set binary_in to 1 (0001), wait 10ns
        binary_in = 4'b0010; #10; // Set binary_in to 2 (0010), wait 10ns
        binary_in = 4'b0011; #10; // Set binary_in to 3 (0011), wait 10ns
        binary_in = 4'b0100; #10; // Set binary_in to 4 (0100), wait 10ns
        binary_in = 4'b0101; #10; // Set binary_in to 5 (0101), wait 10ns
        binary_in = 4'b0110; #10; // Set binary_in to 6 (0110), wait 10ns
        binary_in = 4'b0111; #10; // Set binary_in to 7 (0111), wait 10ns

        // Test cases for inputs 8-15 (H_LED should be ON for these, as per your requirement)
        binary_in = 4'b1000; #10; // Set binary_in to 8 (1000), wait 10ns (G segment corrected)
        binary_in = 4'b1001; #10; // Set binary_in to 9 (1001), wait 10ns
        binary_in = 4'b1010; #10; // Set binary_in to 10 (1010), wait 10ns (Hex 'A')
        binary_in = 4'b1011; #10; // Set binary_in to 11 (1011), wait 10ns (Hex 'B')
        binary_in = 4'b1100; #10; // Set binary_in to 12 (1100), wait 10ns (Hex 'C')
        binary_in = 4'b1101; #10; // Set binary_in to 13 (1101), wait 10ns (Hex 'D')
        binary_in = 4'b1110; #10; // Set binary_in to 14 (1110), wait 10ns (Hex 'E')
        binary_in = 4'b1111; #10; // Set binary_in to 15 (1111), wait 10ns (Hex 'F')

        $finish; // Terminates the simulation, closing the VCD file and ending execution.
    end // End of the initial block

endmodule // End of the testbench module
