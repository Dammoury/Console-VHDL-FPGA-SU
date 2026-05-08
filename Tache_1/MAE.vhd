library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.all;

entity MAE is
    Port ( Clk, Reset: in std_logic;
    B_in_MAE,G_in_MAE,R_in_MAE: in std_logic_vector(4 downto 0);
    ComG_MAE,ComR_MAE,ComB_MAE: out std_logic_vector( 1 downto 0)
    );
end MAE;

architecture Moore of MAE is
type etat is(E0,E1,E2);
signal EP,EF: etat;
begin

process(clk,reset) -- Registre d'états
    begin
    if reset= '0' then EP <= E0;
    elsif rising_edge(clk) then EP <=EF;
    end if;
end process;

process(EP, G_in_MAE,B_in_MAE,R_in_MAE) --Combinatoire des états
    begin
    case(EP) is
        when E0 => EF <=E0; if G_in_MAE="11111" then EF <= E1;end if;
        when E1 => EF <=E1;if B_in_MAE="11111" then EF <= E2;end if;
        when E2 => EF <=E2; if R_in_MAE="11111" then EF <= E0;end if;
        when others => EF <= EP;
        end case;
end process;

process(EP) --Combinatoire des Sorties
    begin
    case(EP) is
        when E0 => ComG_MAE <= "01"; ComR_MAE <= "10"; ComB_MAE <= "00" or "11";
        when E1 => ComG_MAE <= "10"; ComR_MAE <= "00" or "11"; ComB_MAE <= "01";
        when E2 => ComG_MAE <= "00" or "11"; ComR_MAE <= "01"; ComB_MAE <= "10";
    end case;
end process;
end Moore;
