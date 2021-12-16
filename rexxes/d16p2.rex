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

/* all parsed in our matrix thing again. now plot cheapest route from
1,1 to xmax,ymax. Dijkstra comes to mind :) */

target = xmax","ymax
allpaths = dfs('1,1',target,xmax,ymax,'','')
say allpaths
say "solution="allpaths"@"time('S')-begin



exit

dfs: procedure 
  parse arg curr,finish,xm,ym,visited,paths
  /* what are next hops from x,y? left, up , right, down
  */
  parse var curr x1","y1
  parse var finish tx","ty

  options = ""
  xl = x1 - 1
  xr = x1 + 1
  yu = y1 - 1
  yd = y1 + 1

  if xl > 0 & tx - xl < tx - x1 then 
    options = options" "xl","y1
  if xr <= xm & tx - xr < tx - x1 then 
    options = options" "x1+1","y1
  if yu > 0 & ty - yu < tx -1 then
    options = options" "x1","yu
  if yd <= ym & ty - yd < ty then 
    options = options" "x1","yd
  
  
 
  if wordpos(curr,visited) = 0 then 
    visited = visited" "curr
 
 
  do j = 1 to words(options)
    option = word(options, j)
    if option = finish then do
      newpath = visited" "option
      say "found a path=>"newpath
      /* but can't be in paths */
      nc = translate(paths"|"newpath,'*',' ')
      pc = translate(paths,'*','|')
      say "Current paths->"paths"("pc")"
      say "newpath->"newpath"("nc")"
      say "************ ADDING PATHH ***************"
      paths = paths"|"newpath
      
    end
    else do
      if wordpos(word(options,j), visited) = 0 then do
        say word(options,j)" not in "visited
        v2 = visited
        paths = paths" "dfs(word(options, j), finish, xm, ym, v2,paths)
      end
    end
  end
  return paths

exit



