module counter (
    input clk,            // 輸入時鐘信號
    input reset,          // 當 reset 為 1 時，計數器會重置
    output reg [3:0] out  // 4 位元輸出
);

always @(posedge clk or posedge reset) begin
    if (reset)
        out <= 4'b0000;  // 重置計數器為 0
    else
        out <= out + 1;  // 每次時鐘上升沿計數器加 1
end

endmodule
