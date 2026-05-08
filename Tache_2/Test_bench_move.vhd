library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Test_bench_move is
end Test_bench_move;

architecture Behavioral of Test_bench_move is
signal  Clk25s: std_logic:='0';
signal Resets: std_logic;
signal  QAs,QBs :  std_logic;
signal Rot_lefts, Rot_Rights: std_logic;
begin
Move_bis: entity work.Move
port map( Clk25=>Clk25s, Reset=> Resets, QA=> QAs, QB => QBs, Rot_left => Rot_lefts, Rot_right => Rot_rights);
Clk25s<= not Clk25s after 40 ns;
Resets <= '0', '1' after 40 ns;
QAs <= '0', '1' after 130 ns, '0' after 230 ns, '1' after 330 ns, '0' after 430 ns, '1' after 580 ns, '0' after 680 ns, '1' after 730 ns, '0' after 830 ns;
QBs <= '0', '1' after 90 ns, '0' after 180 ns, '1' after 380 ns, '0' after 480 ns, '1' after 530 ns, '0' after 630 ns;
end Behavioral;
