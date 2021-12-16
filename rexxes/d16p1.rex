/* REXX for AoC*/

parse arg puzzleinput
DEBUG="0"
numeric digits(32)
begin = time('S')
/* remove the 0x0d :)*/
x = bpxwunix('tr -d "\r" < 'puzzleinput,,file.,se.)

/* Every packet begins with a standard header: 
      the first three bits encode the packet version, 
and the next three bits encode the packet type ID. 
These two values are numbers; all numbers encoded in any packet are represented 
as binary with the most significant bit first. 
For example, a version encoded as the binary sequence 100 represents the 
number 4. */

totver = 0
do i = 1 to file.0
  bitstring = ''
  do j = 1 to length(file.i)
    hexval = substr(file.i,j,1)
    bitstring = bitstring || x2b(hexval)
  end
  say bitstring
  pv =  packet_version(bitstring)
  pt =  packet_type(bitstring)
  say "packetVersion:"pv
  totver = totver + 1
  say "packetType:"pt
  if pt /= 4 then do
    /* any packet with a type ID other than 4 represent an operator that 
    performs some calculation on one or more sub-packets contained within 
    operator packet contains one or more packets one of two modes
    length type ID is 0, then the next 15 bits are a number that represents 
    the total length in bits of the sub-packets
    length type ID is 1, then the next 11 bits are a number that represents 
    the number of sub-packets immediately contained */
    ltid = length_type_id(bitstring)
    say "Length TypeID: "ltid
    if ltid = '1' then do
      subpacks = subpackets(bitstring)
      say "need to parse "subpacks" subpackets"
      psl = 0
      sok = 0
      do while sok < subpacks
        sps = substr(bitstring,19+psl)
        spv = packet_version(sps)
        totver = totver + spv
        spt = packet_type(sps)
        say "SubVersion ="spv
        say "SubType ="spt
        if spt = 4 then do
          /* literal value x groups of 5 bits */
          litval = substr(sps,7)
          val = literal_value(litval) 
          litlen = literal_length(litval)
          say "Lit len = "litlen
          say "Lit val = "val
          psl = psl + 6 + litlen
          sok = sok + 1      
        end  
      end
    end
    else do
      sublength = sublength(bitstring)
      say "need to parse "sublength "bits of subpackets"
      psl = 0 /* parsed sub length */
      do while psl < sublength
        sps = substr(bitstring,23+psl)
        spv = packet_version(sps)
        totver = totver + spv
        spt = packet_type(sps)
        say "SubVersion ="spv
        say "SubType ="spt
        if spt = 4 then do
          /* literal value x groups of 5 bits */
          litval = substr(sps,7)
          val = literal_value(litval) 
          litlen = literal_length(litval)
          say "Lit len = "litlen
          say "Lit val = "val
          psl = psl + 6 + litlen
        end
      end
    end
  end

end


say "solution="totver"@"time('S')-begin



exit

packet_version: parse arg bits
  /* Every packet begins with a standard header: 
  the first three bits encode the packet version */
  pv = substr(bits, 1, 3)
  return x2d(b2x(pv))

packet_type: parse arg bit
  pt = substr(bits, 4, 3)
  return x2d(b2x(pt))

length_type_id: parse arg bits
  /* Every other type of packet (any packet with a type ID other than 4) 
  represent an operator ... packet contains one or more packets ...
  one of two modes indicated by the bit immediately after the packet header; 
  this is called the length type ID:*/
  lt = substr(bits, 7, 1)
  return lt

subpackets: parse arg bits
  /* length type ID is 1, then the next 11 bits are a number that represents 
    the number of sub-packets immediately contained */
  n11b = substr(bits, 8, 11)
  return x2d(b2x(n11b))

sublength: parse arg bits
  /* length type ID is 0, then the next 15 bits are a number that represents 
    the total length in bits of the sub-packets */
  n15b = substr(bits, 8, 15)
  return x2d(b2x(n15b))

literal_length: parse arg bits
  /* To do this, the binary number is padded with leading zeroes until its 
  length is a multiple of four bits, and then it is broken into groups of 
  four bits. Each group is prefixed by a 1 bit except the last group, which 
  is prefixed by a 0 bit */
  curr = 1
  groups = 1
  say "len, "bits
  say substr(bits, curr, 1)
  do while substr(bits, curr, 1) /= 0 
    curr = curr + 5
    groups = groups + 1
  end
  l = groups * 5
  return l

literal_value: parse arg bits
  /* To do this, the binary number is padded with leading zeroes until its 
  length is a multiple of four bits, and then it is broken into groups of 
  four bits. Each group is prefixed by a 1 bit except the last group, which 
  is prefixed by a 0 bit */
  curr = 1
  bv = substr(bits,2,4)
  say "len, "bits
  say substr(bits, curr, 1)
  do while substr(bits, curr, 1) /= 0 
    curr = curr + 5
    bv = bv || substr(bits,curr+1,4) 
  end
  return x2d(b2x(bv))
     

