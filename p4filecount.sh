p4 files //...|perl -ne 'm{#(\d+)};$r+=$1;END{print"# of files: $. \n#of
revisions $r\n"}'
