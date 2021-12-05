/* REXX */

parse arg puzzleinput
/* remove the 0x0d :)*/
x = bpxwunix('tr -d "\r" < 'puzzleinput,,file.,se.)

points. = 0
points.x. = 0
points.y. = 0
maxx = 0
maxy = 0

do i = 1 to file.0
  parse var file.i x1","y1" -> "x2","y2
  if x1 > maxx then maxx = x1
  if x2 > maxx then maxx = x2
  if y1 > maxy then maxy = y1
  if y2 > maxy then maxy = y2
  if x1 - x2 = 0
  then do 
    /* If both x the same, it must be a vertical line */
    if y1 > y2 /* that can either go up or down */
    then ys = -1
    else ys = 1
    do yy = y1 to y2 by ys
      points.x1.yy = points.x1.yy + 1    /* add those 'points' */
    end
  end
  else do 
    /* otherwise it's a diagonal */
    slope = (y1-y2) / (x1-x2)
    if x1 > x2                            /* see if we're going      */
    then xs = -1                          /* right to left           */
    else xs = 1                           /* or left to right        */
    do x = x1 to x2 by xs                 /* to determine 'by' value */
      /* Use some 'basic' math formulas to determine points on line 
         https://www.mathsisfun.com/algebra/line-equation-2points.html 
         y - <y2> = <slope> * (<x>-<x2>)     (basic formula)  
         y = <slope> * (<x>-<x2>) + <y2>     (solve for y)
         y = (slope * (x - x2))  + y2        (so will be...)
      */
      y = (slope * (x - x2)) + y2            /* use that formula */
      points.x.y = points.x.y + 1            /* add the points   */
    end
  end
end
s = 0
do y = 0 to maxy
  do x = 0 to maxx
    if points.x.y >= 2 then s = s + 1
  end
end
say "solution="s


