library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Compteur_GREEN is port(	
	Clk,Reset	: in std_logic; 
	ComG	: in std_logic_vector(1 downto 0);
	SortieG: out std_logic_vector( 3 downto 0);
	G_in_cpt: out std_logic_vector (4 downto 0)
    );
end Compteur_GREEN;

architecture archi of Compteur_GREEN is

signal cpt: std_logic_vector(4 downto 0) :="00000";

begin
G_in_cpt<= cpt;
sortieG<=cpt(4 downto 1);
process(clk,reset)

begin
    
   if reset='0' then cpt<=(others =>'0');
   
   elsif rising_edge(clk) then 
      -- Incrémentation
      if ComG="01" then cpt<=cpt+1;
      -- Décrémentation
      elsif ComG="10" then cpt<=cpt-1;
      -- Maintien de la valeur actuelle
      else cpt<=cpt;
      end if;
   end if;
end process;

end archi;
