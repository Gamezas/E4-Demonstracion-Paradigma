# Simulador de reacciones químicas
## Paradigma funcional
## Alejandro Adrián García Martínez
## Descripción
Este software busca simular la creación de reacciones químicas con un objetivo didáctico, siguiendo reglas sencillas.
El software está diseñado en Racket y busca demostrar una solución a un problema pro medio del paradigma funcional.
No todos los colegios tienen la oportunidad de asistir a un laboratorio a realizar pruebas para ver las reacciones químicas que existen en nuestro día a día, por lo que muchos profesores dan estos temas de forma rápida sin profundizar y sin dar la oportunidad a los alumnos de experimentar por si mismos. Este simulador busca permitir a los alumnos experimentar con diferentes elementos y ver qué reacciones químicas se pueden crear y cuáles no.

## Diseño
El programa se dieño para Racket.
Primeramente se utiliza la función ``` struct ``` que nos permite generar un "molde" o constructor de nuestro elementos para el simulador, de esta forma podemos acceder a sus propiedades como nombre, símbolo o tipo con mayor facilidad.

```
(struct elemento (simbolo nnombre tipo))
```

Generamos una lista donde almacenaremos todos nuestro elementos generados
```
(define elementos (list
                   (elemento "Fe" "Hierro" "Metal")
                   (elemento "C" "Carbono" "No Metal")
                   (elemento "Cu" "Cobre" "Metal")
                   (elemento "Na" "Sodio" "Metal")
                   (elemento "Cl" "Cloro" "No Metal")
                   (elemento "O" "Oxígeno" "No Metal")))
```

La función ```buscar``` nos permite encontrar un elemento deseado en base a su símbolo, de esta forma tabién podemos saber su tipo, aquí mismo hacemos uso de la función lambda que hace la búsqueda asegurandose que sea un string con ```string=?``` y de ```findf```.
findf nos permite hacer uso de un "find-first" con el cúal podemos tomar la primera instancia que s eparezca a lo que estamos buscando y como los símbolos no se repiten es de bastante utilidad, el único porblema es que hace que la complejidad del programa sea de O(n) ya que le toma 'n' cantidad de veces pasar por la lista hasta encontrar el elemento correcto.
```
(define (buscar simbolo)
  (findf (lambda (elem) 
           (string=? (elemento-simbolo elem) simbolo))
         elementos))
```

La función ```reaccion?``` permite comprobar la regla más importante del sistema que es que las reacciones químicas ocurren entre metales y no metales, al contrario de por ejemplo las aleaciones que son entre metales y metales. 
```
(define (reaccion? elem1 elem2)
      (if (or (and (string=? (elemento-tipo elem1) "No Metal") 
                   (string=? (elemento-tipo elem2) "No Metal"))
              (and (string=? (elemento-tipo elem1) "Metal") 
                   (string=? (elemento-tipo elem2) "Metal")))
          #f
          #t))
```

La función ```mezlca``` nos ayuda a llamar las funciones anteriores en orden y llevar acabo el funcionamiento del sistema, también es el que regresa a consola el resultado de nuestro experimento químico por medio de un condicional, que identifica si el elemento elegido existe o fue encontrado, si la reacción puede ocurrir y si no. En caso de que la reacción pueda ocurrir nos mostrara la combinación de la reacción con los símbolos correspondientes.
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

La función ```experimentar``` nos permite imprimir los resultados de ```mezcla``` en consola
```
(define (experimentar elem1 elem2)
  (displayln (mezcla elem1 elem2)))
```

## Conclusión
La complejidad del sistema es de O(n) principalmente por la necesidad de revisar la lista de elementos en busca del elegido, así mismo también la lógica del programa permite que también se pueda desarrollar un algoritmo un poco más robusto por medio del paradigma lógico, pero la ventaja de hacerlo en el paradigma funcional es que podemos hacer mayores mezclas sin necesidad de añadir una por una, podemos añadir nuevos elemenots al sistema en la lista.
Así mismo se cumple el objetivo del sistema ya que de esta forma los alumnos pueden descubrir que pueden combinar de reacciones químicas sin necesidad de asistir al laboratorio.
