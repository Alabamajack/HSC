library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity gen_multi is
	generic (BREITE : positive := 8);
	port (
		a : in std_logic_vector(BREITE - 1 downto 0);
		b : in std_logic_vector(BREITE - 1 downto 0);
		q : out std_logic_vector(BREITE * 2 - 1 downto 0)
	);
end entity gen_multi;

architecture RTL of gen_multi is
begin
	q <= std_logic_vector(unsigned(a) * unsigned(b));
end architecture RTL;
