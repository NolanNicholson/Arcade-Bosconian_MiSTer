----------------------------------------------------------------------------------
--
-- Description:
-- async. timing PROM implementation
--
-- by Nolan Nicholson, 2021
-- This is a derivative work of the color PROMs for FPGA Galaga,
-- (c) copyright 2011...2015 by WoS (Wolfgang Scherr)
-- http://www.pin4.at - WoS <at> pin4 <dot> at
--
-- All Rights Reserved
--
-- Version 1.0
-- SVN: $Id$
--
----------------------------------------------------------------------------------
-- Redistribution and use in source and synthesized forms, with or without
-- modification, also in projects with different (but compatible) licenses,
-- are permitted provided that the following conditions are met:
--
-- * Redistributions of source code must retain the above copyright notice,
--   this list of conditions, a modification note and the following disclaimer.
--
-- * Redistributions in synthesized form must reproduce the above copyright
--   notice, this list of conditions and the following disclaimer in the
--   documentation or other materials provided with the distribution.
--
-- * The code must not be used for commercial purposes or re-licensed without
--   specific prior written permission of the author and contributors. It is
--   strictly for private use in hobby projects, without commercial interests.
--
-- * A person redistributing this code or any work products in private or 
--   public is also responsible for any legal issues which may arise by that.
--
-- Please feel free to report bugs to the author, but before you do so, please
-- make sure that this is not a derivative work and that you have the latest 
-- version of this file. 
-------------------------------------------------------------------------------
-- DISCLAIMER
--
-- THIS CODE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
-- AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
-- THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
-- PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
-- LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
-- CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
-- SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
-- INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
-- CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
-- ARISING IN ANY WAY OUT OF THE USE OF THIS CODE, EVEN IF ADVISED OF THE
-- POSSIBILITY OF SUCH DAMAGE.
----------------------------------------------------------------------------------

library ieee;
  use ieee.std_logic_1164.all;
  use ieee.numeric_std.all;

entity rom_7h is
  port (
    ADDR        : in    std_ulogic_vector(4 downto 0);
    CSn         : in    std_ulogic;
    DATA        : out   std_ulogic_vector(7 downto 0)
    );
end;

architecture RTL of rom_7h is
  type ROM_ARRAY is array(0 to 31) of std_ulogic_vector(7 downto 0);
  constant ROM : ROM_ARRAY := (
    x"3C", x"1B", x"37", x"37", x"3F", x"3F", x"3F", x"3F", -- 0x00
    x"3F", x"1B", x"3F", x"3F", x"B8", x"BF", x"BF", x"BF", -- 0x08
    x"3E", x"3F", x"3F", x"3F", x"3F", x"2A", x"3F", x"3F", -- 0x10
    x"3F", x"3F", x"3F", x"3F", x"BA", x"BA", x"BA", x"BA"  -- 0x18
  );
begin
  p_rom : process(ADDR, CSn)
  begin
    if CSn = '0' then
      DATA <= ROM(to_integer(unsigned(ADDR)));
    else
      DATA <= "11111111";
    end if;
  end process;
end RTL;
