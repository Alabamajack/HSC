library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

--
-- idea: instead of the inputs are all extra ports, the ports are combined in one array
-- example: there should be the inputs a,b,c,d; all of them should have the type of std_logic_vector(2 downto 0);
-- 			-> WIDTH will be 3 (the a'length = b'length = c'length = d'length) and INPUTS will be 4 (so for the 4 inputs)
--			-> now the array input_arr must be build off a,b,c,d
--			-> in this implementation, input_arr is a combination of a,b,c,d and s choose the input (one of a,b,c,d)
--			-> with s the user could choose which array will be at the output (one of a,b,c,d)
--			-> the order of these arrays within input_arr is selected so, that if s = 0, the array which is at the position 
--			   WIDTH - 1 downto 0 will be choosen
--			-> in this example this means: input_arr <= a & b & c & d; then if s = 0, d will be selected; if s = 3, a will be selected
--

entity gen_mux is
	generic(
		INPUTS : positive := 8;
		WIDTH  : positive := 8
	);
	port(
		input_arr : in  std_logic_vector(INPUTS * WIDTH - 1 downto 0);
		s         : in  std_logic_vector(integer(floor(log2(real(INPUTS)) + 0.5)) - 1 downto 0);
		q         : out std_logic_vector(WIDTH - 1 downto 0)
	);

end entity gen_mux;

architecture RTL of gen_mux is
	signal s_int : natural := 0;
begin
	s_int <= to_integer(unsigned(s));
	q     <= input_arr((s_int * INPUTS) * WIDTH - 1 downto s_int * WIDTH) when s_int > 0
		else input_arr(WIDTH - 1 downto 0);
end architecture RTL;