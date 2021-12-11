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
scores. = 0
okfile. = 0

do i = 1 to file.0
  broken = 0
  drop stack.
  stack. = 0
  adds = '' 
  do j = 1 to length(file.i)
    char = substr(file.i,j,1)
    if char = '(' | char = '{' | char = '[' | char = '<' then do
      ss = pushit(char)  /* we can always have another opener */
    end
    else do
      l = checkit()
      if (l='('&char=')')|(l='{'&char='}')|(l='['&char=']')|(l='<'&char='>') 
      then do
           /* thats ok. pop it, we cheat here...no add the clsoing char */
           ss = popit()
      end
      else do
        illegals = illegals || char
        broken = 1
      end
    end
    if broken = 1 then leave

  end
  if broken = 0 then do
    /* this is a correct line */
    if stack.0 > 0 then do
      /* stack empty? if not, push it out  */
      do while stack.0 > 0
        adds = adds || popit() /* we cheat&use openers as closers */
      end
      
      /* Calculate the score */
      solution=0
      do j = 1 to length(adds)
        c = substr(adds,j,1) /* yes we cheat :) */
        solution = solution * 5
        if c = '(' then p = 1
        if c = '[' then p = 2
        if c = '{' then p = 3
        if c = '<' then p = 4
        solution = solution + p 
      end
      /* And add to scores list. This is 'scores.append(solution)' lol */      
      ns = scores.0 + 1
      scores.ns = solution
      scores.0 = ns
    end
  end
end

/* Sort the them, get the 3rd element */
stemaswords = ''
do j = 1 to scores.0
  stemaswords = stemaswords" "scores.j
end
cmd = 'echo "'stemaswords'" | tr " " "\n" | sort -n | tr "\n" " ";echo'
/* say cmd */
x = bpxwunix(cmd,,sorted.,se.)
if x = 0 then do
  /* now I have all scores sorted in sorted.1 :) Man I love USS/BPX :)
  it's a whopping amount of words(sorted.1)
  my werewolf math teacher would growl in anger, but this is how I then get 
  the middle one (median anyone?) as https://adventofcode.com/2021/day/10#part2 
  tells us to do :) */
  median = (words(sorted.1) + 1) / 2  
end
else 
  median = '*CHEAP MEDIAN FAILED*'

solution = word(sorted.1,median)
say "solution="solution"@"time('S')-begin

exit

pushit: arg item   /* Pushes element on top of stack, returns stack depth */
  ns = stack.0 + 1
  stack.ns = item
  stack.0 = ns
  return ns

popit: arg item     /* Pops element from top of stack and returns it*/
  ns = stack.0
  r = stack.ns
  stack.0 = ns -1
  return r

checkit:            /* returns top item of  stack  */
  sc = stack.0
  return stack.sc

  

