/* REXX */

parse arg puzzleinput
DEBUG="0"
numeric digits(32)
begin = time('S')
/* remove the 0x0d :)*/
x = bpxwunix('tr -d "\r" < 'puzzleinput,,file.,se.)

/* one line of input, horizontal positions comma seperated */

positions = translate(file.1," ", ",")
crabat. = 0                    /* crabs at position x */
maxpos  = -1
do i = 1 to words(positions)
  pos = word(positions,i)
  crabat.pos = crabat.pos + 1
  if pos > maxpos then do
    maxpos = pos
  end
end


/* Why am I brute forcing this again?! */

lowestCost = 100000000000000000000000000000000000000000000000000000
do i = 0 to maxpos
  /* optimize: no need to calculate move to empy spots. Saves 28secs! */
  if crabat.i = 0 then iterate
  fuel = 0                                    /* fuel for move to i */
  do j = 0 to maxpos
    /* optimize no need to calculate moving from empty spots (another 5 secs)*/
    if crabat.j = 0 then iterate
    d = abs(i-j) /* saves 4 secs doing it only once.. */
    fuel = (((d*(d+1))/2) * crabat.j) + fuel
  end
  if fuel < lowestCost 
  then do 
    lowestCost = fuel
  end
end
say "solution="lowestCost"@"time('S')-begin

exit

