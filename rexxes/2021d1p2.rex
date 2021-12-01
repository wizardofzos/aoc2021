/* REXX */

rootpath = "/prj/repos/aoc2021"  
inputpath = rootpath"/input/" 
infile = inputpath"2021d1p1.ebcdic"

x = bpxwunix('cat 'infile,,file.,se.)



buckets. = 0

do i = 1 to file.0
  /* Read all file */
  if i <= file.0 - 2 then do
    n1 = i + 1
    n2 = i + 2
    newb = buckets.0 + 1
    buckets.newb = file.i + file.n1 + file.n2
    buckets.0 = newb
  end
end

previous = ''
increments = 0

do i = 1 to buckets.0
  if previous = '' then nop
  else do
    if buckets.i > previous then increments = increments + 1
  end
  previous = buckets.i
end


say "solution="increments
