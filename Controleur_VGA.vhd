LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.std_logic_arith.all;

ENTITY Controleur_VGA IS 
	PORT	( 	clk 			:IN STD_LOGIC;
				reset			:IN STD_LOGIC;
				
				r_in			:IN STD_LOGIC;
				g_in			:IN STD_LOGIC;
				b_in			:IN STd_LOGIC;
				
				h_count 		:BUFFER UNSIGNED (10 DOWNTO 0):="00000000000";
				v_count		:BUFFER UNSIGNED (9 DOWNTO 0) :="0000000000";
				
				h_synchro	:OUT STD_LOGIC;
				v_synchro	:OUT STD_LOGIC;
				
				VA_h			:BUFFER STD_LOGIC;
				VA_v			:BUFFER STD_LOGIC;
				VA				:BUFFER STD_LOGIC;
				
				R_OUT 		:OUT STD_LOGIC_VECTOR (7 DOWNTO 0):="00000000";
				G_OUT 		:OUT STD_LOGIC_VECTOR (7 DOWNTO 0):="00000000";
				B_OUT 		:OUT STD_LOGIC_VECTOR (7 DOWNTO 0):="00000000";
				
				VGA_sync_n	:OUT STD_LOGIC := '0';
				VGA_blank_n	:OUT STD_LOGIC := '1';
				VGA_clk		:OUT STD_LOGIC
			);
END Controleur_VGA;

ARCHITECTURE Arch_Controleur_VGA OF Controleur_VGA IS 

BEGIN

Hcompt:	PROCESS(clk)
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
			
			END PROCESS Hcompt;

Hsynchro:	PROCESS (h_count)
				BEGIN
				
					IF h_count >= 920 THEN
						h_synchro <= '0';
					ELSE
						h_synchro <= '1';
					END IF;
					
				END PROCESS Hsynchro;
	
Vcompt:	PROCESS (clk, h_count, reset)
			BEGIN
				IF rising_edge(clk) THEN
				IF reset='1' THEN
					v_count <= "0000000000";
				ELSE IF (v_count=665 AND h_count = 1039) THEN 
					v_count <="0000000000";
				ELSE IF h_count=1039 THEN
					v_count <= v_count+1;
				END IF;
				END IF;
				END IF;
				END IF;
			END PROCESS Vcompt;
	
Vsynchro:	PROCESS (v_count)
				BEGIN
				
					IF v_count >= 660 THEN
						v_synchro <= '0';
					ELSE
						v_synchro <= '1';
					END IF;
					
				END PROCESS Vsynchro;
	
VAh:	PROCESS (h_count)
		BEGIN
			
			IF (h_count > 63 AND h_count < 864) THEN
				VA_h <= '1';
			ELSE
				VA_h <= '0';
			END IF;

		END PROCESS VAh;
		
		
ET:	PROCESS (Va_h, Va_v)
		BEGIN
			IF (Va_h='1' AND Va_v='1') THEN
				VA <= '1';
			ELSE
				VA <= '0';
			END IF;
		END PROCESS ET;


VAv:	PROCESS (v_count)
		BEGIN
			
			IF (v_count > 22 AND v_count < 623) THEN
				VA_v <= '1';
			ELSE
				VA_v <= '0';
			END IF;

		END PROCESS VAv;
		
		
ROUGE:	PROCESS (VA, R_in)
			begin
				if VA = '1' then
					if r_in = '1' then
						R_OUT <= "11111111";
					else
						R_OUT <= "00000000";
					end if;
				else
					R_OUT <= "00000000";
				end if;
						
			end process rouge;
			
vert:	PROCESS (VA, g_in)
			begin
				if VA = '1' then
					if g_in = '1' then
						G_OUT <= "11111111";
					else
						G_OUT <= "00000000";
					end if;
				else
					G_OUT <= "00000000";
				end if;
						
			end process vert;
			
bleu:	PROCESS (VA, b_in)
			begin
				if VA = '1' then
					if b_in = '1' then
						b_OUT <= "11111111";
					else
						b_OUT <= "00000000";
					end if;
				else
					b_OUT <= "00000000";
				end if;
						
			end process bleu;
			
			
vga_clk<=clk;
		
END Arch_Controleur_VGA;