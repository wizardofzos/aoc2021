/* REXX */

parse arg puzzleinput
DEBUG="0"
numeric digits(32)
begin = time('S')
/* remove the 0x0d :)*/
x = bpxwunix('tr -d "\r" < 'puzzleinput,,file.,se.)

/* patterns to digits */
d.0 = 'abcefg'                /* len = 6   */
d.1 = 'cf'                    /* len = 2 ! */
d.2 = 'acdeg'                 /* len = 5   */ 
d.3 = 'acdfg'                 /* len = 5   */
d.4 = 'bcdf'                  /* len = 4 ! */
d.5 = 'abdfg'                 /* len = 5   */
d.6 = 'abdefg'                /* len = 6   */
d.7 = 'acf'                   /* len = 3 ! */
d.8 = 'abcdefg'               /* len = 7 ! */
d.9 = 'abcdfg'                /* len = 6   */

perms. = 0
call permSets 6,6
say perms.0 "permutations loaded"



/* First parse the input into 10x patterns | 4x outputs */
sigsum = 0
do i = 1 to file.0
  /* keep track of patterns & output */
  patt. = ''
  out.  = ''
  patt.0 = 0
  out.0  = 0

  state = 'patterns'
  p = words(file.i)
  do pi = 1 to p
    str = word(file.i,pi)
    if str = '|' then do
      state = 'outputs'
      iterate
    end
    /* also str can be in multiple order (ab or ba) but means same */
    /* so sort it */
    /* oh my... sorting a string in rexx is weird :)  */
    newstr = ''
    if pos('a',str) > 0 then newstr = newstr"a"
    if pos('b',str) > 0 then newstr = newstr"b"
    if pos('c',str) > 0 then newstr = newstr"c"
    if pos('d',str) > 0 then newstr = newstr"d"
    if pos('e',str) > 0 then newstr = newstr"e"
    if pos('f',str) > 0 then newstr = newstr"f"
    if pos('g',str) > 0 then newstr = newstr"g"
    str = newstr
    if state = 'patterns' then do
      np = patt.0 + 1            /* this is the REXX way of */
      patt.np = str              /* saying patt.append(str) */
      patt.0 = np                /* I know right...         */
      say patt.0
    end
    if state = 'outputs' then do
      no = out.0 + 1
      out.no = str
      out.0 = no
    end
  end
  /* diff approach :) BRUTE IT ... */
  /* the signals are mixed up, we just don't know why...
  so create all possible perms. then see which one is valid */
  say "Line "i" parsed"
  /* check the permutations to see what the valid one is */
  do xx = 1 to perms.0
    say perm2str(perms.xx)
  end

  /* get them values out */
  dstr = ''
  do vv = 1 to out.0
    do ll = 0 to 9
      if found.ll = out.vv then dstr = dstr || ll
    end
  end
  say dstr
  sigsum = sigsum + dstr
  
end

say "solution="sigsum"@"time('S')-begin

exit

potentialDigits: arg s
  l = length(s)
  p = ''
  do c = 0 to 9
    if length(d.c) = l then
      p = p' 'c
  end
  return p

printKnown:
  do kk = 0 to 9
    say found.kk "-->"kk
  end
  return 0 

innit: arg n, h
  have = 0
  do pp = 1 to length(n)
    if pos(substr(n,pp,1),h) > 0 then have = have + 1
  end
  if have = length(n) then return 1
  return 0


/* thank you rosetta stone */
p:        return word( arg(1), 1)           

permSets: procedure expose perms. ; parse arg x,y,between,uSyms 
          @.=;       sep=                       
          @abc  = 'abcdefghijklmnopqrstuvwxyz';     @abcU=  @abc;         
          upper @abcU
          @abcS = @abcU || @abc;                   
          @0abcS= 123456789  ||  @abcS
 
            do k=1  for x                        
            _= p(word(uSyms, k)  p(substr(@0abcS, k, 1) k) )    
            if length(_)\==1  then sep= '_'      
            $.k= _                              
            end   /*k*/
 
          if between==''  then between= sep      
          call .permSet 1                       
          return                              
.permSet: procedure expose perms. $. @. between x y;       parse arg ?
          if ?>y  then do;  _= @.1;      do j=2  for y-1
                                         _= _  ||  between  ||  @.j
                                         end   /*j*/
                            newp = perms.0 + 1;
                            perms.newp = _;
                            perms.0 = newp;
                       end
                  else do q=1  for x            
                         do k=1 for ?-1;  if @.k==$.q  then iterate q
                         end   /*k*/
                       @.?= $.q;         call .permSet ?+1
                       end     /*q*/
          return

perm2str: arg pp
  str = ''
  do ss = 1 to length(pp)
    if substr(p,ss,1) = 0 then str = str"a"
    if substr(p,ss,1) = 1 then str = str"b"
    if substr(p,ss,1) = 2 then str = str"c"
    if substr(p,ss,1) = 3 then str = str"d"
    if substr(p,ss,1) = 4 then str = str"e"
    if substr(p,ss,1) = 5 then str = str"f"
    if substr(p,ss,1) = 6 then str = str"g"

  end
  return str


