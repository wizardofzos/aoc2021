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

/* First parse the input into 10x patterns | 4x outputs */
sigsum = 0
do i = 1 to file.0
  /* keep track of patterns & output */
  patt. = ''
  out.  = ''
  patt.0 = 0
  out.0  = 0
  /* keep track of what we've found */
  found. = ''
  do ff = 0 to 9
    found.ff = ''
  end
  
  foundcount = 0
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
    end
    if state = 'outputs' then do
      no = out.0 + 1
      out.no = str
      out.0 = no
    end
  

    /* now we go and see what str gives us */
    possibles = potentialDigits(str) 
    if words(possibles) = 1 then do
      /* we deffo know this is that one */
      hit = strip(word(possibles,1))
      lenhit = length(str)
      foundcount = foundcount + 1
      select
        when lenhit = 2 then found.1 = str
        when lenhit = 4 then found.4 = str
        when lenhit = 3 then found.7 = str
        when lenhit = 7 then found.8 = str
        otherwise nop
      end
    end
    else do
      do kk = 1 to words(possibles)
        h = strip(word(possibles,kk))
        lh = length(str)
        select
          when lh = 6 then do 
            if wordpos(str,found.0) = 0 then 
              found.0 = found.0' 'str
            if wordpos(str,found.6) = 0 then 
              found.6 = found.6' 'str
            if wordpos(str,found.9) = 0 then 
              found.9 = found.9' 'str
          end
          when lh = 5 then do 
            if wordpos(str,found.2) = 0 then 
              found.2 = found.2' 'str
            if wordpos(str,found.3) = 0 then 
              found.3 = found.3' 'str
            if wordpos(str,found.5) = 0 then 
              found.5 = found.5' 'str
          end          
          otherwise nop
        end
      end  
    end
  end

  /* print what we know */
  say "Deffo got "foundcount  
  xx =  printKnown()
  /* do stoopid loop */
  do while foundcount /= 10
    /* The letters we found in 1 have to be in 3 */
    reduced3 = ''
    do check = 1 to words(found.3)
      if innit(found.1,word(found.3, check)) > 0 then do
        reduced3 = strip(reduced3' 'word(found.3, check))
      end
      
    end
    found.3 = reduced3
    say "reduced 3??"
    xx = printKnown()

    /* The letters we found in 1 have to be in 9 */
    reduced9 = ''
    do check = 1 to words(found.9)
      if innit(found.1,word(found.9, check)) > 0 then do
        reduced9 = strip(reduced9' 'word(found.9, check))
      end
    end
    found.9 = reduced9

    /* The letters we found in 7 have to be in 9 */
    reduced9 = ''
    do check = 1 to words(found.9)
      if innit(found.7,word(found.9, check)) > 0 then do
        reduced9 = strip(reduced9' 'word(found.9, check))
      end
    end
    found.9 = reduced9
    say "Reduction basic done"
    xx =  printKnown()
  
    /* now let's see if we've known that are also in potentials */
    do kk = 0 to 9
      if words(found.kk) = 1 then do
        /* this is a known, remove from others */
        say "Deffo now what "kk" is("found.kk")"
        known = word(found.kk,1)
        do jj = 0 to 9
          if words(found.jj) > 1 then do
            /* this one has options */
            newfound = ''
            do ll = 1 to words(found.jj)
              if word(found.jj,ll) /= known then do
                newfound = newfound' 'word(found.jj,ll)
              end
            end
            newfound = strip(newfound)
            found.jj = newfound
          end
        end
      end
    end
    say "KNown stripped from optionals"
    xx =  printKnown()
    /* super weird.. whatever is NOT in zero, HAS to be in 8 */
    reduced0 = ''
    do check = 1 to words(found.0)
      checkword = word(found.0, check)
      say "Checking if "checkword" can be 0 based on value of 8"
      if pos('a',checkword) = 0 then gofor='a'
      if pos('b',checkword) = 0 then gofor='b'
      if pos('c',checkword) = 0 then gofor='c'
      if pos('d',checkword) = 0 then gofor='d'
      if pos('e',checkword) = 0 then gofor='e'
      if pos('f',checkword) = 0 then gofor='f'
      if pos('g',checkword) = 0 then gofor='g'
      say "Character Not in 0 => "gofor" check with 8"
      if pos(gofor, word(found.8,1)) > 0 then do
        say ".. it's in 8 so could be "checkword
        reduced0 = strip(reduced0' 'checkword)
      end
    end
    found.0 = reduced0

    /* everything in the 6 must be in the 5 */
    if words(found.6) = 1 then do
      reduced5 = ''
      do check = 1 to words(found.5)
        checkword = word(found.5, check)
        say "!!Checking if "checkword" can be a 5 based on single 6"
        matched = 0
        do c6 = 1 to length(word(found.6,1))
          if pos(substr(found.6,c6,1),checkword) > 0 then do
            matched = matched + 1
          end
        end
        if matched = length(checkword) then do
          say checkword "... it can be a 5"
          reduced5 = strip(reduced5' 'checkword)
        end
      end
      found.5 = reduced5
    end
    

    if words(found.3) = 1 then do
      reduced0 = ''
      do check = 1 to words(found.0)
        checkword = word(found.0, check)
        say "Checking if "checkword" can be 0 based on value of 3"
        if pos('a',checkword) = 0 then gofor='a'
        if pos('b',checkword) = 0 then gofor='b'
        if pos('c',checkword) = 0 then gofor='c'
        if pos('d',checkword) = 0 then gofor='d'
        if pos('e',checkword) = 0 then gofor='e'
        if pos('f',checkword) = 0 then gofor='f'
        if pos('g',checkword) = 0 then gofor='g'
        say "Character Not in 0 => "gofor" check with 3"
        if pos(gofor, word(found.3,1)) > 0 then do
          say ".. it's in 3 so could be "checkword
          reduced0 = strip(reduced0' 'checkword)
        end
      end
      found.0 = reduced0
    end

    

    /* more weirdness on the 6 */
    

    /* we need a trick with 6 based on?*/
     /* whatever is NOT in 6, HAS has to be in the 1 IF 1 has only 1 */
    if words(found.1) = 1 then do
      reduced6 = ''
      do check = 1 to words(found.6)
        checkword = word(found.6, check)
        say "Checking if "checkword" can be 6"
        if pos('a',checkword) = 0 then gofor='a'
        if pos('b',checkword) = 0 then gofor='b'
        if pos('c',checkword) = 0 then gofor='c'
        if pos('d',checkword) = 0 then gofor='d'
        if pos('e',checkword) = 0 then gofor='e'
        if pos('f',checkword) = 0 then gofor='f'
        if pos('g',checkword) = 0 then gofor='g'
        say "Not in 6 => "gofor" check with value of 1 "found.1
        if pos(gofor, word(found.1,1)) > 0 then do
          say "... yes can be"
          reduced6 = strip(reduced6' 'word(found.6,check))
        end
        
      end
      found.6 = reduced6
    end  
    /* see what we have now */
    xx =  printKnown()
    newfounds = 0
    do ccc = 0 to 9
      if words(found.ccc) = 1 then
        newfounds = newfounds + 1
    end
    say "New FOUNDCOUNT -------------> "newfounds
    /* shorcut : do we know enough to solve?*/
    knowenough = 0
    do vv = 1 to out.0
      do jj = 0 to 9
        if found.jj = out.vv then knowenough=knowenough+1
      end
    end
    say "I've got "knowenough"/"out.0
    
    
    
    if knowenough = out.0 then foundcount = 10
    else foundcount = newfounds
  end
  say "**************** Line "i" parsed*********************************"
  say "**************** Line "i" parsed*********************************"
  say "**************** Line "i" parsed*********************************"
  say "**************** Line "i" parsed*********************************"
  say "**************** Line "i" parsed*********************************"
  say "**************** Line "i" parsed*********************************"
  say "**************** Line "i" parsed*********************************"
  say "**************** Line "i" parsed*********************************"
  say "**************** Line "i" parsed*********************************"
  say "**************** Line "i" parsed*********************************"
  say "**************** Line "i" parsed*********************************"
  say "**************** Line "i" parsed*********************************"
  say "**************** Line "i" parsed*********************************"
  say "**************** Line "i" parsed*********************************"
  say "**************** Line "i" parsed*********************************"
  say "**************** Line "i" parsed*********************************"
  say "**************** Line "i" parsed*********************************"
  say "**************** Line "i" parsed*********************************"
  say "**************** Line "i" parsed*********************************"
  say "**************** Line "i" parsed*********************************"
  say "**************** Line "i" parsed*********************************"
  say "**************** Line "i" parsed*********************************"
  say "**************** Line "i" parsed*********************************"
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
  say "poetentials "p
  return p

printKnown:
  do kk = 0 to 9
    say found.kk "-->"kk
    if words(found.kk) = 0 then do
      say "EEEJ WENT TO NONE????????? *****************"
      exit
    end
  end
  
  return 0 

innit: arg n, h
  have = 0
  do pp = 1 to length(n)
    if pos(substr(n,pp,1),h) > 0 then have = have + 1
  end
  if have = length(n) then return 1
  return 0


