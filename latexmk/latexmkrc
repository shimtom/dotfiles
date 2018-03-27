#!/usr/bin/env perl

if ($^O eq 'MSWin32') {
  $latex = 'uplatex %O -kanji=utf8 -no-guess-input-enc -synctex=1 -interaction=nonstopmode %S';
  $latex_silent = 'uplatex %O -kanji=utf8 -no-guess-input-enc -synctex=1 -halt-on-error -interaction=batchmode %S';
  $lualatex = 'lualatex -cmdx %O -synctex=1 -interaction=nonstopmode %S';
  $ps2pdf = 'ps2pdf.exe %O %S %D';
  # TODO: set pdf previewer
  # $pdf_previewer = 'texworks'
} else {
  $latex = 'uplatex %O -synctex=1 -halt-on-error -interaction=nonstopmode %S';
  $latex_silent = 'uplatex %O -synctex=1 -halt-on-error -interaction=batchmode %S';
  $lualatex = 'lualatex %O -synctex=1 -interaction=nonstopmode %S';
  $ps2pdf = 'ps2pdf %O %S %D';
  if ($^O eq 'darwin') {
    # mac
    $pvc_view_file_via_temporary = 0;
    $pdf_previewer = '/usr/bin/open -g';
  } else {
    # linux
    $pdf_previewer = 'xdg-open';
  }
}
$pdflatex = 'pdflatex %O -synctex=1 -interaction=nonstopmode %S';
$xelatex = 'xelatex %O -synctex=1 -interaction=nonstopmode %S';
$biber = 'biber %O --bblencoding=utf8 -u -U --output_safechars %B';
$bibtex = 'upbibtex %O %B';
$makeindex = 'upmendex %O -o %D %S';
$dvipdf = 'dvipdfmx %O -o %D %S';
$dvips = 'dvips %O -z -f %S | convbkmk -u > %D';
$pdf_mode = 3;
$max_repeat = 5;
