/* REXX */

rootpath = "/prj/repos/aoc2021"  
inputpath = rootpath"/input/" 
infile = inputpath"2020d1p1.ebcdic"

x = bpxwunix('cat 'infile,,file.,se.)






do i = 1 to file.0
  /* Read all file */
  if file.i > 2020 then iterate        /* Skip this */
  do j = 1 to file.0
    if j = i then iterate                 /* Skip this */
    if file.j > 2020 then iterate      /* And skip this */
    if file.i + file.j = 2020 then do
      
      say "solution="file.i * file.j
      
      /* Comment below to see all solutions */
      exit

    end
  end
end
