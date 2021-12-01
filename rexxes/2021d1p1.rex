/* REXX */

rootpath = "/prj/repos/aoc2021"  
inputpath = rootpath"/input/" 
infile = inputpath"2021d1p1.ebcdic"

x = bpxwunix('cat 'infile,,file.,se.)




previous = ''
increments = 0

do i = 1 to file.0
  /* Read all file */
  if previous = '' then nop
  else do
    if file.i > previous 
    then increments = increments + 1
  end
  previous = file.i
end

say "solution="increments
