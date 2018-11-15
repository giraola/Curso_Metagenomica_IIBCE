# Día 2: Control de calidad, ensamblado, y anotación de fósmidos de interés.

En este tutorial se muestran de forma breve los métodos computacionales para el análisis de fósmidos secuenciados mediante la tecnología IonTorrent. Los pasos se aplican sobre un caso en particular, contenido en este repositorio, pero debería ser posible aplicarlos sobre otros fósmidos, lo cual se alienta de modo de permitir la comparación de resultados entre los estudiantes. Consultar a los docentes por otros sets de datos.

## 0 - Extracción y descompresión de archivos fastq
Abra una terminal y ubíquese en el directorio de trabajo "IonTorrentReads", dentro del directorio correspondiente al día 2. Si descargó los archivos en el _home_, entonces:
```
cd Curso_Metagenomica_IIBCE/Dia_2/IonTorrentReads/
ls
```
Como podrá observar, existe un archivo "Csd6.fastq.tar.gz". La extensión "tar.gz" indica que se trata de un tipo de archivo comprimido (similar a "zip"). Para descomprimirlo:
```
tar -xzf Csd6.fastq.tar.gz
ls -lh
```
`tar` es el programa de compresión/descompresión. El flag `x` significa "extraer", `z` significa que utiliza el algoritmo de compresión "gzip", y `f` significa que lo que sigue es el archivo sobre el cual el programa debe actuar. Para el caso del comando `ls` utilicé los _flags_ `l` para listar, y `h` para que muestre los tamaños de los archivos en un formato legible para el **h**umano (Mb en lugar de bytes, en este caso). 

Ahora, además del archivo comprimido, aparece "Cds6.fastq", el cual puede verse que tiene mayor tamaño según el paso anterior. 

**Ejercicio:**
 - ¿Cómo se puede ver qué contiene? Recuerde los comandos `head`, `less`, y `cat` de la clase anterior.

El formato "[fastq](https://en.wikipedia.org/wiki/FASTQ_format)" es similar al formato "fasta". Contiene en la primera línea un _header_ que siempre comienza con el símbolo "@", y luego información de la secuenciación que depende de cada tecnología. En una segunda línea se encuentra la lectura de los nucleótidos. En la tercera línea un símbolo de "+" que no cumple otra función más que de separador. Y en la cuarta fila contiene una secuencia de símbolos cuyo largo es el mismo que el largo de la línea 2, en la que cada símbolo respresenta un valor de calidad para cada nucleótido. Cada _read_ está representado por estas 4 líneas.

Si quisiéramos saber cuántos _reads_ contiene el fastq, no nos sirve contar los ">" utilizando `grep -c ">"`, como haríamos con un archivo fasta en el cual ese símbolo sólo aparecía una vez en el _header_. En los fastq, los _headers_ comienzan con "@", pero este símbolo también puede aparecer en la cuarta línea como un valor de calidad. Es necesario identificar una cadena de caracteres que aparezca una sola vez en cada _read_ y contar sus ocurrencias. En el caso del ejemplo, los _headers_ siempre comienzan con "@BOQ44:" (lo cual surge de la observación, aunque es esperable que estos archivos tengan algún identificador estándar). 

**Ejercicio:**
 - ¿Cómo haría para contar el número de _reads_ en el caso en el que está trabajando?



## 1 -  Control de calidad de 
