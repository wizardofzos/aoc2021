/* REXX */

parse arg puzzleinput
DEBUG="0"
begin = time('S')
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
      /* do the 45deg check :)
      */
      
      dx = abs(x1 - x2)
      dy = abs(y1 - y2)
      if dx = dy then do 
        if x1 <= x2 then do 
          lx = x1 
          hx = x2
        end
        else do 
          lx = x2
          hx = x1
        end
        if y1 <= y2 then do
          ly = y1 
          hy = y2
        end
        else do 
          ly = y2
          hy = y1
        end

        do x = lx to hx
          do y = ly to hy
            /* check if new coord is on diagonal too */
            if abs(x1 - x) = abs(y1 - y) then do
              loc.x.y = loc.x.y + 1

            end

          end
        end
      end
    end
  end
end

points = 0
do y = 0 to ymax
  do x = 0 to xmax
    if loc.x.y >= 2 then points = points + 1
  end
end

if DEBUG="1" then 
  say time('S') - begin
say "solution="points
