#lang racket

;; Struct permite crear una plantilla/constructor para los elementos
(struct elemento (simbolo nnombre tipo) #:transparent)

;;Lista de los elementos del simulador, al tenerlo en lista es más facil revisarlo
(define elementos (list
                   (elemento "Fe" "Hierro" "Metal")
                   (elemento "C" "Carbono" "No Metal")
                   (elemento "Cu" "Cobre" "Metal")
                   (elemento "Na" "Sodio" "Metal")
                   (elemento "Cl" "Cloro" "No Metal")
                   (elemento "O" "Oxígeno" "No Metal")))


;; Buscar elemento por símbolo con findf (find-first)
(define (buscar simbolo)
  (findf (lambda (elem) 
           (string=? (elemento-simbolo elem) simbolo))
         elementos))

;; Identifica que pueda haber una reacción, debe ser un Metal + No Metal, no se puede Metal + Metal ni No Metal + No Metal
(define (reaccion? elem1 elem2)
      (if (or (and (string=? (elemento-tipo elem1) "No Metal") 
                   (string=? (elemento-tipo elem2) "No Metal"))
              (and (string=? (elemento-tipo elem1) "Metal") 
                   (string=? (elemento-tipo elem2) "Metal")))
          #f
          #t))

;; Mezcla de los 2 elementos elegidos de la lista
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

;; Función principal
(define (experimentar elem1 elem2)
  (displayln (mezcla elem1 elem2)))