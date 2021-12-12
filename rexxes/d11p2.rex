/* REXX for AoC*/

parse arg puzzleinput
DEBUG="0"
numeric digits(32)
begin = time('S')
/* remove the 0x0d :)*/
x = bpxwunix('tr -d "\r" < 'puzzleinput,,file.,se.)

/* we deffo need a stack */
stack. = 0

illegals = ''

do i = 1 to file.0
  broken = 0
  do j = 1 to length(file.i)
    char = substr(file.i,j,1)
    if char = '(' | char = '{' | char = '[' | char = '<' then do
      ss = pushit(char)  /* we can always have another opener */
    end
    else do
      l = checkit()
      if (l='('&char=')')|(l='{'&char='}')|(l='['&char=']')|(l='<'&char='>') 
      then do
           /* thats ok. pop it */
           ss = popit()
      end
      else do
        illegals = illegals || char
        broken = 1
      end
    end
    if broken = 1 then leave
  end
end

solution=0
do j = 1 to length(illegals)
  c = substr(illegals,j,1)
  if c = ')' then p = 3
  if c = ']' then p = 57
  if c = '}' then p = 1197
  if c = '>' then p = 25137
  solution = solution + p 
end
say "solution="solution"@"time('S')-begin

exit

pushit: arg item
  /* Pushes an element on top of our (global) stack, returns stack depth */
  ns = stack.0 + 1
  stack.ns = item
  stack.0 = ns
  return ns

popit: arg item
  /* pops the top item from our (global) stack and returns it*/
  ns = stack.0
  stack.ns = 0
  r = stack.ns
  stack.0 = ns -1
  return r

checkit: 
  /* returns top item of (global) stack but does not remove it */
  sc = stack.0
  return stack.sc

  

