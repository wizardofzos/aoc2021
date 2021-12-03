/* REXX */

parse arg puzzleinput

/* remove the 0x0d :)*/
x = bpxwunix('tr -d "\r" < 'puzzleinput,,file.,se.)



bits = length(file.1)
/* As we're messing with this stem, save it for the 2nd run for co2 */
fileback. = 0
do b = 0 to file.0
  fileback.b = file.b
end

gamma = ''
eps = ''

/* Get the O2 rating */
do j = 1 to bits
  v = mostCommonO2(j) /* our most common bit accoring to reading spec */
  /* get the data backupped as we need to mess with the file. stem */
  backup. = 0
  do b = 0 to file.0
    backup.b = file.b
  end
  /* then drop the stem */ 
  drop file.
  /* and copy what we still want */
  file. = 0
  do b = 1 to backup.0
    if substr(backup.b, j, 1) = v then do
      nf = file.0 + 1
      file.nf = backup.b
      file.0 = nf
    end
  end

  /* one entry left? We're done! No need to stay in the loop */
  if file.0 = 1 then do
    leave
  end
 end

/* Do our magical b2d function haggle */
o2 = x2d(b2x(file.1))

/* Get the CO2 reating, restore the messed up file. first */
file. = 0
do b = 0 to fileback.0
  file.b = fileback.b
end

/* then basically the same as for o2, but other 'common' function */
do j = 1 to bits
  v = leastCommonCO2(j)
  backup. = 0
  do b = 0 to file.0
    backup.b = file.b
  end
  drop file.
  file. = 0
  do b = 1 to backup.0
    if substr(backup.b, j, 1) = v then do
      nf = file.0 + 1
      file.nf = backup.b
      file.0 = nf
    end
  end
  if file.0 = 1 then do
    leave
  end
 end

co2 = x2d(b2x(file.1))

say "solution=" o2 * co2









exit

/* Think these two function could be one with an extra arg, but hey... */
leastCommonCO2:
  parse arg bit 
  ones = 0
  zeroes = 0
  do i = 1 to file.0
    val = substr(file.i, bit, 1)
    if val = '1' then ones = ones + 1
    else zeroes = zeroes + 1
  end
  if zeroes <= ones then return '0'
  else return '1'

mostCommonO2:
  parse arg bit 
  ones = 0
  zeroes = 0
  do i = 1 to file.0
    val = substr(file.i, bit, 1)
    if val = '1' then ones = ones + 1
    else zeroes = zeroes + 1
  end
  if ones >= zeroes then return '1'
  else return '0'

