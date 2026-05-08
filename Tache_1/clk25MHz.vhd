library ieee;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ClkDiv is
	port(
    clk100,reset: in std_logic;
    clk25: out std_logic
    );
end ClkDiv;

architecture Divhorloge of ClkDiv is
signal counter   : std_logic_vector(1 downto 0) := (others => '0');
signal clk25_int : std_logic := '0';
begin
    process(Clk100, Reset)
    begin
        if Reset = '0' then
            counter   <= "00";
            clk25_int <= '0';
        elsif rising_edge(Clk100) then
            if counter = "01" then
                counter   <= "00";
                clk25_int <= not clk25_int;
            else
                counter<= counter+ 1;
            end if;
        end if;
    end process;

    Clk25 <= clk25_int;
end Divhorloge;
