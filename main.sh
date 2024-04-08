#!/bin/bash

#check if filename gaven
if [ $# -lt 1 ]; then
    echo "Usage: $0 input_file[.ipynb] [output_file.pdf]"
    exit 1
fi
#try adding extension if can't find it
input_file=$1
if [ ! -f "$input_file" ]; then
    input_file="${input_file}.ipynb"
fi
#exit if can't find the file
if [ ! -f "$input_file" ]; then
    echo "Error: Can not find $input_file"
    exit 1
fi

#name output file using the input file if not gaven
output_file=${2:-${input_file%.ipynb}.pdf}

#.ipynb --> .html --> .pdf
#jupyter .ipynb to .pdf doesn't work for me
jupyter nbconvert "$input_file" --to html --stdout | wkhtmltopdf - "$output_file"

echo "Conversion successful. PDF saved as $output_file"
