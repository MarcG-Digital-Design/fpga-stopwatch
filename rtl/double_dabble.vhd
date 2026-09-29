library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.ALL;

entity double_dabble is
    Port (

        s_seconde   : in  STD_LOGIC_VECTOR(5 downto 0);
        s_seconde_u : out STD_LOGIC_VECTOR(3 downto 0);
        s_seconde_d : out STD_LOGIC_VECTOR(3 downto 0)
    );
end double_dabble;

architecture Behavioral of double_dabble is
begin
    process(s_seconde)										-- purement combinatoire
        variable bcd : unsigned(7 downto 0);
    begin
        bcd := (others => '0');

        for i in 5 downto 0 loop
            if bcd(7 downto 4) > 4 then
                bcd(7 downto 4) := bcd(7 downto 4) + 3;
            end if;

            if bcd(3 downto 0) > 4 then
                bcd(3 downto 0) := bcd(3 downto 0) + 3;
            end if;

            bcd := bcd(6 downto 0) & s_seconde(i);
        end loop;

        s_seconde_u <= std_logic_vector(bcd(3 downto 0)); -- unités
        s_seconde_d <= std_logic_vector(bcd(7 downto 4)); -- dizaines
    end process;
end Behavioral;
