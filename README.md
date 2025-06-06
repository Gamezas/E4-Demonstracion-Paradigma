# Simulador de reacciones químicas
## Paradigma funcional
## Alejandro Adrián García Martínez
## Descripción
La posibilidad de realizar experimentos con diferentes elementos y ver sus reacciones químicas es un poco complicada ya que varias reacciones pueden ser peligrosas o no se cuenta con el material o los elementos para llevar acabo, es por eso que con el objetivo dicáctico de ayudar a los alumnos a conocer un poco más sobre la química se diseño un simulador de reacciones químicas siguiendo el paradigma funcional en DrRacket.

![image](https://github.com/user-attachments/assets/1cffa6f2-2840-4a09-9b40-34dad1589c43)

## Teoría y Diseño
Para este simulador se tomó como base el conceto de las reacciones químicas entre elementos. 
Las reacciones químicas son procesos termodinámicos de transformaciones de la materia. Para que suceda una se necesita de que intervengan dos o más sustancias (metales o no metales), que cambian significativamente en el proceso, y pueden consumir o liberar energía para generar dos o más sustancias llamadas productos. (Concepto, s.f.)

Con esta definicón en mente se pensó simplificarlo de la mejor manera, con el objetivo que sea sencillo de entender, por lo que en este simulador solo se pueden hacer reacciones entre elemenos Metales (M) y No Metales (NM).

La lista de elementos es la siguiente:
## 🧪 Elementos del Simulador

Estos son los elementos químicos disponibles en el simulador:
- **Fe** – Hierro (Metal)
- **C** – Carbono (No Metal)
- **Cu** – Cobre (Metal)
- **Na** – Sodio (Metal)
- **Cl** – Cloro (No Metal)
- **O** – Oxígeno (No Metal)

Estos son algunos de los elementos más sencillos y comunes, por ejemplo el cloro (Cl) y el sodio (Na) son utilizados para crear el cloruro de sodio (NaCl) que es la sal de mesa.

Con esta teoría y este diseño buscando la simpleza y buscando demostrar las capacidades del paradigma Funcional se diseño el algoritmo.

## Algoritmo

El programa esta hecho en el lenguaje Racket, el cuál es muy útil para trabajar el paradigma funcional

Primeramente se utiliza la función ``` struct ``` que nos permite generar un "molde" o constructor de nuestro elementos para el simulador, de esta forma podemos acceder a sus propiedades como nombre, símbolo o tipo con mayor facilidad. (Racket, s.f.)

```
(struct elemento (simbolo nnombre tipo) #:transparent)
```

Después de tener el molde se crea una lista llamada ```elementos``` que almacenará todos los elementos construidos en el sistema, guardando su símbolo, su nombre y si es un M o un NM.
```
(define elementos (list
                   (elemento "Fe" "Hierro" "Metal")
                   (elemento "C" "Carbono" "No Metal")
                   (elemento "Cu" "Cobre" "Metal")
                   (elemento "Na" "Sodio" "Metal")
                   (elemento "Cl" "Cloro" "No Metal")
                   (elemento "O" "Oxígeno" "No Metal")))
```
La función buscar nos permite encontrar un elemento deseado en base al símbolo y así acceder a toda su información. Se da uso a la función lambda dentro de la función ```findf``` para identificar primero si lo ingresado es un string, después utilizando ```findf``` buscamos una forma de "find-first" ya que no existe ningun elemento repetido y todos los símbolos son únicos se puede garantizar que siempre encuentre el correcto.

La complejidad de esta función es de ```O(n)``` en su peor y caso promedio y ```O(1)``` en su mejor caos, esto se debe a que en este caso "n" es la cantidad de elementos revisará hasta encontrar el primero que se parezca a lo deaseado.

```
(define (buscar simbolo)
  (findf (lambda (elem) 
           (string=? (elemento-simbolo elem) simbolo))
         elementos))
```


La función ```reacción?``` nos permite revisar que se cumpla la regla establecida desde el diseño, que es que solo haya reacciones ntre M y NM, es decir reacciones como las aleaciones que son entre los metales y los no metales no se pueden realizar en el simulador.

La complejidad de esta función es de ```O(1)``` ya que unicamente se revisa que se cumpla la condición if y regresar un true o en el caso de que no se cumpla un false.

```
(define (reaccion? elem1 elem2)
      (if (or (and (string=? (elemento-tipo elem1) "No Metal") 
                   (string=? (elemento-tipo elem2) "No Metal"))
              (and (string=? (elemento-tipo elem1) "Metal") 
                   (string=? (elemento-tipo elem2) "Metal")))
          #f
          #t))
```
La función ```mezcla``` funiciona como la función central del programa, porque es la función que llama a las demás y devuelve el resultado de la interacción con el usuario, es decir en esta función se busca los elementos deseados de la lista previamente construida, se indetifica si los elementos elegidos son M o NM, y se decide si se puede llevar acabo una reacción química entre ellos, en el caso de que si se imprime el resultado de la combinación y en el caso de que no solo se le notifica al usuario que no se ha podido llevar acabo.

Al ser la función principal del sistema se toma complejidad más alta de las demás funciones la cuál es ```O(n)``` en el peor y en el caso promedio y ```O(1)``` en el mejor de los casos.

```
(define (mezcla sim1 sim2)
  (let ([elem1 (buscar sim1)]
       [elem2 (buscar sim2)])

  (cond
    [(not (and elem1 elem2))
     "Elemento no encontrado"]
    [(reaccion? elem1 elem2)
     (string-append sim1 " + " sim2 " = " sim1 sim2 " Reacción Encontrada!")]
    [else
     (string-append sim1 " + " sim2 " No se encontró reacción")])))
```

La función ```experimentar``` es una función auxiliar para impirmir los resultados de la función ```mezcla``` en la consola.
Ya que se toma la mayor complejidad del sistema esta función es ```O(n)``` en el peor y en el caso promedio y ```O(1)``` en el mejor de los casos.

```
(define (experimentar elem1 elem2)
  (displayln (mezcla elem1 elem2)))
```

# Complejidad 
Tras analizar en sistema por completo se puede determinar que en el peor caso será ```O(n)``` suponiendo que recorrió la lista completa "n" cantidad de veces.

Igualmente en el caso promedio será ```O(n)``` suponiendo que recorrió la lista "n" cantidad de veces.

Finalmente en el mejor de los casos será ```O(1)```  suponiendo que el elemento buscado sea el primero de la lista por lo que no habrá necesidad de recorrer la lista.

# Casos prueba

## Conclusión
La complejidad del sistema es de O(n) principalmente por la necesidad de revisar la lista de elementos en busca del elegido, así mismo también la lógica del programa permite que también se pueda desarrollar un algoritmo un poco más robusto por medio del paradigma lógico, pero la ventaja de hacerlo en el paradigma funcional es que podemos hacer mayores mezclas sin necesidad de añadir una por una, podemos añadir nuevos elemenots al sistema en la lista.
Así mismo se cumple el objetivo del sistema ya que de esta forma los alumnos pueden descubrir que pueden combinar de reacciones químicas sin necesidad de asistir al laboratorio.
