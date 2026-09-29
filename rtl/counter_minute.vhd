library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity counter_minute is
    Port (
        ov_seconde     : in  STD_LOGIC;  -- enable pulse (1 cycle)
        SW1            : in  STD_LOGIC;  -- reset
        flag_Db_Minute : out STD_LOGIC;  -- on le garde, mais = ov_seconde
        s_minute       : out STD_LOGIC_VECTOR(5 downto 0);
        MAX10_CLK1_50  : in  STD_LOGIC
    );
end counter_minute;

architecture Behavioral of counter_minute is
    signal min_cnt : unsigned(5 downto 0) := (others => '0');
begin

    process(MAX10_CLK1_50)
    begin
        if rising_edge(MAX10_CLK1_50) then
            if SW1 = '1' then
                min_cnt <= (others => '0');
            elsif ov_seconde = '1' then
                if min_cnt = to_unsigned(59, min_cnt'length) then
                    min_cnt <= (others => '0');
                else
                    min_cnt <= min_cnt + 1;
                end if;
            end if;
        end if;
    end process;

    s_minute       <= std_logic_vector(min_cnt);
    flag_Db_Minute <= ov_seconde; -- pulse à chaque minute

end Behavioral;
