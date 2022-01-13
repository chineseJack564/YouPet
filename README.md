# grupo-77

## Link: http://grupo77.herokuapp.com

## Consideraciones iniciales:

* Vienen dos cuentas creadas: ```1@uc.cl``` con clave ```123456``` y ```2@uc.cl``` con clave ```123456```. También vienen 2 elementos iniciales de cada entidad ya creada.

* Admin: ```admin@example.com``` con clave ```password```

## Actualizaciones:

* Chat en tiempo real
* Api con google maps para direccion de entrega, ahora para crear un post, se debe entregar las coordenadas de direccion sacados en google maps.
* Navegacion completa 
* Css implementado
* Review restringido a solo personas con interaccion, una vez que termina el order.
* Chat restringido a solo personas con interaccion, se debe haber aceptado order para poder hablar y una vez creada el chat, se puede hablar para siempre.

## Admin
* Implementado con active admin 

## Devise User:

* Las cuentas se desactivan, no son eliminadas. A futuro un ```admin``` puede intervenir en esto.

* Con dos ```users``` registrados, se pueden probar todas las funcionalidades

* ```Phone``` opcional pero valida regex de forma *+569XXXXXX* (8 dígitos). Imágen (```avatar```) opcional. ```username``` y ```email``` deben ser únicos. ```email``` debe ser de la forma *X@X.X*.

* En login user, hay una opcion para dirigirse hacia login de admin.

* Incluido perfil user, se ingresa desde userlist para visualizar. Tambien se puede revisar los perfiles

## CRUD Post:

* Solo se puede crear/editar/eliminar cuando el ```user``` ha iniciado sesión. Sin iniciar, sólo se puede ver.

* Implementado busqueda de post por titulo

## CRUD Order:

* Las ```orders``` asociadas a un post sólo pueden ser vistas por el creador del ```post```, y el creador del order puede ver sus propias ```orders```.

* Un ```user``` no tiene la opción de hacer una ```order``` sobre su mismo ```post```.

* Ahora se puede aceptar un order, cuando se acepta un order, todos los resto se rechaza automaticamente(debido a que se trata de animales, todos los posts no debe poder tener varios orders)

## CRUD Comentario:

* Se pueden ver los ```comments``` sin iniciar sesión. Para crear uno nuevo, se debe iniciar sesión.

* Los ```comments``` ya tienen asigando su ```user``` pero aún no son parte de un ```post```, es decir, son un módulo aparte.

* Ahora el dueño de post se puede responder a un commentario

## CRUD Mensaje:

* Para mandar un ```message```, se debe seleccionar la lista de usuarios ```All Users```. Luego, hay un link para mandar un ```message``` para el ```user``` deseado de la lista. Aquí se abre el chat con dicho ```user``` y muestra ```messages``` pasados, editables y eliminables sólo si es un ```message``` propio.


## CRUD Review:

* Para hacer un ```review```, se debe seleccionar la lista de usuarios ```All Users```. Luego, hay un link para crear un nuevo ```review``` para el user deseado de la lista. Si el ```review``` es válido, será publicado en el link de ```All Reviews```.

## CRUD Reply:
## Notificaciones:

* Se puede abrir/cerrar notificaciones seleccionando la barra negra a la derecha o presionando el boton con la campanita.

* Un ```message```/```order```/```review``` eliminado no desaparece de las notificaciones, pero su contenido cambia a *(deleted)*. Sólo ```message``` puede redireccionar al chat existente, ```order```/```review``` redireccionan al ```index```.
