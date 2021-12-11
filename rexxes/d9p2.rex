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
  /* check all points around us (no nines or higher) 
  if that point is higher. add to res. and recurse
                p1 p2 p3
                p4 xy p5
                p6 p7 p8 
  */
  r = ''
  say rr
  do k = 1 to words(rr)
    loccie = word(rr,k)
    parse var loccie xx","yy
    val = pos.xx.yy
    say "Checking basin"xx","yy"==>"val
 
    p1x = xx - 1; p1y = yy - 1
    p2x = xx    ; p2y = yy - 1
    p3x = xx + 1; p3y = yy - 1
    p4x = xx - 1; p4y = yy 
    p5x = xx + 1; p5y = yy
    p6x = xx - 1; p6y = yy + 1
    p7x = xx    ; p7y = yy + 1
    p8x = xx + 1; p8y = yy + 1
    
    say p2x","p2y"==>"pos.p2x.p2y
    say p4x","p4y"==>"pos.p4x.p4y
    say p5x","p5y"==>"pos.p5x.p5y
    say p7x","p7y"==>"pos.p7x.p7y


    if pos.p2x.p2y > val & pos.p2x.p2y < 9 then do
      say p2x","p2y
      r = r" "p2x","p2y
    end

    if pos.p4x.p4y > val & pos.p4x.p4y < 9 then do
      say p4x","p4y
      r = r" "p4x","p4y
    end
    if pos.p5x.p5y > val & pos.p5x.p5y < 9 then do
      say p5x","p5y
      r = r" "p5x","p5y
    end

    if pos.p7x.p7y > val & pos.p7x.p7y < 9 then do
      say p7x","p7y
      r = r" "p7x","p7y
    end
  end
  new = ""
  if words(r) < 1 then return rr
  else do
    do ll = 1 to words(r)
      new = new" "createBasin(word(r,ll))
    end
    return rr" "new
  end




