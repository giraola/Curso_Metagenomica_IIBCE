# Día 3: Análisis computacional de Metagenomas (_shotgun_)

Hoy se analizarán datos de secuenciación masiva utilizando [MetaPhlAn2](http://huttenhower.sph.harvard.edu/metaphlan2) y [HUMAnN2](http://huttenhower.sph.harvard.edu/humann2). Este tutorial está basado en el tutorial [Metagenomics Tutorial (HUMAnN2)](https://github.com/LangilleLab/microbiome_helper/wiki/Metagenomics-Tutorial-(Humann2)) de [Microbiome Helper](https://github.com/LangilleLab/microbiome_helper/wiki), aunque contiene algunas modificaciones. Es importante señalar que este tipo de análisis es, en general, exploratorio y que un buen análisis requiere además un curado manual que dependenderá de cada caso de estudio y de la pregunta a responder.

La idea es presentar un ejemplo de determinación de la composición taxonómica y funcional de varias muestras metagenómicas. Se utilizará como caso de estudio un _sub-set_ de los datos presentados en [Schmidt et al. (2014)](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0098741), trabajo en el cual se analizan cambios en el microbioma oral asociados a cáncer oral. 

**Atenti: estos datos representan un muestreo muy poco representativo de los originales, ya que es imposible trabajar con tal volumen de datos en las computadoras disponibles.**

## Exploración de muestras

En `~/Documentos/mgs_tutorial_Oct2017` se encuentran los datos que se utilizarán en este tutorial.
```
cd ~/Documentos/mgs_tutorial_Oct2017
ls -l
```

En el directorio `raw_data` se encuentran los archivos FASTQ con los _reads_ de la secuenciación. El archivo de mapeo `map.txt` contiene la metainformación asociada a cada muestra.

```
less map.txt
```
Este archivo de mapeo tiene cuatro columnas: la primera con el id de cada muestra, la segunda con el tipo de muestra (Cáncer o Normal), la tercera el sexo, y la cuarta el individuo. 

Antes de continuar es necesario descomprimir los archivos FASTQ, en el directorio `raw_data`.
```
gunzip raw_data/*gz
```
Visualicemos uno de ellos.
```
head -n 8 raw_data/p136C_R1.fastq

@SRR3586062.883556
CTTGGGGCTGCTGAGCTTCATGCTCCCCTCCTGCCTCAAGGACAATAAGGAGATCTTCGACAAGCCTGCAGCAGCTCGCATCGACGCCCTCATCGCTGAGG
+
CCCFFFFFHHHHHIJJJJJJJIJIJJJJGIJDGIJEIIJIJJJJJJJJIJJJJIJJIJJJJJHHHFFFFECEEEDDDDD?BDDDDDDBDDDDDDDDBBBDD
@SRR3586062.3376311
GACGGTGTCCTCAGGACCCTTCAGTGCCTTCATGATCTGCTCAGAGGTGATGGAGTCACGGACGAGATTCGTCGTGTCAGCACGTAGGATGCGGTCGCCTG
+
@@@DDDDAFF?DF;EH+ACHIIICHDEHGIGBFE@GCGDGG?D?G@BGHG@FHCGC;CC:;8ABH>BECCBCB>;8ABCCC@A@#################
```
**Ejercicio:**
 - ¿Cuántos reads tiene cada FASTQ?

En caso de tener datos propios, será siempre necesario analizar la calidad de la secuenciación utilizando algún programa de _quality check_, como FastQC que vimos la clase pasada.

## Pre-procesamiento

Aunque se podría correr todo el tutorial sobre estos datos, para ahorrar tiempo seguiremos trabajando con una sola muestra, que se encuentra en el directorio `raw_data_example`.

Antes de analizar los datos es necesario realizar el _trimming_, como vimos anteriormente con [Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic). 

```
mkdir trim_out
trimmomatic PE -threads 2 -phred33 raw_data_example/p144C_R1.fastq raw_data_example/p144C_R2.fastq trim_out/p144C_pR1.fastq trim_out/p144C_uR1.fastq trim_out/p144C_pR2.fastq trim_out/p144C_uR2.fastq SLIDINGWINDOW:4:20 MINLEN:50
```
**Ejercicio:**
 - ¿Cuántos reads pareados sobreviven al proceso de _trimming_?
 - ¿Qué sugiere para aumentarlo?


Además en este caso, como se trata de muestras orales humanas, es necesario filtrar aquellos reads que pertenezcan al genoma humano. Para ello se mapean los reads contra el genoma del organismo "contaminante", y aquellos que alínean son removidos del set. Acontinuación se utiliza [Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml) en modo _paired-end_.
<!---
Descarga de base de datos para bowtie: wget http://huttenhower.sph.harvard.edu/kneadData_databases/Homo_sapiens_Bowtie2_v0.1.tar.gz
-->

```
mkdir bowtie2_Hs_filtered
bowtie2 --very-sensitive --dovetail -x /home/pasteur/Downloads/Hs_bowtie2db/Homo_sapiens -1 trim_out/p144C_pR1.fastq -2 trim_out/p144C_pR2.fastq -U trim_out/p144C_uR1.fastq,trim_out/p144C_uR2.fastq --un-conc bowtie2_Hs_filtered/ --threads 6 -S /dev/null 2> bowtie2_Hs_filtered/summary.txt
```

La opción `--un-conc` permite extraer aquellos reads que **NO** mapeen contra la referencia (en este caso, el genoma humano) de forma concordante. En el archivo `bowtie2_hs_filtered/summary.txt` se reporta un resumen del resultado. 

**Ejercicio:**
 - ¿Cuánta contaminación de humano había?
 - ¿A qué corresponden los archivos `un-conc-mate.1` y `un-conc-mate.2`?


Por último es necesario concatenar los pares de reads ya que MetaPhlAn2 y HUMAnN2 no utilizan información de los reads pareados, lo cual haremos mediante el script `concat_paired_end.pl`.

En primer lugar es necesario cambiar los nombres de los archivos del paso anterior para que el script `concat_paired_end.pl` identifique los pares de archivos FASTQ. En este caso, como se mencionó, se realizará para **una sola muestra** por razones de tiempo, pero estandarizar los nombres sirve cuando trabajamos con un gran número de muestras.

Recordemos que el comando `mv` sirve para mover archivos, y para cambiarles el nombre.

```
mv bowtie2_Hs_filtered/un-conc-mate.1 bowtie2_Hs_filtered/p144C_1.fastq
mv bowtie2_Hs_filtered/un-conc-mate.2 bowtie2_Hs_filtered/p144C_2.fastq
```
Llamamos al script, seteando el parámetro `-o cat_reads` para crear un directorio nuevo con el resultado.
```
concat_paired_end.pl -p 2 --no_R_match -o cat_reads bowtie2_Hs_filtered/*fastq
```

**Ejercicio:**
 - Analice el resultado del script anterior.


## Análisis taxonómico y funcional con MetaPhlAn2 y HUMAnN2

**Nota:** _Cuando se instala `humann2` es necesario a su vez instalar bases de datos que pueden llegar a ocupar buen espacio de disco (y eventualmente memoria RAM). `humann2` permite seleccionar la base de datos que se desea instalar, y hay que hacer un balance entre el grado de fineza y la capacidad de la máquina en la que estemos trabajando. La instalación local contiene la base de datos de proteínas `uniref90_ec_filtered_diamond`, lo cual significa que nos restringimos a aquellos _clusters_ de [UniRef90](https://www.uniprot.org/help/uniref) que contienen un [EC](https://en.wikipedia.org/wiki/Enzyme\_Commission\_number) asignado. Un análisis más detallado puede requerir máquinas más potentes._

[MetaPhlan2](https://bitbucket.org/biobakery/metaphlan2/overview) es un programa en sí mismo, y permite ajustar multitud de parámetros si estamos realizando un análisis manual. Pero dado que [HUMAnN2](https://bitbucket.org/biobakery/humann2/wiki/Home) utiliza este script de todas formas, podemos correr sólo este último y analizar los archivos que devuelve, lo cual simplifica las cosas. Ambos programas (`humann2` y `metaphlan2.py`) aceptan muchos argumentos, los cuales pueden verse utilizando el _flag_ `-h`. 

Dado que `humann2` puede demorar bastante, sólo se analizará una de las muestras. El resultado para esta muestra se escribirá en el directorio `humann2_out`. 

```
humann2 --threads 4 --input cat_reads/p144C.fastq --output humann2_out/
```

Listamos el resultado:
```
ls -l humann2_out/
```
Dentro del directorio `p144C_humann2_temp` se encuentra el archivo `p144C_metaphlan_bugs_list.tsv`, el cual es el resultado principal de `metaphlan2.py` para esta muestra.

El resultado precomputado para todas las muestras se encuentra en el directorio `precalculated`, en el cual se encuentran separados los resultados para cada _software_ en directorios distintos.

```
cd precalculated/
ls
```

### HUMAnN2

Trabajaremos primero con el output de HUMAnN2. 

```
ls -l humann2_out/
```
Existen 3 archivos por muestra. 
 - `*_genefamilies.tsv` contiene identificadores de las familias génicas de UniRef detectadas, asociadas a una abundancia en RPK (_reads per kilobase_). Las familias génicas son grupos de secuencias codificantes de proteínas evolutivamente relacionadas que en general tienen una misma función. La abundancia de las familias génicas se encuentra estratificada para mostrar la contribución de cada unidad taxonómica. 
 - `*_pathabundance.tsv` detalla la abundancia de cada vía metabólica en la comunidad como función de las abundancias de las reacciones que la componen, estas últimas calculadas como la sumatoria de las abundancias de genes que catalizan cada reacción. En otras palabras, la abundancia de una vía metabólica es proporcional al número de copias completas de dicha vía en la comunidad.
 - `*pathcoverage.tsv` provee una descripción alternativa a la presencia o ausencia de vías metabólicas en una comunidad, independiente de su abundancia cuantitativa. En este caso, una vía metabólica puede estar consistentemente cubierta a nivel de la comundidad, pero no consistentemente a nivel de ninguna especie.

Más detalles de los archivos de salida de HUMAnN2 pueden encontrarse en [este link](https://bitbucket.org/biobakery/humann2/wiki/Home#markdown-header-output-files).

Antes de normalizar es necesario unir los _output_ de cada muestra.
```
mkdir humann2_final_out/

humann2_join_tables -s --input humann2_out/ --file_name pathabundance --output humann2_final_out/humann2_pathabundance.tsv
humann2_join_tables -s --input humann2_out/ --file_name pathcoverage --output humann2_final_out/humann2_pathcoverage.tsv
humann2_join_tables -s --input humann2_out/ --file_name genefamilies --output humann2_final_out/humann2_genefamilies.tsv

ls -l humann2_final_out/
```
Para normalizar las tablas (es decir, llevar los valores de abundancia a un porcentaje o proporción, de modo que todas las muestras queden comparables), existen muchas metodologías disponibles. Aquí usaremos las herramientas que ya provee HUMAnN2.

```
humann2_renorm_table --input humann2_final_out/humann2_pathabundance.tsv --units relab --output humann2_final_out/humann2_pathabundance_relab.tsv
humann2_renorm_table --input humann2_final_out/humann2_genefamilies.tsv --units relab --output humann2_final_out/humann2_genefamilies_relab.tsv

ls -ltr humann2_final_out/
```

Por último usaremos el script `humann2_split_stratified_table` para crear un archivo con la información estratificada y otro con la información no estratificada (es decir, con la información de cada vía con varias unidades taxonómicas, colapsadas en un sólo valor de abundancia).

```
humann2_split_stratified_table --input humann2_final_out/humann2_pathabundance_relab.tsv --output humann2_final_out
humann2_split_stratified_table --input humann2_final_out/humann2_genefamilies_relab.tsv --output humann2_final_out
humann2_split_stratified_table --input humann2_final_out/humann2_pathcoverage.tsv --output humann2_final_out

ls -ltr humann2_final_out/
```

Un posible análisis para estos resultados sería un test de hipótesis para buscar alguna asociación entre las abundancias de vías metabólicas y las variables del archivo `map.txt`. 
Para este tutorial se hicieron algunos scripts en lenguaje [R](https://www.r-project.org/) con este fin. 

**Nota:** _Los scripts presentes en el directorio `custom_scripts` son muy simples y no deberían ser usados para otro fin que no sea este tutorial._

Test de Hipótesis de [Wilcoxon](https://en.wikipedia.org/wiki/Wilcoxon_signed-rank_test) (no paramétrico).

```
~/Curso_Metagenomica_IIBCE/Dia_3/custom_scripts/wilcoxon.R humann2_final_out/humann2_pathcoverage_unstratified.tsv map.txt Sample.Type > humann2_final_out/wilcoxon-test_pathcoverage_SampleType.tsv
```

El comando devuelve una tabla con el nombre de la vía metabólica en la primer columna, y el p-value en la segunda. Con el siguiente comando buscaremos p-value menores a 0.05.

```
awk '$2 < 0.05' humann2_final_out/wilcoxon-test_pathcoverage_SampleType
```
**Ejercicio:** 
 - ¿Existe alguna vía diferencialmente enriquecida?



### MetaPhlAn2

Como vimos que HUMAnN2 también ejecuta MetaPhlAn2 como paso inicial, podemos usar este _output_ para obtener la composición de nuestras muestras. Para ello es necesario colapsar todos los resultados de MetaPhlAn2 en un sólo archivo.

```
mkdir metaphlan2_final_output/
merge_metaphlan_tables.py precalculated/metaphlan2_out/*tsv > metaphlan2_final_output/metaphlan2_merged.tsv
```

Este archivo tiene la información de abundancia para cada nivel taxonómico. Ejecutar el siguiente comando para crear una tabla de abundancia a nivel de especie:

```
grep -E "(s__)|(^ID)" metaphlan_final_output/metaphlan2_merged.tsv | grep -v "t__" | sed 's/^.*s__//g' > metaphlan_final_output/merged_abundance_table_species.tsv
```

El siguiente comando crea una tabla de abundancia a nivel de género:

```
grep -E "(g__)|(^ID)" metaphlan_final_output/metaphlan2_merged.tsv | grep -v "s__" | sed 's/^.*g__//g' > metaphlan_final_output/merged_abundance_table_genus.tsv
```

A partir de aquí lo que hagamos depende de nuestro objetivo de estudio. Aún así, podemos intentar "ver" la estructura de los datos a través de algunos gráficos simples. 

En primer lugar podemos plotear un heatmap de las abundancias de géneros. 

```
~/Curso_Metagenomica_IIBCE/Dia_3/custom_scripts/plot_heatmap.R
```

El script `plot_heatmap.R` acepta como primer argumento una tabla con las abundancias, el segundo argumento el archivo de mapeo ("map.txt"), en tercer lugar las variables que se quieran plotear (si es más de una, separadas por coma), y en cuarto lugar el nombre del archivo de salida (llamar al script sin argumentos para ver la ayuda).

```
~/Curso_Metagenomica_IIBCE/Dia_3/custom_scripts/plot_heatmap.R metaphlan_final_output/merged_abundance_table_genus.tsv map.txt Sample.Type,Sex heatmap_genus.pdf
evince heatmap_genus.pdf &
```
Algo importante a destacar es que esta tabla **NO ESTÁ NORMALIZADA**. Metaphlan2 permite la normalización de los datos por el número de reads, pero es un paso que se debe hacer desde el principio. El resultado que estamos utilizando fue recuperado de los archivos intermedios de HUMAnN2, el cual tiene su propia metodología de normalización. Lo correcto sería normalizar esta tabla previo a realizar análisis posteriores, pero no lo vamos a hacer en este curso ya que es simplemente ilustrativo.

Otra técnica básica que se utiliza para explorar la estructura de los datos es el Análisis de Componentes Principales ([PCA](https://en.wikipedia.org/wiki/Principal_component_analysis), por sus siglas en inglés). No es objeto de este curso aprender los fundamentos de la técnica, pero básicamente permite "ver" si los datos poseen cierta estructura.

El script `plot_PCA.R` devuelve un plot del PCA, con los puntos coloreados según la variable que elijamos.

```
~/Curso_Metagenomica_IIBCE/Dia_3/custom_scripts/plot_PCA.R metaphlan_final_output/merged_abundance_table_genus.tsv map.txt Sample.Type pca_genus.pdf
evince pca_genus.pdf &
```


**Ejercicio:**
 - ¿Existe alguna estructura evidente en los datos?
 - ¿Qué explica mejor la varianza en los datos, el estado del paciente (Cáncer vs Normal) o el sexo (M vs F)?


















