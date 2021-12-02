/* REXX */

parse arg puzzleinput

/* remove the 0x0d :)*/
x = bpxwunix('tr -d "\r" < 'puzzleinput,,file.,se.)


x = 0
y = 0

do i = 1 to file.0

  /* Read all file */
  parse var file.i direction amount
  select
    when direction = 'forward' then x = x + amount
    when direction = 'down' then y = y + amount
    when direction = 'up' then y = y - amount
    otherwise say "Bad stuff!"
  end
end


solution = x * y
say "solution="solution
