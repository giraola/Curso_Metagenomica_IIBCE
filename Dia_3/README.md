# Día 3: Análisis computacional de Metagenomas (_shotgun_)

Hoy se analizarán datos de secuenciación masiva utilizando [MetaPhlAn2](http://huttenhower.sph.harvard.edu/metaphlan2) y [HUMAnN2](http://huttenhower.sph.harvard.edu/humann2). Este tutorial está basado en el tutorial [Metagenomics Tutorial (HUMAnN2)](https://github.com/LangilleLab/microbiome_helper/wiki/Metagenomics-Tutorial-(Humann2)) de [Microbiome Helper](https://github.com/LangilleLab/microbiome_helper/wiki), aunque contiene algunas modificaciones. Es importante señalar que este tipo de análisis es, en general, exploratorio y que un buen análisis requiere además un curado manual que dependenderá de cada caso de estudio y de la pregunta a responder.

La idea es presentar un ejemplo de determinación de la composición taxonómica y funcional de varias muestras metagenómicas. Se utilizará como caso de estudio un _sub-set_ de los datos presentados en [Schmidt et al. (2014)](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0098741), trabajo en el cual se analizan cambios en el microbioma oral asociados a cáncer oral. **Atenti: estos datos representan un muestreo muy poco representativo de los originales, ya que es imposible trabajar con tal volumen de datos en las computadoras disponibles.**

## Exploración de muestras

En `~/Descargas/mgs_tutorial_Oct2017` se encuentran los datos que se utilizarán en este tutorial.
```
cd ~/Descargas/mgs_tutorial_Oct2017
ls -l
```

En el directorio `raw_data` se encuentran los archivos FASTQ con los _reads_ de la secuenciación. El archivo de mapeo `map.txt` contiene la metainformación asociada a cada muestra.

```
less map.txt
```
Este archivo de mapeo tiene cuatro columnas: la primera con el id de cada muestra, la segunda con el tipo de muestra (Cáncer o Normal), sexo y el individuo. 



