/* REXX */

rootpath = "/prj/repos/aoc2021"  
inputpath = rootpath"/input/" 
infile = inputpath"example.ebcdic"

x = bpxwunix('cat 'infile,,file.,se.)






/* This is how we report to the API code */

if strip(file.1) == "EXAMPLE INPUT FILE"
then solution = 9001
else solution = "B0rked"
say "solution="solution 

