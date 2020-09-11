$latex      = 'platex -synctex=1 -halt-on-error %O %S';
$bibtex     = 'pbibtex %O %B';
$dvipdf     = 'dvipdfmx %O -o %D %S';
$makeindex  = 'mendex %O -o %D %S';
$max_repeat = 5;
$pdf_mode   = 3; #use dvipdf
