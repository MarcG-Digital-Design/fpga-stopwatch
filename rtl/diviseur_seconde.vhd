library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity diviseur_seconde is
    Port (
        MAX10_CLK1_50 : in  STD_LOGIC;
        SW1           : in  STD_LOGIC; -- RESET
        SW0           : in  STD_LOGIC; -- PAUSE (1 = pause)
        OV_seconde    : out STD_LOGIC; -- pulse quand on passe de 59->0
        s_seconde     : out STD_LOGIC_VECTOR(5 downto 0)
    );
end diviseur_seconde;

architecture Behavioral of diviseur_seconde is
    signal div_cnt : unsigned(25 downto 0) := (others => '0'); -- suffit pour 50M
    signal sec_cnt : unsigned(5 downto 0)  := (others => '0');
begin

    process(MAX10_CLK1_50)
    begin
        if rising_edge(MAX10_CLK1_50) then
            if SW1 = '1' then
                div_cnt    <= (others => '0');
                sec_cnt    <= (others => '0');
                OV_seconde <= '0';

            elsif SW0 = '1' then
                -- pause : on fige tout
                OV_seconde <= '0';

            else
                if div_cnt = to_unsigned(49_999_999, div_cnt'length) then
                    div_cnt <= (others => '0');

                    if sec_cnt = to_unsigned(59, sec_cnt'length) then
                        sec_cnt    <= (others => '0');
                        OV_seconde <= '1';  -- pulse 1 cycle 50MHz
                    else
                        sec_cnt    <= sec_cnt + 1;
                        OV_seconde <= '0';
                    end if;

                else
                    div_cnt    <= div_cnt + 1;
                    OV_seconde <= '0';
                end if;
            end if;
        end if;
    end process;

    s_seconde <= std_logic_vector(sec_cnt);

end Behavioral;
