![image](terminales)

# Introducción

UNIX es un sistema operativo desarrollado en los años sesentas y que
sigue actualizándose constantemente. Un sistema operativo lo definimos,
en esta instancia, como un conjunto de programas que hacen funcionar a
la computadora. UNIX es un sistema estable, de múltiples usuarios y
“multi-tasking", diseñado tanto para servidores, como para
computadoras de escritorio y portátiles. Este sistema operativo tiene
una interfaz gráfica (GUI, graphical user interface) similar a la de
Microsoft Windows, lo que lo hace más fácil de utilizar. Sin embargo,
existen operaciones que no pueden realizarse a través de la interfaz
gráfica, por lo que son necesarios conocimientos de línea de comando de
UNIX. No todo se puede solucionar con una ventanita\!  
Existen varias versiones de UNIX, aunque todas comparten las mismas
características. Las variedad más popular es GNU/Linux. Linux viene a su
vez en varios “flavors", por ejemplo FEDORA, Red Hat, Centos, etc.

## El sistema operativo

El sistema operativo de UNIX consiste en tres partes:  

  - Kernel

  - Terminal

  - Programas

El **kernel** es el corazón del sistema operativo: aloca tiempo y memoria para
programas, maneja el sistema de archivos y las comunicaciones en
respuestas a llamadas del sistema. La **terminal** actúa como interfaz entre el
usuario y el Kernel. Cuando un usuario se “loggea” al sistema, el
programa de login chequea el nombre de usuario y la contraseña, y
seguidamente arranca un programa llamado terminal. La terminal es un
interpretador de líneas de comando (CLI, command line interpreter), es
decir, interpreta los comandos que el usuario ingresa y se asegura de
comenzar el proceso de ejecucíon. Los comandos son en si mismos
programas: cuando terminan la terminal devuelve otro “prompt" , por
ejemplo “%".  
Un ejemplo que ilustra como la trabaja junto con el Kernel, podría ser
cuando el usuario escribe en la terminal `rm myfile` (este
comando tiene el efecto de eliminar el archivo myfile). La terminal
busca en el sistema el archivo que tiene el programa `rm` y
seguidamente le pide al Kernel a través de llamadas del sistema que
ejecute el programa sobre el archivo `myfile`. Una vez terminado el
proceso, la terminal devuelve el prompt `%` al
usuario.  
*Tips:  
Si se ingresa parte del nombre de un comando, un archivo o un
directorio, presionando la tecla **Tab** la terminal completa el resto del
nombre automáticamente. Si la terminal encuentra mas de un
comando/archivo/directorio que comienza con la misma parte que tipeó el
usuario, la misma muestra todas las posibilidades (algunos tipos de
terminal hacen un “beep" debiendo el usuario ingresar más letras).  
La terminal guarda la lista de comandos que ingresó el usuario, es decir
guarda la historia de comandos.*

## La estructura de directorios

Todo en UNIX es un archivo o un proceso. Un proceso es un programa
ejecutable identificado por un identificador único (PID, process
identifier). Un archivo es una colección de datos, creados por los
usuarios utilizando editores de texto, compiladores, etc. Archivos
pueden ser documentos de texto, el texto de un programa escrito en algún
lenguaje de programación, una carpeta con archivos y otras carpetas,
instrucciones legibles sólo por la máquina, etc.  
Todos los archivos se agrupan en una estructura de directorios, en uno
en más discos (igual que en Windows, en donde existen muchas particiones
llamadas A:, B:, C:, etc que pueden ser discos duros, pen drive,
CD-ROMs). El sistema de archivos es estructurado de forma jerárquica. La
punta de la jerarquía es usualmente lo que se llama “root" y se escribe
como “/". La siguiente figura muestra un ejemplo de esta jerarquía.  

![Ejemplo de estructura de directorios de
UNIX](figuras/files.jpg)
<img src="figuras/files.jpg" width="48">

## Sistema multiusuario

UNIX es un sistema operativo de ambiente multi-usuarios, en contraste
con por ejemplo Windows. Cuando se tiene Windows en una PC todos los
archivos son legibles y modificables por el usuario. El usuario puede,
por ejemplo, borrar cualquier tipo de archivo y en principio nadie lo
impide (quizás algún mensaje de advertencia de Windows). Por el
contrario, en UNIX existen varios usuarios en un mismo sistema. Por lo
tanto, cada archivo o directorio tiene propietarios asociados. El “home
directory" (el directorio donde el usuario guarda sus archivos) es
propiedad de ese usuario. Asimismo, todos los archivos que él genera.
Cada archivo o carpeta tiene permisos asociados. Por ejemplo, un usuario
regular puede ejecutar y leer programas del sistema, pero no puede sobre
escribirlos. Un usuario puede cambiar los permisos de cualquier archivo
o carpeta de su propiedad, pero no de archivos ajenos. Veremos ejemplos
de esto más adelante. Ya que definimos que el sistema es de
multi-usuarios tenemos que poder decirle al sistema quienes somos.
Además tenemos que asegurarle al sistema que un usuario no puede
hacerse pasar por otro y acceder a sus datos. Esto se logra a través de
un procedimiento de “login".

## Login

El administrador de sistemas tiene que proporcionarles un nombre de
usuario y una contraseña inicial. Los distintos sistemas operativos
tienen distintas formas de presentar la pantalla de login, ya sea como
texto o como una interfaz gráfica. De cualquier manera, se deben
ingresar el nombre de usuario y la contraseña. Una vez dentro del
sistema, también dependiendo del sistema utilizado y del administrador
de sistema, aparece la terminal, en donde se pueden ingresar los
comandos. UNIX es un sistema multi-tasking también, es decir que uno
puede tener varias terminales funcionando al mismo tiempo. Asimismo,
existen diferentes tipos de terminales, en Linux la terminal por defecto
es bash (Bourne Again SHell). Otros tipos de terminales incluyen csh,
tcsh, ksh and sh. Todas tienen características similares, de cualquier
forma, utilizaremos para este tutorial la terminal bash.  
Una forma de concluir la sesión es ingresando logout en la terminal.

# Manipular archivos y carpetas

Una vez hecho el login, el usuario se encuentra en su “home directory",
que tiene el mismo nombre que el nombre de usuario. Abre una terminal y
tipea:  
<span> ejemplosUNIX</span>  
El comando <span>cd micarpeta</span> lleva al usuario a la carpeta
llamada micarpeta. También puede colocarse un camino (“path") hacia una
carpeta.  
  
Este comando lleva al usuario a un nivel más arriba en el sistema de
archivos, al archivo padre. Es decir, si el usuario se encuentra en la
carpeta micarpeta, con <span>cd ..</span>, puede volver a salir de la
misma.  
<span> </span>  
El comando <span>ls</span> lista los archivos y carpetas visibles dentro
del directorio en donde el usuario se encuentra. Si se le agrega un
“switch” al commando (una modificación, en general dada por un “-"),
se pueden modificar las funciones de los comandos.  
<span> </span>,  
lista todos los archivos, también los ocultos que comienzan con un
punto.  
Ingresemos en la terminal:  
<span> misPruebas</span>,  
este comando sirve para crear directorios dentro del espacio de la
máquina donde tienes permiso para hacerlo (usualmente en
/home/usuario). Puedes señalar la ubicación del nuevo directorio con un
path absoluto o relativo.  
Ahora ingresemos al nuevo directorio:  
<span> misPruebas</span>,  
Creemos una subcarpeta llamada subPruebas:  
<span> subPruebas</span>  
Otra posibilidad de hacer lo mismo es:  
<span> misPruebas/subPruebas</span>,  
de esta forma, se genera la subcarpeta subPruebas dentro de la carpeta
misPruebas, automáticamente.  
Muchas veces uno pierde la noción de en qué carpeta se encuentra. Para
ello se puede utilizar el comando <span>pwd</span>. Ingresa el comando
en la terminal y observa el resultado.  
. ?‘Qué retorna este comando?  
Si estás perdido, y no sabes en qué carpeta estás, el comando
<span>cd</span> argumentos, te lleva a tu “home directory”.  
Si estás más confundido aún y no sabes sos, utiliza el comando
<span>whoami</span>. Y si no sabes sos, utiliza <span>hostname</span>.
Pruébalos.  
El comando <span>man</span> es de mucha utilidad. Este comando, usado
bajo la forma <span>man comando</span>, despliega información acerca del
comando requerido. Indica cuáles son las opciones y argumentos asociados
a cada comando. Prueba de obtener ayuda sobre el comando ls.  
Con el comando <span>mv</span> y <span>cp</span> se pueden cambiar
archivos y directorios de lugar. La sintaxis de estos comandos es:
<span>mv/cp ficheroOrigen ficheroDestino</span>. Como otras veces,
puedes usar referencias absolutas o relativas. Prueba copiar
cancion.txt, que se encuentra dentro de la carpeta micarpeta hasta la
carpeta misPruebas. Dependiendo de donde te encuentres, cómo es el
comando. Si me encuentro dentro de la carpeta ejemplosUNIX el comando
sería:  
<span> micarpeta/cancion.txt misPruebas</span>  
Intenta alguna otra alternativa y verifica con <span>ls</span> que
efectivamente se hayan copiado al directorio indicado.  
Si observas atentamente, el comando mv puede utilizarse para renombrar
archivos. Sólo es necesario indicar un nuevo nombre para ese archivo en
el destino. Renombra el archivo cancion.txt en la carpeta misPruebas a
LAcancion.txt.  
<span> cancion.txt LAcancion.txt</span>.  
<span> nombreDeDirectorio</span>,  
es un comando utilizado para borrar directorios vacíos. En caso
contrario sale una advertencia.  
<span> nombreDeArchivo</span>,  
este comando permite borrar uno o varios archivos. La opción (switch) -R
hace que el comando opere en forma recursiva, esto es, que se vaya
adentrando nivel por nivel y borrando todo lo que encuentra. La opción
-i hace la eliminación interactiva (pidiendo confirmación antes de
proseguir). Una vez eliminados, los ficheron son prácticamente de
recuperar. Además, se pueden utilizar los wildcards para borrar
múltiples ficheros a la vez o para eliminar alguno cuyo nombre no
recuerdas exactamente.  
<span> Tarea:  
Genera una copia del directorio micarpeta y su contenido, utilizando un
nuevo nombre, por ejemplo micarpeta2. Para ello, crea un nuevo
directorio micarpeta2 y cópiale el contenido de la carpeta micarpeta a
la nueva carpeta, utilzando los comandos aprendidos anteriormente. Mu
évete hacia la carpeta nueva, micarpeta2, y genera copias del archivo
cancion.txt, llamadas cancion2.txt, cancion22.txt, cancion3.txt y
cancion32.txt. Elimína todos aquellos archivos, dentro de micarpeta2 que
terminen con 2.txt, utilizando las wildcards.  
<span> \*2.txt</span>  
?‘Cuáles son los archivos quedan en la carpeta?  
Ahora intenta eliminar la carpeta micarpeta2. Intenta lo siguiente:  
<span> micarpeta2</span>. ?‘Funciona?  
<span> micarpeta2</span>. ?‘Funciona?  
Intenta <span> micarpeta2</span>.  
</span>

# Usuarios y permisos

Como se mencionó anteriormente, Unix (Linux) es un sistema multiusuario
por lo que es necesario la administración (segura) de los distintos
usuarios que van a hacer uso de los recursos del sistema. Sin entrar en
la administración de usuarios (tarea del root), podemos revisar
rápidamente algunos conceptos importantes.  
La generación de grupos es una manera de otorgar una serie de
privilegios (propiedades y permisos) a un conjunto de usuarios sin tener
que dárselos de forma individual a cada uno. Todo usuario tiene siempre
un grupo principal al que pertenece. Con respecto a los usuarios
“normales”, lo más frecuente es que cada uno tenga un grupo principal
por lo que sus directorios de trabajo son sólo accesibles por este
usuario. Además, en el sistema hay más grupos que los principales de
cada usuario. La finalidad de estos otros grupos es la de otorgar
permisos similares al conjunto de usuarios que forman parte de él ante
un directorio, un archivo, un dispositivo, etc. Por ejemplo,
dispositivos como el grabador de CDs tienen como usuario dueño al root,
y como grupo a uno que contenga a todos los usuarios de la máquina, de
modo que cualquier usuario pueda grabar CDs.  
Cada uno de los elementos del sistema de Linux tienen dueño, ya sean
ficheros, directorios o enlaces a dispositivos. Por un lado, tienen un
dueño, y por otro un dueño. Cuando se trabaja en el sistema, los
ficheros creados durante la sesión, pertencen al usuario de esta sesión
y a su grupo principal. Así se comportan los programas por defecto. Es
lógico que los ficheros que estén bajo el directorio de trabajo de un
usuario le pertenezcan, sin embargo esto puede cambiarse.  
Siempre que tratemos con permisos y dueños de elementos, debemos tener
presente el hecho de que el sistema de ficheros de Linux es jerárquico;
esto implica que los cambios que hagamos, por ejemplo en un directorio,
pueden influir en el resto de elementos que están contenidos en un nivel
inferior a éste. El comando <span>chown</span> (“change owner”) permite
cambiar el propietario de los elementos del sistema de archivos.
Lógicamente, como usuarios “normales”, no vamos a poder cambiarle el
propietario a elementos que pertenezcan al root o a otros usuarios. En
cambio como root podremos cambiar el dueño de cualquier cosa. Algo de la
sintaxis de <span>chown</span> (loggeados como root\[1\]):  
<span> usuario elemento(s)</span>  
<span> usuario.grupo elemento(s)</span>  
<span> -R usuario directorio</span>  
En la primer línea de comandos, el propietario de elemento(s) será
cambiado a usuario. El grupo dueño de elemento(s) seguirá siendo el
mismo. En la segunda línea, usuario.grupo permite cambiar
simultáneamente el usuario y el grupo propietarios de elemento(s).
Elemento(s) puede ser un único fichero o varios, si utilizas wildcards
como el \*. En la tercera línea, la opción -R permite cambiar
recursivamente de propietario a todo lo que exista dentro de
directorio/.  
El fin de establecer dueños a los archivos y directorios es poder
asignar adecuadamente permisos. Un archivo tiene distintos niveles de
permisos: lectura (r), escritura (w) y ejecución (x). Los permisos sobre
un fichero pueden ser distintos para el usuario dueño, para los usuarios
pertenecientes al grupo dueño y, para el resto de los usuarios del
sistema. Así por ejemplo, el usuario dueño puede leer, escribir y
ejecutar un fichero, el grupo dueño solo puede leerlo, mientras que el
resto de los usuarios del sistema no tienen ningún permiso sobre él. Una
buena asignación de dueños de elementos, junto a una política de
permisos adecuada, son fundamentales para lograr que un sistema
multiusuario sea seguro.  

![Resultado del comando ls -l. El rectángulo celeste marca los permisos,
dueños, y grupos de los respectivos
archivos.<span label="fig2"></span>](ls_l.png)

Dirígete a la carpeta <span>ejemplosUNIX</span> e ingresa en la
terminal:  
  
Se verá algo similar a la figura [2](#fig2). Este comando permite ver
los permisos y dueños asociados a cada archivo bajo la carpeta que te
encuentras. Bien sobre la izquierda del listado, se encuentra un campo
de un único caracter que indica el tipo de fichero. Si es un directorio
aparece una <span>**d**</span>, si es un archivo normal aparece un guión
<span>**-**</span>, mientras que si se trata de un elemento de enlace
aparece una <span>**l**</span>. Seguidamente, aparecen tres grupos, cada
uno con tres letras, que pueden ser <span>**r w x**</span> o estar
sustituídas por un guión <span>**-**</span>. El primero de los grupos
indica los permisos que tiene el dueño sobre el elemento listado (en
este caso el usuario es siempre Lu); el segundo grupo indica los
permisos que tienen sobre el elemento los otros usuarios que pertencen
al grupo dueño (en este caso el grupo es siempre staff) y el tercer
grupo indica los permisos que tienen sobre el elemento el resto de los
usuarios del sistema (los usuarios que no pertenecen al grupo staff). Si
observamos el fichero ANII, el mismo es un directorio
(<span>**d**</span>), cuyo dueño es Lu, y el grupo dueño es staff. Lu
tiene permisos de lectura (<span>**r**</span>), escritura
(<span>**w**</span>) y ejecución (<span>**x**</span>). Los miembros de
staff solo tienen permisos de ejecución y lectura, al igual que el resto
de los usuarios del sistema. Cuando se trata de un directorio, tanto la
<span>**r**</span> como la <span>**x**</span> se requieren para que un
usuario pueda ver y acceder al contenido. La <span>**w**</span> indica
que ese usuario tiene permiso para colocar nuevos archivos en este
directorio, así como también borrarlo.  
Para cambiar los permisos de los elementos del sistema de ficheros,
usamos el comando <span>chmod</span>. La sintaxis es la siguiente
(loggeado como root):  
<span> -R ABC elemento(s)</span>  
Si se usa la opción -R, se cambian recursivamente los permisos de todo
el contenido de un directorio. A, B y C indican cifras que representan
respectivamente los permisos que se le asignan al usuario dueño, a los
usuarios del grupo dueño y al resto de los usuarios. Cada una de las
cifras posibles se corresponde con los permisos del usuario en binario.
Para facilitar, puedes recordar que r w x se corresponden con \(4\)
\(2\) \(1\), y que la combinación de números y suma equivale a los
permisos de cada tipo de usuario. Por ejemplo, un usuario que tiene
permiso \(7\), es un usuario que puede leer, escribir y ejecutar un
fichero (\(r+w+x=4+2+1=7\)). Por el contrario, un usuario con permiso
\(4\) solo podrá leer ese fichero (\(r+w+x=4+0+0=4\)).  
<span> Tarea:  
Cambiémosle los permisos la carpeta <span>micarpeta</span> y a los
archivos dentro de ella, de forma tal que todos los usuarios tengan
todos los permisos:  
<span> -R 777 elemento(s)</span>  
Trata de cambiarle los permisos para que sólamente el dueño tenga todos
los permisos y el resto sólo tenga permisos de lectura.</span>  
Como vimos brevemente más arriba el comando <span>su</span> (“set user”)
está relacionado con el login como root. El comando <span>su</span> es,
en realidad, más general. El principal uso de <span>su</span> es que un
usuario normal adquiera los permisos de otro usuario del sistema,
incluído el root, siempre y cuando sepa su clave. Es muy común que, aún
siendo los administradores del sistema y tengamos la contraseña de root,
trabajemos normalmente como un usuario normal por motivos de seguridad.
Pero podemos necesitar convertirnos en root para alguna tarea
específica: reiniciar el servidor web, modificar la configuración del
sistema, cambiar los permisos de archivos, los dueños, etc, para después
“volver” a ser un usuario normal.  
  
password: (se ingresa clave de root)  
  
En el caso anterior, su “a secas” asume que el usuario actual quiere
adquirir los permisos de root. Si se proporciona la clave adecuada,
estos se adquirirán. Cuando se desee volver a trabajar como un usuario
normal se ingresa <span>exit</span>.  
Si además de requerir los permisos de root se quiere trabajar con su
configuración y variables de entorno, entonces se utiliza <span>su
-</span>, que es como si estuviésemos haciendo un logging desde el
principio.  
Para loggearnos como usuarios distintos de root, se debe indicar el
nombre del otro usuario (así como su clave).  
  
password: (se ingresa clave de otrousuario)  
  
El usuario root puede usar <span>su</span> o <span>su -</span> para
adquirir los permisos de cualquier usuario del sistema, sin necesidad de
introducir ninguna clave.  

# Mostrar los contenidos de los archivos en la terminal

Primero que nada, limpiaremos la terminal de los comandos anteriores.  
  
El “prompt” aparece en la primera línea de la terminal.  
Para observar el contenido de un archivo en la terminal, existen varios
comandos. Uno es el siguiente:  
<span> archivo</span>  
<span>Tarea:  
Prueba visualizar el archivo <span>NC\_010063\_s\_aureus.fna</span>
dentro de la carpeta <span>micarpeta</span>. ?‘Qué contien el archivo
<span>NC\_010063\_s\_aureus.fna</span>? Otro posible comando es
<span>less</span>. Pruébalo con el mismo archivo.</span>  
La diferencia entre ambos comandos es que <span>cat</span> imprime todo
el archivo en la terminal, aún si el mismo es demasiado largo y no entra
en la terminal. Si esto pasa, uno queda mirando el final del archivo y
tiene que hacer “scroll” hacia arriba para ver el comienzo del archivo.
El comando <span>less</span> imprime el contenido página a página,
pudiendo pasar de una a otra con el espacio.  
Existe otro comando con la misma finalidad: <span>more</span>.  
<span>Tarea:  
?‘Cuál es la diferencia con los otros dos?</span>  
Cuando se está trabajando con archivos muy largos, o simplemente sólo se
quiere ver la parte inicial de algún archivo, el siguiente comando es de
gran utilidad:  
<span> archivo</span>.  
<span>Tarea:  
Pruébalo con el archivo <span>LAcancion.txt</span>.</span>  
Este comando muestra por defecto las \(10\) primeras líneas del archivo.
Utilizando el switch <span>-5</span> puede modificarse para observar las
5 primeras líneas.  
El comando <span>tail</span> muestra las últimas líneas del archivo
especificado.  
<span> Tarea:  
Pruébalo con el archivo <span>LAcancion.txt</span>. ?‘Cómo puedes hacer
para ver las últimas \(15\) líneas de un archivo?  
</span> Muchas veces vamos a estar interesados en saber cuántas líneas
tiene un archivo (ya veremos a lo largo del curso la utilidad). El
comando para esto es <span>wc</span>. El mismo tiene varios switchs.  
<span> Tarea:  
Investiga con la ayuda de <span>man</span> qué opciones existen para el
<span>wc</span>.  
?‘Cuántos caracteres tiene el archivo
<span>NC\_010063\_s\_aureus.fna</span>?  
</span> El comando <span>grep</span> es utilizado para buscar palabras
dentro de un texto. El mismo devuelve la línea del archivo en donde
aparece la palabra.  
<span> Tarea:  
Busquemos por ejemplo, la secuencia “ATGCTTA” en el archivo
<span>NC\_010063\_s\_aureus.fna</span>. ?‘Aparece alguna vez? Busca
ahora “ATGCTA”, ?‘cuántas veces aparece? ?‘Puedes contar las veces que
aparece utilizando grep con algún switch? ?‘Qué problemas presenta
buscar secuencias con este comando en este tipo de formato fasta?  
</span> Muchas veces en bioinformática tenemos que manipular tablas de
datos, el comando <span>cut</span> puede ser muy útil para manipularlas.
Intenta visualizar primero el archivo procariotas\_patogenicidad.csv,
que contiene una tabla con datos fenotípicos de las bacterias. Ingresa
en la terminal:  
<span> procariotas\_patogenicidad.csv</span>.  
Los campos que se observan son entre otros ID del proyecto, taxonomía,
nombre de organismo, etc. El caracter separador es el “;”. Queremos
observar, por ejemplo, sólo la columna \(4\), que contiene los nombres
de los organismos. Para ello, se ingresa el siguiente comando en la
terminal:  
<span> procariotas\_patogenicidad.csv</span>.  
El resultado es en la terminal, el standard output (ver próxima
sección).

# Conceptos: entrada y salida

Los conceptos de entrada/salida o “input/output (I/O)”, tienen que ver
con el ingreso de datos al sistema o a un programa y con la salida que
ese sistema o programa devuelve. Por ejemplo, escribir un comando (por
ej. <span>ls</span>) con el teclado es una forma de input, mientras que
el listado de archivos que devuelve el comando <span>ls</span> en el
monitor es una forma de output. El teclado y el monitor se consideran
los medios de entrada y salida estándar, stdin y stdout respectivamente.
Unos de los comandos principales asociados a la salida es el
<span>echo</span>. El mismo permite “imprimir” cosas en la pantalla. Por
defecto recibe cadenas de texto entre comillas (simples o dobles) y la
saca a la pantalla, aunque se puede redirigir la salida a otro sitio.
Además, se puede usar para realizar operaciones aritméticas con la
terminal.  
<span>Tarea:  
Ingresa el comando:  
<span> “Hagamos unas cuentitas”</span>.  
<span> “6\*9”</span>  
<span> “\[6\*9\]”</span>  
<span> “$\[6\*9\]”</span>  
?‘cuál crees que es la finalidad de $?  
</span>

# Pipes

Hasta ahora hemos visto cuáles son las entradas de datos y salidas de
algunas de las utilidades más comunes. Lo siguiente es lograr conectar
de alguna forma la salida de un programa y hacer que otro lea de ella.
Existen algunos caracteres (\(\mid, < ,>, \gg\)) que nos permiten crear
estas conexiones o pipes (tuberías) entre programas en la terminal.  
El efecto de los pipes es fácil de entender. Un A \(\mid\) B indica que
la salida de A, en lugar de hacer su salida por defecto, va a ser
enviada al stdin de B para convertirse en los datos de entrada del
programa B. Los caracteres \(<\) y \(>\) también permiten crear pipes;
generalmente trabajan con un fichero de un lado y un comando del otro
(en el sentido comando \> fichero). Cabe destacar, que en caso de no
existir el fichero que recibe la salida de antemano, se genera
automáticamente. Además se pueden agregar nuevos datos a un fichero
preexistente (“appendear”) por medio de \(\gg\).  
<span>Tarea:  
Prueba estas líneas de comando y verifica el contenido de los ficheros
generados usando cat, more o less.  
<span> “close” cancion.txt \(\mid\) wc</span>  
<span> “close” cancion.txt \> close.txt</span>  
<span> “nothing” cancion.txt \(\gg\) close.txt</span>  
<span> “I” cancion.txt \(\mid\) sort \(\gg\) nothing</span>  
</span> El comando <span>sort</span> ordena una lista de caracteres. A
veces, como en este caso, hay varias líneas repetidas, y uno está
interesado sólamente en las no repetidas. El comando <span>uniq</span>
imprime sólo una aparición de cada línea repetida.  
<span>Tarea:  
Prueba esos comandos.  
<span> close.txt</span>  
Posiciónate en la carpeta micarpeta. Ahora prueba lo siguiente:  
<span> \> nombre\_lista</span>  
Chequea cuál es la función del switch -1 en el comando <span>ls</span>.
?‘Cuántos archivos hay en la carpeta?  
?‘Cuál es la función de este switch?  
</span>

# Ejercicio final

Vuelve al archivo procariotas\_patogenicidad.csv. ?‘Puedes determinar
cuántos organismos hay del reino bacteria y cuántos del reino arquea?
?‘Cuántas categorías hay en la tabla para el requerimiento de oxígeno
(“Oxygen Req”)? ?‘Cuántos organismos son aeróbicos? ?‘Cuántos organismos
son facultativos? ?‘Cuántos organismos son no-patogénicos? Puedes
utilizar para esto todo lo visto hasta ahora.

1.  para loggearse como root se ingresa en la terminal su + ENTER y
    luego se ingresa la clave de root, que debe de ser proporcionada por
    el administrador de sistema. Más detalles más adelante.
