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
basins. = ''
basins.0 = potentials.0
do j = 1 to potentials.0
  parse var potentials.j ax","ay
  say "Basin for "ax","ay
  basins.j = createBasin(potentials.j)
  say "------DONE"
end

sizes = ""
do j = 1 to basins.0
  say basins.j
  sizes = sizes" "words(basins.j)
end
say sizes


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

createBasin: arg rr
 /* take all rows to left, upto a 9 or higher, then go down/up
 then do the same for rows to right*/
  r = ''
  say rr
  do k = 1 to words(rr)
    loccie = word(rr,k)
    parse var loccie xx","yy
    val = pos.xx.yy
    say "Checking basin"xx","yy"==>"val
    /* go left */
    do cx = xx to 0 by -1
      if pos.cx.yy < 9 then do
        newpos = cx","yy
        if isin(newpos,r) = 0 then
          r = r" "newpos
        do cy = yy to 0 by -1
          if pos.cx.cy < 9 then do
            newpos = cx","cy
            if isin(newpos,r) = 0 then
              r = r" "newpos
        end
        do cy = yy to ymax by 1
          if pos.cx.cy < 9 then do
            newpos = cx","cy
            if isin(newpos,r) = 0 then
              r = r" "newpos
        end        
      end
    end
    /* go right  */
    do cx = xx to xmax by 1
      if pos.cx.yy < 9 then do
        newpos = cx","yy
        if isin(newpos,r) = 0 then
          r = r" "newpos
        do cy = yy to 0 by -1
          if pos.cx.cy < 9 then do
            newpos = cx","cy
            if isin(newpos,r) = 0 then
              r = r" "newpos
        end
        do cy = yy to ymax by 1
          if pos.cx.cy < 9 then do
            newpos = cx","cy
            if isin(newpos,r) = 0 then
              r = r" "newpos
        end        
      end
    end    
 end
 return r
    

isin: parse arg n,h
  found = 0
  do i = 1 to words(h)
    if word(h,i) = n then do 
      found = 1
      leave
    end
  end
  return found




