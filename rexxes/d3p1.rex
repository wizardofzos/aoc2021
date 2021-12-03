/* REXX */

parse arg puzzleinput

/* remove the 0x0d :)*/
x = bpxwunix('tr -d "\r" < 'puzzleinput,,file.,se.)

bits = length(file.1)
gamma = ''
eps = ''

do j = 1 to bits
  v = mostCommon(j)
  gamma = gamma || v
  eps = eps || bitxor(v, '1'x)
end

gamma = x2d(b2x(gamma))
epsilon = x2d(b2x(eps))

say "solution="gamma *  epsilon

exit

mostCommon:
  parse arg bit 
  ones = 0
  zeroes = 0
  
  do i = 1 to file.0
    val = substr(file.i, bit, 1)
    if val = '1' then ones = ones + 1
    else zeroes = zeroes + 1
  end

  if ones > zeroes then return '1'
  else return '0'


