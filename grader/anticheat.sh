
#!/bin/bash
echo "== Analisis similitud =="
files=(soluciones/*.c)

for ((i=0;i<${#files[@]};i++)); do
for ((j=i+1;j<${#files[@]};j++)); do
 h1=$(md5sum "${files[i]}"|cut -d' ' -f1)
 h2=$(md5sum "${files[j]}"|cut -d' ' -f1)
 if [ "$h1" = "$h2" ]; then
   echo "Posible copia: ${files[i]} == ${files[j]}"
 fi
done
done
