Silavan Castillo
Laura Daza

Arquitectura:

Se eligio esta arquitectura de la red debido a que queriamos que se pudiera entrenar rapidamente y basandonos en la red neuronal VGG
se realizaron disminuciones en cantidad de filtros y batches, ademas de aumento de stride en una capa.

Nuestra red consiste de 7 capas + softmax: 
Inicialmente la red recibe imagenes de tamaño 128x128 y realiza una convolución con 10 filtros de 5x5.
Luego reduce el tamaño a la mitad (realizando un pooling) para realizar ese mismo procedimiento (convolucion) pero ahora con 25 filtros nuevos, 
en ese paso tambien se realiza un submuestreo reduciendo el tamaño de las imagenes otra vez a la mitad (eso se hace con el stride de 2).
Despues nuevamente se realiza un pooling para reducir el tamaño de la imagen y otra convolución normal ahora con 10 filtros.
Luego de esto, si se le aplica la no linearidad y viene una ultima capa de convolución que disminuye el numero de filtros a 25, que es el numero de categorias (texturas).
Para finalmente hacer un softmax que predece la etiqueta (da la categoria con mayor probabilidad de corresponder con la imagen). 

[Architecture](https://raw.githubusercontent.com/luiscarm9/lab_vision/master/lab8_cnn/red.PNG)

Resultados:
La red se demoro 3,7 horas (13347,72 segundos) en entrenar 15 epocas. Asumimos que en la GPU se demorara menos por lo que aumentamos a 20 epocas
el archivo subido.


the results you got on the training and validation sets
