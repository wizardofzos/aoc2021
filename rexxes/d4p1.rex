/* REXX */

parse arg puzzleinput

DEBUG = "0"

/* remove the 0x0d :)*/
x = bpxwunix('tr -d "\r" < 'puzzleinput,,file.,se.)

allnumbers. = 0
board. = 0

/*
Per board we get:
line => row (and column): use for see if we have a win
numerbers => calulation of points...
 */
/* Parse the pulled numbers */
allnums = file.1
rest = 'offwego'

do while rest /= ''
  parse var allnums n","rest
  nn = allnumbers.0 + 1
  allnumbers.nn = n
  allnumbers.0 = nn
  allnums = rest
end


/* then a blank line and the boards */


do i = 2 to file.0
  if file.i = '' then do
    nb = board.0 + 1
    board.0 = nb
    board.nb.line.0 = 0
    board.nb.number.0 = 0
    
  end
  else do

    /* A (new) row of a board */
    nl = board.nb.line.0 + 1
    do ii = 1 to words(file.i)
      /* add to numbers for board */
      nn = board.nb.number.0 + 1
      board.nb.number.nn = word(file.i, ii)
      board.nb.number.0 = nn
      /* board.x.line.l.i = digit i on line l for board x */
      board.nb.line.nl.ii = word(file.i, ii)
    end
    board.nb.line.nl.0 = words(file.i)
    board.nb.line.0 = nl
  end
end

/* for each board we now have the rows as win-lines */
/* time to create the cols win-lines */
do b = 1 to board.0
  do p = 1 to board.1.line.1.0   /* so we get the width */
    /* for each entry in the line (thats the width) 
    we need a new col-line */
    newLine = colLine(p, b)
    nl = board.b.line.0 + 1
    do c = 1 to words(newLine)
      board.b.line.nl.c = word(newLine, c)
    end
    board.b.line.nl.0 = words(newLine)
    board.b.line.0 = nl
  end
end


if DEBUG = "1" then do
    say "I've read "board.0" boards"
    say "Check. Board 3, line(row3) 3, digits"
    do jj = 1 to board.3.line.3.0
    say board.3.line.3.jj
    end
    say "Check. Board 3, line(col1) 6, digits"
    do jj = 1 to board.3.line.6.0
    say board.3.line.6.jj
    end
    say "Board 2, number 8 (13) ==>" board.2.number.8
end

/* run the game */
do gl = 1 to allnumbers.0
  justCalled = allnumbers.gl
  winner = 0
  /* Now check all boards.... and see if we've a winner... */
  do b = 1 to board.0
    do l = 1 to 10
        w = checkLine(b, l, gl)
        if w = 5 then do
        /* winner winner chicken dinner */
        winner = b
        /* no need to check other lines ? */
        leave
        end
    end
    if winner > 0 then leave  /* no need to check other boards */
  end
  if winner > 0 then do/* we have a winner! */
    
    score = score(winner, justCalled, turn)
    if DEBUG = "1" then do
        say "Board " winner" wins!"
        say "Score = "score
    end
    say "solution="score
    leave /* stop announcing numbers! */
  end
end

exit

checkLine: arg bnum, l, turn
  linescore = 0
  if DEBUG = "1" then do
    rr = ''
    say "Check for board "bnum" line "l" turn"turn
    do kk = 1 to board.bnum.line.l.0
        rr = rr" "board.bnum.line.l.kk
    end
    say rr
  end
  do index = 1 to board.bnum.line.l.0 
    point = calledNumber(board.bnum.line.l.index, turn)
    if DEBUG = "1" then
      say "    check "index"("board.bnum.line.l.index") -->"point
    linescore = linescore + point
  end
  if DEBUG = "1" then
    say "Board "bnum" line "l" points:"linescore
  return linescore

calledNumber: arg cnumber, turn
  do i = 1 to turn
      if cnumber = allnumbers.i 
    then return 1
  end
  return 0

colLine: arg c, b
  /* col c for board b */
  colvals = ''
  do k = 1 to 5
    colvals = colvals" "board.b.line.k.c
  end
  return strip(colvals)


score: arg b, c, t
  /* Get all 'unmarked' numbers from board and sum them */
  dasum = 0
  do bb = 1 to board.b.number.0
    called = 0
    do tt = 1 to t
      if board.b.number.bb = allnumbers.tt then do
        called = 1
        leave    /* number was called, no sum */
      end
    end
    if called = 0 then dasum = dasum + board.b.number.bb
  end
  return dasum * c
