view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue U -period 20ns -dutycycle 50 -starttime 0ns -endtime 41600ns sim:/controleur_vga/clk 
wave create -driver freeze -pattern clock -initialvalue U -period 10000ns -dutycycle 50 -starttime 0ns -endtime 41600ns sim:/controleur_vga/reset 
WaveCollapseAll -1
wave clipboard restore
