/* REXX */

parse arg puzzleinput
DEBUG="0"
numeric digits(32)
begin = time('S')
/* remove the 0x0d :)*/
x = bpxwunix('tr -d "\r" < 'puzzleinput,,file.,se.)

/* patterns to digits */
d.0 = 'abcefg'
d.1 = 'cf'
d.2 = 'acdeg'
d.3 = 'acdfg'
d.4 = 'bcdf'
d.5 = 'abdfg'
d.6 = 'abdefg'
d.7 = 'acf'
d.8 = 'abcdefg'
d.9 = 'abcdfg'

/* First parse the input into 10x patterns | 4x outputs */
easyOnes = 0
do i = 1 to file.0
  state = 'patterns'
  p = words(file.i)
  do pi = 1 to p
    str = word(file.i,pi)
    if str = '|' then do
      state = 'outputs'
      iterate
    end
    if state = 'patterns' then do
      iterate /* only check outputs for part one */
    end
    if state = 'outputs' then do
      possibles = potentialDigits(str) 
      if words(possibles) = 1 then do
        easyOnes = easyOnes + 1
      end
    end
  end

end

say "solution="easyOnes"@"time('S')-begin

exit

potentialDigits: arg s
  l = length(s)
  p = ''
  do c = 0 to 9
    if length(d.c) = l then
      p = p' 'c
  end
  return p
