library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Mvg_clrs is
    Port (Clk100,Reset: in std_logic;
    RED_Out,GREEN_Out,BLUE_Out: out std_logic_vector(3 downto 0)
    );
end Mvg_clrs;

architecture Behavioral of Mvg_clrs is
--Signaux de la MAE
signal ComR_MAE,ComG_MAE,ComB_MAE: std_logic_vector( 1 downto 0);

--Signaux de Compteur_RED
signal ComR	: std_logic_vector(1 downto 0);
signal SortieR : std_logic_vector(3 downto 0);
signal R_in_cpt: std_logic_vector (4 downto 0);

--Signaux de Compteur_BLUE
signal ComB	: std_logic_vector(1 downto 0);
signal SortieB : std_logic_vector(3 downto 0);
signal B_in_cpt: std_logic_vector (4 downto 0);

--Signaux de Compteur_GREEN
signal ComG	: std_logic_vector(1 downto 0);
signal SortieG : std_logic_vector(3 downto 0);
signal G_in_cpt: std_logic_vector (4 downto 0);

--Signaux de Div20Hz (Implementation)
signal clk20: std_logic;

--Signaux de Div10MHz (Simulation)
signal clk10: std_logic;


begin
Compteur_REDbis: entity work.Compteur_RED
    Port Map(
        Clk => clk20, --clk20 si I clk10 si S
        Reset => Reset,
        ComR=> ComR_MAE,
        SortieR => RED_Out,
        R_in_cpt => R_in_cpt
        );
Compteur_BLUEbis: entity work.Compteur_BLUE
    port map(
        Clk => clk20, --clk20 si I clk10 si S
        Reset => reset,
        ComB => ComB_MAE,
        SortieB => BLUE_Out,
        B_in_cpt => B_in_cpt
        );
Compteur_GREENbis: entity work.Compteur_GREEN
    port map(
        Clk =>  clk20, --clk20 si I clk10 si S
        Reset => reset,
        ComG => ComG_MAE,
        SortieG => GREEN_Out,
        G_in_cpt => G_in_cpt
        ); 
MAE_bis: entity work.MAE
    port map(
        B_in_MAE => B_in_cpt,
        G_in_MAE => G_in_cpt,
        R_in_MAE => R_in_cpt,
        Clk => clk100,
        Reset => reset,
        ComG_MAE => ComG_MAE,
        ComB_MAE => ComB_MAE,
        ComR_MAE => ComR_MAE
        );
Divclk_I: entity work.Div20Hz   --Pour l'implémentation (20Hz)
    port map(
        clk100 => clk100,
        reset  => reset,
        clk20  => clk20
        );
Divclk_S : entity work.Div10MHz --Pour la Simulation (10MHz)
    port map(
    clk100 => clk100,
    reset => reset,
    clk10 => clk10
    );
end Behavioral;
