library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gen_register is
	generic (BREITE : positive := 8);
	port (
		clk : in std_logic;
		rst : in std_logic;
		we	: in std_logic;
		a : in std_logic_vector(BREITE - 1 downto 0);
		q : out std_logic_vector(BREITE - 1 downto 0)
	);
end entity gen_register;

architecture RTL of gen_register is

begin
	
	flankengesteuertes_register : process (clk, rst) is
	begin
		if rst = '1' then
			q <= (others => '0');
		elsif falling_edge(clk) then
			if we = '1' then
				q <= a;
			end if;
		end if;
	end process flankengesteuertes_register;
	
	
end architecture RTL;
