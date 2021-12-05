/* REXX */

parse arg puzzleinput
DEBUG="0"
begin = time('S')
/* remove the 0x0d :)*/
x = bpxwunix('tr -d "\r" < 'puzzleinput,,file.,se.)

points. = 0
points.x. = 0
points.y. = 0
maxx = 0
maxy = 0
/* a formula is a vector. */

/* parse the stuff into fomrulae */
do i = 1 to file.0
  parse var file.i x1","y1" -> "x2","y2
  if x1 > maxx then maxx = x1
  if x2 > maxx then maxx = x2
  if y1 > maxy then maxy = y1
  if y2 > maxy then maxy = y2
  if x1 - x2 = 0
  then do 
    slope = 0
    if y1 > y2 
    then ys = -1
    else ys = 1
    do yy = y1 to y2 by ys
      points.x1.yy = points.x1.yy + 1
    end
  end
  else do 
    slope = (y1-y2) / (x1-x2)
    if x1 > x2 
    then xs = -1 
    else xs = 1
    do x = x1 to x2 by xs
      /* https://www.mathsisfun.com/algebra/line-equation-2points.html */
      /* y - <y2> = <slope> * (<x>-<x2>) 
        y = <slope> * (<x>-<x2>) + <y2>
      y = (slope * (x - x2))  + y2 
      */
      y = (slope * (x - x2)) + y2
      points.x.y = points.x.y + 1
    end
  end
end
s = 0
do y = 0 to maxy
  do x = 0 to maxx
    if points.x.y >= 2 then s = s + 1
  end
end

  
if DEBUG="1" then
  say time('S') - begin
say "solution="s


