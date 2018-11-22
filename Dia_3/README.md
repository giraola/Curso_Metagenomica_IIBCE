# Día 3: Análisis computacional de Metagenomas (_shotgun_)

Hoy se analizarán datos de secuenciación masiva utilizando [MetaPhlAn2](http://huttenhower.sph.harvard.edu/metaphlan2) y [HUMAnN2](http://huttenhower.sph.harvard.edu/humann2). Este tutorial está basado en el tutorial [Metagenomics Tutorial (HUMAnN2)](https://github.com/LangilleLab/microbiome_helper/wiki/Metagenomics-Tutorial-(Humann2)) de [Microbiome Helper](https://github.com/LangilleLab/microbiome_helper/wiki), aunque contiene algunas modificaciones. Es importante señalar que este tipo de análisis es, en general, exploratorio y que un buen análisis requiere además un curado manual que dependenderá de cada caso de estudio y de la pregunta a responder.

La idea es presentar un ejemplo de determinación de la composición taxonómica y funcional de varias muestras metagenómicas. Se utilizará como caso de estudio un _sub-set_ de los datos presentados en [Schmidt et al. (2014)](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0098741), trabajo en el cual se analizan cambios en el microbioma oral asociados a cáncer oral. **Atenti: estos datos representan un muestreo muy poco representativo de los originales, ya que es imposible trabajar con tal volumen de datos en las computadoras disponibles.**

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

Antes de analizar los datos es necesario realizar el _trimming_, como vimos anteriormente con [Trimmomatic](http://www.usadellab.org/cms/?page=trimmomatic). Además en este caso, como se trata de muestras orales humanas, es necesario filtrar aquellos reads que pertenezcan al genoma humano. También filtraremos el genoma del fago PhiX que se utiliza como control positivo en los protocolos de armado de bibliotecas de secuenciación. Para ello se mapean los reads contra los genomas de los organismos "contaminantes", y aquellos que alínean son removidos del set. Acontinuación se utiliza [Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml) en modo _paired-end_.

Usaremos [KneadData](https://bitbucket.org/biobakery/kneaddata/wiki/Home), una herramienta que convenientemente llama a ambos programas y realiza el pre-procesamieno en un sólo comando.








