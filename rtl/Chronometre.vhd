library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity chronometre is
    Port (
        MAX10_CLK1_50 : in  STD_LOGIC;
        SW            : in  STD_LOGIC_VECTOR(1 downto 0);
        HEX0          : out STD_LOGIC_VECTOR(7 downto 0);
        HEX1          : out STD_LOGIC_VECTOR(7 downto 0);
        HEX2          : out STD_LOGIC_VECTOR(7 downto 0);
        HEX3          : out STD_LOGIC_VECTOR(7 downto 0)
    );
end chronometre;

architecture Behavioral of chronometre is

    -- composant
    component MUX is
        Port (
            in_S  : in  STD_LOGIC_VECTOR(3 downto 0);
            out_S : out STD_LOGIC_VECTOR(7 downto 0)
        );
    end component;

    component diviseur_seconde is
        Port (
            MAX10_CLK1_50 : in  STD_LOGIC;
            SW1           : in  STD_LOGIC;
            SW0           : in  STD_LOGIC;
            OV_seconde    : out STD_LOGIC;
            s_seconde     : out STD_LOGIC_VECTOR(5 downto 0)
        );
    end component;

    component double_dabble is
        Port (
            s_seconde   : in  STD_LOGIC_VECTOR(5 downto 0);
            s_seconde_u : out STD_LOGIC_VECTOR(3 downto 0);
            s_seconde_d : out STD_LOGIC_VECTOR(3 downto 0)
        );
    end component;


    component counter_minute is
        Port (
            ov_seconde     : in  STD_LOGIC;
            SW1            : in  STD_LOGIC;
            flag_Db_Minute : out STD_LOGIC;
            s_minute       : out STD_LOGIC_VECTOR(5 downto 0);
            MAX10_CLK1_50  : in  STD_LOGIC
        );
    end component;

    -- signaux
    signal s_seconde, s_minute : STD_LOGIC_VECTOR(5 downto 0);
    signal s_seconde_u, s_seconde_d, s_minute_u, s_minute_d : STD_LOGIC_VECTOR(3 downto 0);
    signal OV_seconde, flag_Db_Minute : STD_LOGIC;

begin

    -- 1) Tick 1 Hz + secondes (0..59) + pulse minute (OV_seconde)
    inst1 : diviseur_seconde
        port map(
            MAX10_CLK1_50 => MAX10_CLK1_50,
            SW1           => SW(1),   -- reset
            SW0           => SW(0),   -- pause
            OV_seconde    => OV_seconde,
            s_seconde     => s_seconde
        );

    -- 2) Compteur minutes (clock 50 MHz, enable = OV_seconde)
    inst2 : counter_minute
        port map(
            ov_seconde     => OV_seconde,
            SW1            => SW(1),
            flag_Db_Minute => flag_Db_Minute,
            s_minute       => s_minute,
            MAX10_CLK1_50  => MAX10_CLK1_50
        );

    -- 3) Conversion BCD (minutes / secondes)
    inst3 : double_dabble
        port map(
            s_seconde   => s_minute,
            s_seconde_u => s_minute_u,
            s_seconde_d => s_minute_d
        );

    inst4 : double_dabble
        port map(
            s_seconde   => s_seconde,
            s_seconde_u => s_seconde_u,
            s_seconde_d => s_seconde_d
        );

    -- 4) Affichage 7-seg
    inst5 : MUX port map(in_S => s_minute_u,  out_S => HEX2);
    inst6 : MUX port map(in_S => s_minute_d,  out_S => HEX3);
    inst7 : MUX port map(in_S => s_seconde_u, out_S => HEX0);
    inst8 : MUX port map(in_S => s_seconde_d, out_S => HEX1);

end Behavioral;
