/* REXX */

parse arg puzzleinput
DEBUG="0"
numeric digits(32)

/* remove the 0x0d :)*/
x = bpxwunix('tr -d "\r" < 'puzzleinput,,file.,se.)

/* read the only inputline... */
initialfish = translate(file.1,' ',',')   /* all commas become a space */
fishies = words(initialfish)
school. = 0 /* init at nothing */
do f = 1 to fishies
  school.f = word(initialfish, f)
end
school.0 = fishies


do days = 1 to 80
  newfish = 0
  do i = 1 to school.0
    if school.i = 0 then do                         
      /* when timer hits zero, reset to 6 and add a new fish... */
      school.i = 6
      newfish = newfish + 1
    end
    else do
      /* just one less timer */
      school.i = school.i-1
    end 
  end
  /* add the new fishies at the end... */
  do nf = 1 to newfish
      nfc = school.0 + 1
      school.nfc = 8
      school.0 = nfc
  end

say "solution="school.0
