library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Div10MHz is
    port(
        clk100  : in  std_logic;
        reset   : in  std_logic;
        clk10   : out std_logic
    );
end Div10MHz;

architecture Behavioral of Div10MHz is
    constant MAX_COUNT : integer := 5 - 1;
    signal counter     : integer range 0 to MAX_COUNT := 0;
    signal clk10_int   : std_logic := '0';
begin
    process(clk100, reset)
    begin
        if reset = '0' then
            counter   <= 0;
            clk10_int <= '0';
        elsif rising_edge(clk100) then
            if counter = MAX_COUNT then
                counter   <= 0;
                clk10_int <= not clk10_int;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;

    clk10 <= clk10_int;
end Behavioral;
