
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX is
    Port ( 
    in_S : in STD_LOGIC_VECTOR (3 downto 0);
    out_S: out STD_LOGIC_VECTOR (7 downto 0));       
end MUX;

architecture Behavioral of MUX is



begin
    with in_S select
          out_S <= "11000000" when "0000",
                   "11111001" when "0001", 
                   "10100100" when "0010",
                   "10110000" when "0011", --3
                   "10011001" when "0100", --4
                   "10010010" when "0101", --5 
                   "10000010" when "0110", --6
                   "11111000" when "0111", --7
                   "10000000" when "1000", --8
                   "10010000" when "1001", --9
						 "11110000" when others;
end Behavioral;