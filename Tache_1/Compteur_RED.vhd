library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Compteur_RED is port(	
	Clk,Reset	: in std_logic; 
	ComR			: in std_logic_vector(1 downto 0);
	SortieR: out std_logic_vector( 3 downto 0);
	R_in_cpt: out std_logic_vector (4 downto 0)
    );
end Compteur_RED;

architecture archi of Compteur_RED is

signal cpt: std_logic_vector(4 downto 0) :="11111";
begin
R_in_cpt<= cpt;
sortieR<=cpt(4 downto 1);
process(clk,reset)

begin
    
   if reset='0' then cpt<=(others =>'1');
   
   elsif rising_edge(clk) then 
      -- Incrémentation
      if ComR="01" then cpt<=cpt+1;
      -- Décrémentation
      elsif ComR="10" then cpt<=cpt-1;
      -- Maintien de la valeur actuelle
      else cpt<=cpt;
      end if;
   end if;
end process;

end archi;
