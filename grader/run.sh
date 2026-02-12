
#!/bin/bash

echo "==== EVALUACION AUTOMATICA ===="
total=0
score=0

check(){
 file=$1
 testfile=$2
 pts=$3

 input=$(sed -n '1,/^---$/p' "$testfile"|sed '$d')
 expected=$(sed -n '/^---$/,$p' "$testfile"|sed '1d')

 out=$(echo "$input"|./prog)

 if [ "$out" = "$expected" ]; then
   echo "$(basename $file) OK +$pts"
   score=$((score+pts))
 else
   echo "$(basename $file) FAIL"
 fi
 total=$((total+pts))
}

for f in soluciones/*.c; do
 name=$(basename "$f" .c)

 gcc "$f" -o prog 2>/dev/null || { echo "$name no compila"; continue; }

 if [ -f tests/public/$name.txt ]; then
   check "$f" tests/public/$name.txt 5
 fi

 if [ -f tests/hidden/$name.txt ]; then
   check "$f" tests/hidden/$name.txt 5
 fi

done

echo "PUNTAJE: $score / $total"
echo "CALIFICACION: $((score*10/total))/10"
