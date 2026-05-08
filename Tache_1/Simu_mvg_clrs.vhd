library ieee;
use ieee.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;


entity Simu is
end Simu;

architecture Behavioral of Simu is
signal Clk100: std_logic:='0';
signal Reset: std_logic;
signal RED_Out,GREEN_Out,BLUE_Out: std_logic_vector(3 downto 0);
begin
moving_colors: entity work.Mvg_clrs
    port map(Clk100 => Clk100, Reset => Reset, RED_Out => Red_Out, GREEN_out => GREEN_Out, BLUE_Out =>BLUE_Out);
clk100 <=  not clk100 after 0.01 ns;
Reset <= '0', '1' after 0.01 ns;
end behavioral;
