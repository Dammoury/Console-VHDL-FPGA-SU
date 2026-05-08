library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

entity Move is
    Port ( Clk25, Reset: in std_logic;
    QA,QB : in std_logic;
    Rot_left, Rot_Right: out std_logic
    );
end Move;

architecture Moore of Move is
type etat is(E0,E1,E2,E3,E4,E5);
signal EP,EF: etat;
begin

process(clk25,reset) -- Registre d'états
    begin
    if reset= '0' then EP <= E0;
    elsif rising_edge(clk25) then EP <=EF;
    end if;
end process;

process(EP,QA,QB) --Combinatoire des états
    begin
    case(EP) is
        when E0 =>
            if (QA='1'and QB='0') then 
                EF <= E1;
            elsif (QA='1' and QB='1') then 
                EF <= E3;
            else
                EF <= E0;
           end if;
        when E1 => EF <=E2;
        when E2 =>
            if (QA = '0' and QB = '1') then 
                EF <= E4;
            elsif (QA = '0' and QB = '0') then 
                EF <= E5;
            else
                EF <= E2;
            end if;
        when E3 => EF <=E2;
        when E4 => EF <=E0;
        when E5 => EF <=E0;
        when others => EF <= EP;
        end case;
end process;

process(EP) --Combinatoire des Sorties
    begin
    case(EP) is
        when E0 =>  Rot_left<='0';  Rot_right<='0';
        when E1 =>  Rot_left<='1';  Rot_right<='0';
        when E2 =>  Rot_left<='0';  Rot_right<='0';
        when E3 =>  Rot_left<='0';  Rot_right<='1';
        when E4 =>  Rot_left<='1';  Rot_right<='0';
        when E5 =>  Rot_left<='0';  Rot_right<='1';
    end case;
end process;
end architecture;
