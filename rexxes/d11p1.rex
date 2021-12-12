/* REXX for AoC*/

parse arg puzzleinput
DEBUG="0"
numeric digits(32)
begin = time('S')
/* remove the 0x0d :)*/
x = bpxwunix('tr -d "\r" < 'puzzleinput,,file.,se.)

pos. = -1 /* our edge :) */

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

/* Now we have them all in pos.x.y. */
flashers = ''            /* yes really ;) */
do step = 1 to 10
  /* First: All +1 */
  do x = 1 to xmax
    do y = 1 to ymax
      /* move l2r & u2d */
      pos.x.y = pos.x.y + 1
    end
  end
  /* Then, flash and do some recursive shit */
  do x = 1 to xmax
    do y = 1 to ymax
      /* move l2r & u2d */
      if pos.x.y >= 8 then do
        /* Flash the dumbo :) */
        if pos(x","y, flashers) = 0 then do
          flashers = flashers" "x","y
        end
      end
    end
  end

end



say "solution="solution"@"time('S')-begin

exit



