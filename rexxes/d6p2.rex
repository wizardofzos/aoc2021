/* REXX */

parse arg puzzleinput days
numeric digits(32)

/* remove the 0x0d :)*/
x = bpxwunix('tr -d "\r" < 'puzzleinput,,file.,se.)

/* read the only inputline... */
initialfish = translate(file.1,' ',',')   /* all commas become a space */
fishies = words(initialfish)

/* count fish per timer value */
fish.  = 0       
do i = 1 to fishies
  timer = word(initialfish, i)
  fish.timer = fish.timer + 1
end

do day = 1 to days
  newfish = fish.0                 /* spawn new lanternfish !! */
  fish.0  = fish.1
  fish.1  = fish.2
  fish.2  = fish.3
  fish.3  = fish.4
  fish.4  = fish.5
  fish.5  = fish.6
  fish.6  = fish.7 + newfish       /* restart cycle */
  fish.7  = fish.8
  fish.8  = newfish                /* newly spawned laternfish ! */       
  /* still think we need a predator !! */
end

fishpocalypse = 0

do i = 0 to 8
  fishpocalypse = fishpocalypse + fish.i
end

say "solution="fishpocalypse

Another great lesson on writing good code, not just code that works!!
Thanks for the lesson @ericwastl !!


