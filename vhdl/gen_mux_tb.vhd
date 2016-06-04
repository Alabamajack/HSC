library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity gen_mux_tb is
end entity gen_mux_tb;

architecture RTL of gen_mux_tb is
	constant INPUTS : positive := 4;
	constant WIDTH  : positive := 5;
	
	signal a : std_logic_vector(WIDTH - 1 downto 0) := "00010";
	signal b : std_logic_vector(WIDTH - 1 downto 0) := "00100";
	signal c : std_logic_vector(WIDTH - 1 downto 0) := "01000";
	signal d : std_logic_vector(WIDTH - 1 downto 0) := "10000";
	signal q : std_logic_vector(WIDTH - 1 downto 0);
	signal s : std_logic_vector(integer(floor(log2(real(INPUTS)) + 0.5)) - 1 downto 0);
	
	signal input_arr : std_logic_vector(INPUTS * WIDTH - 1 downto 0);

begin
	mux : entity work.gen_mux
		generic map(
			INPUTS => INPUTS,
			WIDTH  => WIDTH
		)
		port map(
			input_arr => input_arr,
			s         => s,
			q         => q
		);
		
	input_arr <= a & b & c & d;
	
	stim_proc : process is
	begin
		s <= std_logic_vector(to_unsigned(0,2));
		wait for 5 ns;
		s <= std_logic_vector(to_unsigned(1,2));
		wait for 5 ns;
		s <= std_logic_vector(to_unsigned(2,2));
		wait for 5 ns;
		s <= std_logic_vector(to_unsigned(3,2));
		wait for 5 ns;
	end process stim_proc;
	

end architecture RTL;
