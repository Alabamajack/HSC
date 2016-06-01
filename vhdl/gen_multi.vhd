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
	signal a_h : unsigned(BREITE * 2 -1 downto 0);
	signal b_h : unsigned(BREITE * 2 -1 downto 0);
begin
	a_h <= unsigned(resize(unsigned(a), a_h'length));
	b_h <= unsigned(resize(unsigned(b), b_h'length));
	q <= std_logic_vector(a_h * b_h);
end architecture RTL;
