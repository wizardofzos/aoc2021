/* REXX */

parse arg puzzleinput

rootpath = "/prj/repos/aoc2021"  
inputpath = rootpath"/input/" 
infile = inputpath"2021d1p1.ebcdic"

/* remove the 0x0d :)*/
x = bpxwunix('tr -d "\r" < 'puzzleinput,,file.,se.)




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
