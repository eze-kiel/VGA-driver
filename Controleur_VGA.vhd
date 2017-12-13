LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;

ENTITY Controleur_VGA IS 
	PORT	( 	clk 		:IN STD_LOGIC;
				reset		:IN STD_LOGIC;
				h_count 	:BUFFER STD_LOGIC_VECTOR (10 DOWNTO 0):="00000000000"
			);
END Controleur_VGA;

ARCHITECTURE Arch_Controleur_VGA OF Controleur_VGA IS 


BEGIN 
	PROCESS(clk)
	BEGIN
	IF reset = '1' THEN
		h_count <= "00000000000";
	ELSE IF rising_edge(clk) THEN
		IF h_count = 1040 THEN
			h_count <= "00000000000";
		ELSE
			h_count <= h_count + 1;
		END IF;
		END IF;
		END IF;

	
				
	END PROCESS;
END Arch_Controleur_VGA;