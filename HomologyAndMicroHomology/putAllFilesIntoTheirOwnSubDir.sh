for x in ./*.fa; do mkdir "${x%.*}" && mv "$x" "${x%.*}";done
