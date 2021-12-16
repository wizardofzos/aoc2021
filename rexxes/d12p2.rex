/* REXX for AoC*/

parse arg puzzleinput
DEBUG="0"
numeric digits(32)
begin = time('S')
/* remove the 0x0d :)*/
x = bpxwunix('tr -d "\r" < 'puzzleinput,,file.,se.)

/*    start A b c d end
start       X X      
A       X     X X    X
b       X   X     X  X
c           X
d             X
end         X X
 */

matrix. = ''
matrix.0 = 0

nodes = ''

/* moves.start = "A b"           */
/* moves.b     = "start A d end" */
do i = 1 to file.0
  parse var file.i f"-"t
  x = addnode(f)
  x = addnode(t) 
  x = addmatrix(t,f)
  x = addmatrix(f,t)
end

/*
do i = 1 to words(nodes)
  say "From "word(nodes,i)" we can get to"
  do j = 1 to matrix.i.0
    say " - "matrix.i.j
  end
end
 */

pc = 0

xx = dfs('start','end','',0)


solution = pc



say "solution="solution"@"time('S')-begin

exit

dfs: procedure expose nodes matrix. pc
  parse arg current,finish,visited,pcount
  
  if translate(current) /= current & isin(current,visited) = 0 then do
    visited = visited" "current
  end
  mi = nodenum(current)
  options = getopts(mi)
  do j = 1 to words(options)
    option = word(options,j)
    if option = finish then do
      pc = pc + 1
      pcount = pcount + 1
    end
    else do
      found = isin(option,visited)
      if found = 0 then do
          v2 = visited
          xxx = dfs(option, finish, v2,pcount)

      end
    end
  end
  return pcount
  
getopts: parse arg i 
  vals = ''
  do jj = 1 to matrix.i.0
    vals = vals" "matrix.i.jj
  end
  return vals

isin: parse arg n,h
  found = 0
  do jj = 1 to words(h)
    if word(h,jj) = n then do
      found = 1
      leave
    end
  end
  return found



addnode: parse arg n
  /* adds to nodes string only if not there 
  make sure to use the 'parse' keyword or you get UPPERCASE !*/
  found =0
  do wc = 1 to words(nodes)
    if word(nodes, wc) = n then do
      found = 1
      leave
    end
  end
  if found = 0 then do
    nodes = nodes" "n
    mi = words(nodes) 
    matrix.mi.0 =  0
    trace off
    return 0
  end
  return 4 /* not added */

addmatrix: parse arg t,f
  /* adds to matrix, f->t  
     returns 0 on success and 4 when its already in the tolist */
  mpf     = nodenum(f)     
  found = 0
  do tc = 1 to matrix.mpf.0
    if matrix.mpf.tc = t then do
      found = 1
      leave
    end
  end
  if found = 0 then do
    nt = matrix.mpf.0 + 1
    matrix.mpf.nt = t
    matrix.mpf.0 = nt
    return 0
  end
  else return 4

nodenum: parse arg n
  found = 0
  do wc = 1 to words(nodes)
    if word(nodes, wc) = n then do
      found = 1
      leave
    end
  end
  if found = 1 then return wc
  else return -1


pushit: parse arg item /* Pushes element on top of stack, returns stack depth */
  ns = stack.0 + 1
  stack.ns = item
  stack.0 = ns
  return ns

popit: parse arg item     /* Pops element from top of stack and returns it*/
  ns = stack.0
  r = stack.ns
  stack.0 = ns -1
  return r

checkit:            /* returns top item of  stack  */
  sc = stack.0
  return stack.sc





/* For some reason, don't end in non blank lines?
To prevent
BPXW0003I Improper text file
BPXW0000I Exec not found 
*/

