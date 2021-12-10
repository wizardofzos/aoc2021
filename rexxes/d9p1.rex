/* REXX for AoC*/

parse arg puzzleinput
DEBUG="0"
numeric digits(32)
begin = time('S')
/* remove the 0x0d :)*/
x = bpxwunix('tr -d "\r" < 'puzzleinput,,file.,se.)

potentials. = 0               /* store potential lowpoints as x,y */
pos. = 100000000          /* don't wanna worry on off edge    */

xmax = length(file.1)

do y = 1 to file.0
  ymax = y
  /* read our line pos by pos */
  do x = 1 to length(file.y)
    /* add one to all pos, so we have no edge issue */
    nx = x + 1
    ny = y + 1
    pos.nx.ny = substr(file.y,x,1)
  end
end

do y = 2 to ymax + 1 
  do x = 2 to xmax +1
    if lowest(x,y) = 'yes' then do 
      np = potentials.0 + 1
      potentials.np = x','y
      potentials.0 = np
    end
  end
end

solution = 0
do j = 1 to potentials.0
  parse var potentials.j ax","ay
  solution = solution + pos.ax.ay + 1
end


say "solution="solution"@"time('S')-begin

exit

lowest: arg xx,yy
  /* we have a safety border :) */
  c = pos.xx.yy
  px = xx - 1
  nx = xx + 1
  py = yy - 1
  ny = yy + 1
  lval = pos.px.yy
  rval = pos.nx.yy
  uval = pos.xx.py
  dval = pos.xx.ny
  if c < lval & c < rval & c < uval & c < dval then
    return "yes"
  else
    return "no"

