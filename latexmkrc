#!/usr/bin/perl

$latex = 'platex -synctex=1 -halt-on-error %O %S';
$dvipdf = 'dvipdfmx %O %S';
$pdf_mode = 3;
$pdf_previewer = 'evince';
