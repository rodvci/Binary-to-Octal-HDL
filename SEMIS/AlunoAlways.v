// 1-bit ALU using assign statements only
// Supported operations:
// S1 S0 | Operation
//  0  0  | Addition (X XOR Y, simplified for 1-bit)
//  0  1  | Subtraction (X XOR Y, simplified for 1-bit)
//  1  0  | AND
//  1  1  | OR

module ALU_1bit (
    input wire X, Y,        // 1-bit input operands
    input wire S0, S1,      // 2-bit select inputs to choose the operation
    output wire R           // 1-bit result output
);

    // Internal wires for each operation
    wire add_op;  // Result of addition
    wire sub_op;  // Result of subtraction
    wire and_op;  // Result of AND operation
    wire or_op;   // Result of OR operation

    // 1-bit operations:
    // Addition and subtraction simplified to XOR (no carry/borrow)
    assign add_op = X ^ Y;      // XOR used to simulate 1-bit addition
    assign sub_op = X ^ Y;      // XOR used to simulate 1-bit subtraction
    assign and_op = X & Y;      // AND operation
    assign or_op  = X | Y;      // OR operation

    // 4-to-1 multiplexer to select one operation based on S1 and S0
    assign R = (S1 == 0 && S0 == 0) ? add_op :  // S1S0 = 00 → Add
               (S1 == 0 && S0 == 1) ? sub_op :  // S1S0 = 01 → Subtract
               (S1 == 1 && S0 == 0) ? and_op :  // S1S0 = 10 → AND
                                     or_op;     // S1S0 = 11 → OR

endmodule
