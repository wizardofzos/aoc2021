/* REXX */

parse arg puzzleinput
DEBUG="0"

/* remove the 0x0d :)*/
x = bpxwunix('tr -d "\r" < 'puzzleinput,,file.,se.)

/* empty stem for x/y locs */
loc. = 0
loc.x. = 0
loc.y. = 0

/* seeing as we will abuse the stem. need maxval for both.. */
xmax = 0
ymax = 0

/* parse the stuff into our massive stem */
do i = 1 to file.0
  parse var file.i x1","y1" -> "x2","y2
  /* take care of max vals */
  if x1 > xmax then xmax = x1
  if x2 > xmax then xmax = x2
  if y1 > ymax then ymax = y1
  if y2 > ymax then ymax = y2
  select
    when x1 = x2 then do
      if y2 > y1 then do
        do y = y1 to y2
          loc.x1.y = loc.x1.y + 1

        end
      end
      else do
        do y = y2 to y1
          loc.x1.y = loc.x1.y + 1

        end
      end
    end
    when y1 = y2 then do
      if x2 > x1 then do
        do x = x1 to x2
          loc.x.y1 = loc.x.y1 + 1

        end
      end
      else do
        do x = x2 to x1
          loc.x.y1 = loc.x.y1 + 1

        end 
      end    
    end
    otherwise do
      /* what?? */
      
    end
  end
end

points = 0
do y = 0 to ymax
  if DEBUG="1" then
    xline = ''
  do x = 0 to xmax
    if DEBUG="1" then
      xline = xline" " loc.x.y
    if loc.x.y >= 2 then points = points + 1
  end
  if DEBUG="1" then say xline
end

say "solution="points
