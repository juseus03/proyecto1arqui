`timescale 1 ns / 100 ps

module system_tb;

//----------------------------------------------------------------------------
// Parameter (may differ for physical synthesis)
//----------------------------------------------------------------------------
parameter tck              = 10;       // clock period in ns
parameter clk_freq = 1000000000 / tck; // Frequenzy in HZ

//----------------------------------------------------------------------------
//
//----------------------------------------------------------------------------
reg        clk_tb;
reg       lowRst_System_tb;



//----------------------------------------------------------------------------
// Device Under Test 
//----------------------------------------------------------------------------
system #(.clk_freq(clk_freq)) dut
(
	.Clk_System(	clk_tb),
	// Debug
	
	.lowRst_System(lowRst_System_tb)
	
	
);


/* Clocking device */
// Remember this is only for simulation. It never will be syntetizable //
initial         clk_tb <= 0;
always #(tck/2) clk_tb <= ~clk_tb;

/* Simulation setup */
initial begin
	//set the file for loggin simulation data
	$dumpfile("system_tb.vcd"); 
	//$monitor("%b,%b,%b",clk_tb,rst_tb,led_tb);
	//export all signals in the simulation viewer
	$dumpvars(-1, dut);
	//$dumpvars(-1,clk_tb,rst_tb,led_tb, dut);
	
	//$dumpvars(-1,clk_tb,rst_tb);


	#10 lowRst_System_tb=0;
	#20 lowRst_System_tb=1;
	#1500 lowRst_System_tb=0;


	
	#(tck*1000000) $finish;
end
endmodule
