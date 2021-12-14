----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.11.2019 16:02:19
-- Design Name: 
-- Module Name: top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity top is
    Port (  clk : in STD_LOGIC;
            in_port : in STD_LOGIC_VECTOR(7 downto 0);
            port_id : out STD_LOGIC_VECTOR(7 downto 0);
            out_port : out STD_LOGIC_VECTOR(7 downto 0));
end top;

architecture Behavioral of top is


component kcpsm6 is
    generic(        hwbuild : std_logic_vector(7 downto 0) := X"00";
                    interrupt_vector : std_logic_vector(11 downto 0) :=X"FFF";
                    scratch_pad_memory_size : integer := 64
                    );
    port(           address : out std_logic_vector(11 downto 0);
                    instruction : in std_logic_vector(17 downto 0);
                    bram_enable : out std_logic;
                    in_port : in std_logic_vector(7 downto 0);
                    out_port : out std_logic_vector(7 downto 0);
                    port_id : out std_logic_vector(7 downto 0);
                    write_strobe : out std_logic; 
                    k_write_strobe : out std_logic;
                    read_strobe : out std_logic;
                    interrupt : in std_logic;
                    interrupt_ack : out std_logic;
                    sleep : in std_logic;
                    reset : in std_logic;
                    clk : in std_logic
                  );
  end component kcpsm6;
  
  
  component RAM is
    port (
      clka : IN STD_LOGIC;
      wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      addra : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      
      clkb : IN STD_LOGIC;
      web : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      addrb : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      dinb : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
      );
  end component RAM;                
  
  
   
   component BRAM0 is
       Port (      address : in std_logic_vector(11 downto 0);
               instruction : out std_logic_vector(17 downto 0);
                    enable : in std_logic;
                       clk : in std_logic);
       end component BRAM0;
   
   component BRAM1 is
       Port (      address : in std_logic_vector(11 downto 0);
                   instruction : out std_logic_vector(17 downto 0);
                   enable : in std_logic;
                   clk : in std_logic);
              end component BRAM1;    
       
   
   
    signal address1 : std_logic_vector(11 downto 0);
    signal port_id_p1 : STD_LOGIC_VECTOR(7 DOWNTO 0);
    signal in_port_p1 : STD_LOGIC_VECTOR(7 DOWNTO 0);
    signal out_port_p1 : STD_LOGIC_VECTOR(7 DOWNTO 0);
    signal instruction_p1 : std_logic_vector(17 downto 0);
    signal bram_enable_p1 : std_logic;
    signal write_strobe_p1 : std_logic_vector(0 downto 0);
    signal k_write_strobe_p1 :  std_logic;
    signal read_strobe_p1 : std_logic;
    signal interrupt_p1 : std_logic;
    signal interrupt_ack_p1 : std_logic;
    signal sleep_p1 : std_logic;
    signal reset_p1 : std_logic;
    
    signal address2 : std_logic_vector(11 downto 0);
    signal port_id_p2 : STD_LOGIC_VECTOR(7 DOWNTO 0);
    signal in_port_p2 : STD_LOGIC_VECTOR(7 DOWNTO 0);
    signal out_port_p2 : STD_LOGIC_VECTOR(7 DOWNTO 0);
    signal instruction_p2 : std_logic_vector(17 downto 0);
    signal bram_enable_p2 : std_logic;
    signal write_strobe_p2 : std_logic_vector(0 downto 0);
    signal k_write_strobe_p2 :  std_logic;
    signal read_strobe_p2 : std_logic;
    signal interrupt_p2 : std_logic;
    signal interrupt_ack_p2 : std_logic;
    signal sleep_p2 : std_logic;
    signal reset_p2 : std_logic;
   
    
    begin
    
    picoblaze1: kcpsm6
    generic map(
                    hwbuild => X"00",
                    interrupt_vector => X"FFF",
                    scratch_pad_memory_size => 64 )
    port map(
                    address => address1,
                    instruction => instruction_p1,
                    bram_enable => bram_enable_p1,
                    in_port => in_port_p1,
                    out_port => out_port_p1,
                    port_id => port_id_p1,
                    write_strobe => write_strobe_p1(0),
                    k_write_strobe => k_write_strobe_p1,
                    read_strobe => read_strobe_p1,
                    interrupt => '0',
                    sleep => '0',
                    reset => '0',
                    clk => clk
                    );
    picoblaze2: kcpsm6
    generic map(
                    hwbuild => X"00",
                    interrupt_vector => X"FFF",
                    scratch_pad_memory_size => 64 )
    port map(
                    address => address2,
                    instruction => instruction_p2,
                    bram_enable => bram_enable_p2,
                    in_port => in_port_p2,
                    out_port => out_port_p2,
                    port_id => port_id_p2,
                    write_strobe => write_strobe_p2(0),
                    k_write_strobe => k_write_strobe_p2,
                    read_strobe => read_strobe_p2,
                    interrupt_ack => interrupt_ack_p2,
                    interrupt => '0',
                    sleep => '0',
                    reset => '0',
                    clk => clk
                                        );
    
     dual_port_ram: RAM
        port map(
                clka => clk,
                wea => write_strobe_p2,
                addra => port_id_p2,
                dina => out_port_p2,
                douta => in_port_p2,
                clkb => clk,
                web => write_strobe_p1,
                addrb => port_id_p1,
                dinb => out_port_p1,
                doutb => in_port_p1
                );
                
      
      pad_generator: BRAM0
        port map(
                address => address2,
                instruction => instruction_p2,
                enable => bram_enable_p2,
                clk => clk
                );
      vernam_chiper: BRAM1
        port map(
                 address => address1,
                 instruction => instruction_p1,
                 enable => bram_enable_p1,
                 clk => clk
                                );
    
                
end Behavioral;                                                      
