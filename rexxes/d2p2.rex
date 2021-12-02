/* REXX */

parse arg puzzleinput

/* remove the 0x0d :)*/
x = bpxwunix('tr -d "\r" < 'puzzleinput,,file.,se.)

# Forgot that Eric likes the BIG NUMNERS
numeric digits(12)

x = 0
y = 0
aim = 0

do i = 1 to file.0

  /* Read all file */
  parse var file.i direction amount
  select
    when direction = 'forward' then do
      x = x + amount
      y = y + (aim * amount)
    end
    when direction = 'down' then aim = aim + amount
    when direction = 'up' then aim = aim - amount
    otherwise say "Bad stuff!"
  end
end


solution = x * y
say "solution="solution
