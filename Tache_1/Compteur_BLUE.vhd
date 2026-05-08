library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Compteur_BLUE is port(	
	Clk,Reset	: in std_logic; 
	ComB		: in std_logic_vector(1 downto 0);
	SortieB 	: out std_logic_vector(3 downto 0);
	B_in_cpt: out std_logic_vector (4 downto 0)
    );
end Compteur_BLUE;

architecture archi of Compteur_BLUE is

signal cpt: std_logic_vector(4 downto 0) :="00000";

begin
B_in_cpt<= cpt;
sortieB<=cpt(4 downto 1);
process(clk,reset)

begin
    
   if reset='0' then cpt<=(others =>'0');
   
   elsif rising_edge(clk) then 
      -- Incrémentation
      if ComB="01" then cpt<=cpt+1;
      -- Décrémentation
      elsif ComB="10" then cpt<=cpt-1;
      --Maintien de la valeur actuelle
      else cpt<=cpt;
      end if;
   end if;
end process;

end archi;
