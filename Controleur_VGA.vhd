LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.std_logic_arith.all;

ENTITY Controleur_VGA IS 
	PORT	( 	clk 			:IN STD_LOGIC;
				reset			:IN STD_LOGIC;
				h_count 		:BUFFER UNSIGNED (10 DOWNTO 0):="00000000000";
				h_synchro	:OUT STD_LOGIC
			);
END Controleur_VGA;

ARCHITECTURE Arch_Controleur_VGA OF Controleur_VGA IS 

BEGIN
	PROCESS(clk)
	BEGIN

		IF rising_edge(clk) THEN
		IF reset = '1' THEN
			h_count <= "00000000000";
		ELSE  IF h_count = 1039 THEN 
			h_count <= "00000000000";
		
		ELSE
			h_count <= h_count + 1;
		
		END IF;
		END IF;
		END IF;
	
	END PROCESS;

	PROCESS (h_count)
	BEGIN
	
		IF h_count = 1039 THEN
			h_synchro <= '0';
		ELSE
			h_synchro <= '1';
		END IF;
		
	END PROCESS;
END Arch_Controleur_VGA;