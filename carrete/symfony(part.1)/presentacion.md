

layout: true

class: center, middle, inverse
---

# Proyecto Symfony 5.0 (Parte 1)

---
layout: true
class: animated fadeInUp
---

## Agenda

(Tiempo estimado: 4h)

* Conceptos
    - Flujo de información en Symfony
    - Estructura de directorio en Symfony
    - Carpetas y archivos destacados
    - Instalación core de Symfony
    - Consola Symfony 
        - `symfony console` vs `php bin/console`
* Inicio de proyecto `Symfony 5.5`
    - Symfony `new project`
    - Concepto de `composer` para instalar librería
    - Archivos de configuracion `.env` y `.env.local`
    - Utilizar `Docker` para la BD y el servidor WEB
    - Archivo `.htaccess`
    - Crear `database`
    - Caracteristicas del negocio del proyecto
    - Creación `controlador` y `template` con un HolaMundo 

---

## Agenda

* Boostrap template
    - Armar el HOME del Frontoffice y Backoffice
    - Creacion de las estructura de tablas
* Creando un proyecto a partir de un modelo de negocio
    - Presentacion de modelo de negocio
    - Entidad, Controlador y vista de `Estado`
    - Concepto de `Fixture`
    - Incluir mensaje en la vista
    - Concepto de traduccion y modulo `translations`
    - Creación de los ABM producto (show, edit, delete, new)     

---

# Symfony

* .texto-grande[Básicamente Symfony lo que hace es jugar con el servicio HTTP que todos conocemos.]

* .texto-grande[Symfony entra en la preparación de esa respuesta, y tiene la peculiaridad que aporta una estructura Modelo Vista Controlador que hace que el desarrollo sea bastante escalable.]

* .texto-grande[Toda su documentacion es publica y puede accederse desde  [Symfony](https://symfony.com/) ]  

---

# Symfony:  Versiones

`v6.1.4` Version stable: Requiere PHP 8, recomendado para muchos usuarios e incluye funcionalidades futuras.
`v5.4.12` Version con soporte a largo plazo: Requiere PHP 7, 3 años de soporte y no incluye funcionalidades futuras. 

.pull-center[
   ![:scale 55%](./img/release.png)
]


---
# Symfony

## Flujo de symfony 

.pull-center[
   ![:scale 100%](./img/symfony_flujo.webp)
]

---

# Symfony: Estructura de carpetas y archivos  

.pull-center[
   ![:scale 110%](./img/symfony5folders.png)
]

---

# Symfony 

## Estructura de directorio

* `tests`: Donde se guardan los test de la aplicacion
* `templates`: Se guardan las plantillas .twig que correponde a las vistas del proyecto
* `config`: Se guardan todas las configuraciones del proyecto 
* `src`: Mantiene lo archivos fuentes del proyecto (entidades, controladores, etc)
* `var`: Archivos temporales como log, cache, cola de correo.
* `public`: Todo los archivos web.
* `vendor`: Librerías de Symfony.
* `translations`: Se configuracion las traducciones del sitio y confguraciones de mensajería.

---

# Symfony 

# Archivos importantes

* `.env`: Configuraciones del ambiente como protocolos de mail, base de datos, tipo de entorno, etc
* `.env.local`: Configuraciones del ambiente local como protocolos de mail, base de datos, tipo de entonrno, etc
* `config/parameters.yaml`: Contiene las configuracion del negocio del proyecto
* `config/routing.yaml`: Mapeo de direcciones
* `public/.htacces.`: Configuración de reglas para el servidor host (redireccionamientos, restricciones, etc) 
* `src/Kernel.php`: Nucleo del framework
* `templates/global/base.html.twig`: Base de los templates, suelen escribirse los header de los html. 
* `var/log/dev.log`: Log del sistema para el entorno de desarrollo, test ó produccion.

---

# Symfony

## Consola Symfony

La consola de symfony  nos simplifica  el uso de la herramienta con diferentes comandos disponibles para generar codigo, tablas y datos pruebas en forma rapida.

```markdow
$ curl -sS https://get.symfony.com/cli/installer | bash
```
Puede pasar que necesites exportar el comando para utilizar en diferente consola

```markdow
$ export PATH="$HOME/.symfony5/bin:$PATH"

Or 

$ mv /Users/weaverryan/.symfony/bin/symfony /usr/local/bin/symfony
```
Luego ejecutar comando para verificar su instalación

```bash 
$ symfony --v
```

---

# Symfony

## Consola Symfony

Esta herramienta es solo sugerencia, por otro lado puede utilizar la herramienta que otorga smfony 

* Desde el propio proyecto tenemos la carpeta bin donde se puede acceder a los comando con la siguietne sintaxis

 `php bin/console [comando] [opciones]` 

Pueden acceder a toda la información  con el siguiente comando  `php bin/consola list`. Ver mas informacion en [Console Commands](https://symfony.com/doc/current/console.html)

---

# Creacion de proyecto

## `Symfony` 

```bash
$ symfony new my_project_name --version="5.1" 
```

## `Composer`

Instalar composer `sudo apt-get install composer` (recomendable)

```bash
composer create-project symfony/skeleton project-temp_5.1-7
composer create-project symfony/website-skeleton project-temp_5.1-7
composer create-project symfony/website-skeleton project-temp_5.1-7 5.1.*
```

[Fuente](https://symfony.com/doc/5.x/setup.html#creating-symfony-applications) 


---
# Inicio de proyecto

Configurar [.env](./doc/.env) con los ambientes y conección a base de datos. 

```markdow
###> symfony/framework-bundle ###
## Conviene generar uno diferente por ambiente.
APP_ENV='dev'

###> doctrine/doctrine-bundle ###
DATABASE_URL=mysql://ososa:ososa123@localhost:3306/temp7

###> symfony/swiftmailer-bundle ###
MAILER_URL=smtp://mail.psasender.com.ar:587?username=senderauth@psasender.com.ar&password=92ADvi!YV8r
###< symfony/swiftmailer-bundle ###
```

En ocasiones se deja configurado en `.env.local` para trabajar en modo desarrollo en su maquina local

---

# Inicio de proyecto

## Correr el base de datos y el servidor Web

Teniendo las imagenes que corresponden en los [Docker Hub](https://hub.docker.com/)
Subimos al proyecto el [docker-composer.json](./doc/docker/docker-compose.yml) 

```json

services:
  database:
    image: ososa2022/mariadb-10.2.7:1.0.2
    network_mode: host
    environment:
      MYSQL_ROOT_PASSWORD: **3d@x**
      MYSQL_USER: ososa
      MYSQL_PASSWORD: ososa123
      MYSQL_DATABASE: temp7
    restart: unless-stopped
    //..
  web:
    image: ososa2022/php-symfony-8.1.0:1.0.1
    //..
volumes:
  mariadb_local_volume:
    driver: local
```

---

# Inicio de proyecto

## Creo la base de datos en base a la configuración (opcional)

En el caso que no tengamos la base de datos se debe ejecutar el siguiente comando. 

En nuestro caso, recordar, que la base de datos se genero por el Docker.

```markdow 
$ symfony console doctrine:database:create
Created database `temp` for connection named default
```

Finalizando, compruebo la base de datos creada

```markdow 
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| temp               |
+--------------------+
```

Es posible instalar el paquete `Doctrine ORM`  corriendo el comando `$ composer require symfony/orm-pack`
---

# Inicio de proyecto

## Visualizar aplicacion

Y vamos al navegar para ubicar nuestro sitio y su presentacion `https://localhost:8000/`:

.pull-center[
   ![:scale 65%](./img/symfony5.0.png)
]

---

# Inicio de proyecto

## Pagina inicial y router

Antes de comenzar debemos verificar la existencia de las siguientes carpetas. 

* **bin**: Contiene todos los script  de symfony como el uso de comandos de linea
* **config**: En esta carpeta se encuentran todos los archivos de configuracion, los por defecto el route.yaml y archivos de configuracion de todos los paquetes instalados (mailer, twig, translations, etc)
* **migrations**: En esta carpetas se encuentran  los archivos que se generan cuando se inicia el modelado de  la base de datos para luego migrar al motor correspondientes
* **public**: La carpeta raiz donde se encuentra en `index.php` y funcionara como enlace al publico. Tambien se econtraran los CSS y JS junto a las images que se uben al sitio.
* **src**: Carpeta de codigo fuente donde se ubicaran los controladores del modelo MVC. Contiene las carpetas `Entity`, `Repository`, `Service`, `Security` entre otras a medida que el proyecto va sumando funcionalidades.
* **templates**: Carpeta donde se ubicarion los `.twig ` correspondiente a los plantillas de la vista
* **vendor**: Aqui se instalaran los paquetes  necesario para el uso basico del sitio
* **translations**: Contiene todos los archivos de traducciones de texto, usado conmumente para declarar mensajes, resumir idiomas entre otras objetivos.

---

# Inicio de proyecto

## Pagina inicial y router

El paso siguiente es comprobar las rutas del proyecto con el siguiente comando: 

```markdow
$ symfony console debug:router
 -------------------------- -------- -------- ------ ----------------------------------- 
  Name                       Method   Scheme   Host   Path                               
 -------------------------- -------- -------- ------ ----------------------------------- 
  _preview_error             ANY      ANY      ANY    /_error/{code}.{_format}           
  _wdt                       ANY      ANY      ANY    /_wdt/{token}                      
  _profiler_home             ANY      ANY      ANY    /_profiler/                        
  _profiler_search           ANY      ANY      ANY    /_profiler/search                  
  _profiler_search_bar       ANY      ANY      ANY    /_profiler/search_bar              
  _profiler_phpinfo          ANY      ANY      ANY    /_profiler/phpinfo                 
  _profiler_search_results   ANY      ANY      ANY    /_profiler/{token}/search/results  
  _profiler_open_file        ANY      ANY      ANY    /_profiler/open                    
  _profiler                  ANY      ANY      ANY    /_profiler/{token}                 
  _profiler_router           ANY      ANY      ANY    /_profiler/{token}/router          
  _profiler_exception        ANY      ANY      ANY    /_profiler/{token}/exception       
  _profiler_exception_css    ANY      ANY      ANY    /_profiler/{token}/exception.css   
 -------------------------- -------- -------- ------ ----------------------------------- 

```

---

# Inicio de proyecto

## Pagina inicial y router

Ahora avanzamos creando un controlador y template con el siguiente comando:

```markdow
$ symfony console make:controller HolaMundo
created: src/Controller/HolaMundoController.php
created: templates/hola_mundo/index.html.twig

```
En este punto se crearon los correspondientes controladores y vista (template) 
![holamundo](./img/holamundo.png)
---

# Inicio de proyecto

## Pagina inicial y route

```yaml
 symfony console debug:router
 -------------------------- -------- -------- ------ ----------------------------------- 
  Name                       Method   Scheme   Host   Path                               
 -------------------------- -------- -------- ------ ----------------------------------- 
  _preview_error             ANY      ANY      ANY    /_error/{code}.{_format}           
  _wdt                       ANY      ANY      ANY    /_wdt/{token}                      
  _profiler_home             ANY      ANY      ANY    /_profiler/                        
  _profiler_search           ANY      ANY      ANY    /_profiler/search                  
  _profiler_search_bar       ANY      ANY      ANY    /_profiler/search_bar              
  _profiler_phpinfo          ANY      ANY      ANY    /_profiler/phpinfo                 
  _profiler_search_results   ANY      ANY      ANY    /_profiler/{token}/search/results  
  _profiler_open_file        ANY      ANY      ANY    /_profiler/open                    
  _profiler                  ANY      ANY      ANY    /_profiler/{token}                 
  _profiler_router           ANY      ANY      ANY    /_profiler/{token}/router          
  _profiler_exception        ANY      ANY      ANY    /_profiler/{token}/exception       
  _profiler_exception_css    ANY      ANY      ANY    /_profiler/{token}/exception.css   
  app_hola_mundo             ANY      ANY      ANY    /hola/mundo                        
 -------------------------- -------- -------- ------ -----------------------------------
```

---

# Inicio de proyecto

# Configura el archivos `htaccess`

El archivo `.htaccess` permite la modificación de la configuración específica para directorios individuales 
sin afectar la configuración global del servidor. Este archivo se debe llevar a la carpeta `public`

LLevar a public el archivo [.htaccess](./doc/rwriter/.htaccess) para ordenar los accesos 

```bash
   <IfModule mod_rewrite.c>
       RewriteEngine On
       RewriteCond %{HTTP:Authorization} ^(.*)
       RewriteRule .* - [e=HTTP_AUTHORIZATION:%1]   
       RewriteCond %{REQUEST_FILENAME} !-f
       RewriteRule ^(.*)$ index.php [QSA,L]
   </IfModule>
```
---

# Inicio de proyecto

## Pagina inicial y route

Desde la url onfigurada puedo acceder a `http://127.0.0.1:8000/hola/mundo`

.pull-center[
   ![:scale 65%](./img/hola_mundo.png)
] 

---

# Inicio del proyecto

## Construyo el controllador para el home del `Backoffice` y `Frontoffice` (uso de namespace)

1. Crear la carpetas `Backoffice` y `Frontoffice` sobre la carpeta `Controller`
1. Corro el siguiente comando `symfony console make:controller Index` y ubico el controlador
1. Luego enviar el `IndexController.php` generado al `Backoffice` en principio.

.pull-center[
    ![:scale 90%](./img/folder_backoffice.png)
]    

---

# Inicio del proyecto

## Construyo el controllador para el home del `Backoffice` y `Frontoffice` (uso de namespace)

Construir el PHP de la siguiente manera indicando el `namespace` para ubicar el fuente y su acceso.

```php
namespace App\Controller\Backoffice;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class IndexController extends AbstractController {
    /**
     * @Route("/backoffice", name="app_backoffice_index")
     */
    public function index(): Response
    {
        return $this->render('backoffice/index.html.twig', [
            'controller_name' => 'IndexController',
        ]);
    }
}
```

Utilizar el `namespace` para ubicar el controlador en otro nivel de carpeta.

---

# Creando un proyecto a partir de un modelo de negocio

## Presentacion del modelo de negocio 

El modelo de negocio se basaria en estas tres entidades. `Producto, Cliente y Ventas`. 

.pull-center[
   ![:scale 80%](./img/der.png)
]

[PlantUml](https://www.plantuml.com/plantuml/uml/NP3DQiCm48Jl-nI3Jscf3xtw56WR28MI4l80Gjec0baAqfeUGj-zbkKVuukqZ4Qpt-u-YOhIjOuS_mWa8DhhJM1iP2qsU2BjL4eunM0wBNY0O4s3enU-SYHurNA3iqJhhmJ3IKTxppyNyHIjxZq75vGGwhhk3pYRPFUKgtGBlwLYOqVDi6FXKdlkdq5_4yfRboIq7F4W32osiE3qITZmm7Yxm0wjaKH9jkHhIJqhnsbAFAuJpM1_p-uIS2-xQEQb7B9DZrZD35ZqozVn-_An6p-zJBRLH0K5c-QRMRARvkJgjK9Tetgk2ZWDvreUsMYyivQVigDClcTlkjRz0m00)

---

# Creando un proyecto a partir de un modelo de negocio

## Proyeccion en Symfony

Se presenta el siguiente modelo de negocio para modelar desde la herramienta. 

.pull-center[
   ![:scale 80%](./img/doctrine_image_1.png)
]

---

## Entidad `State`

Se comienza con esta entidad para construir el modelo porque es la que esta mas aislada.

En la construccion se debe tener en cuenta los nombres de los campos, tipo de campo y si son nullables. 

.pull-center[
   ![:scale 20%](./img/state.png)
]

En este caso se definen los siguientes campos. 

1. `name`: Campos del tipo string (texto) no vacio

---

## Entidad `State`

Para crear la entidad se debe utilizar `make:entity` y seguir las intrucciones, de la siguiente forma: 

```bash 
$ symfony console make:entity State

created: src/Entity/State.php
created: src/Repository/StateRepository.php

//...
New property name (press <return> to stop adding fields): name

Field type (enter ? to see all types) [string]:

Field length [255]:

Can this field be null in the database (nullable) (yes/no) [no]:

updated: src/Entity/State.php
Add another property? Enter the property name (or press <return> to stop adding fields):         
//..
```
---

## Entidad `State`

Si visualizamos el proeyecto se generan en `Entity` la clase `State.php` con sus get y set correspondientes

.pull-center[
   ![:scale 60%](./img/state-file.png)
]

---

## Entidad `State`

```php
namespace App\Entity;
use App\Repository\StateRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
/**
 * @ORM\Entity(repositoryClass=StateRepository::class)
 */
class State
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;
    /**
     * @ORM\Column(type="string", length=255)
     */
    private $name;
    //...
```

---

# Entidad `State`

Creo el migration con el comando `make:migration`

```bash
$ symfony console make:migration

    Next: Review the new migration "migrations/Version20230516002936.php"
    Then: Run the migration with php bin/console doctrine:migrations:migrate
```

Creo la tabla en BD con el comando `doctrine:migrations:migrate`

```bash
$symfony console doctrine:migrations:migrate

    [notice] Migrating up to DoctrineMigrations\Version20230516002936
    [notice] finished in 42.8ms, used 18M memory, 1 migrations executed, 1 sql queries
```
---

# Entidad `State`

Creo el archivo en `migrations` donde se guarda el archivo para su historia y la tabla en base de datos:  

.pull-left[
	![migration](./img/migration.png)
]

.pull-right[
![migration-db](./img/migration-db.png)
]

---

# Entidad `State`

Actualizar el `StateRespository.php` el metodo `findById` para buscar por ID

```php
    //...
    public function findById($id): ?State
    {
        return $this->createQueryBuilder('s')
            ->andWhere('s.id = :val')
            ->setParameter('val', $id)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    //..
```

---

## Entidad `State` 

Comenzando el uso de `fixture` para cargar registros iniciales de la entidad

Procedo a instalar el modulo `fisxture`

```yaml
composer require --dev doctrine/doctrine-fixtures-bundle
```

Esto debe generar en una carpeta `src/DataFixtures` con la clase `AppFixtures.php`
```php
// ...
class AppFixtures extends Fixture
{
    public function load(ObjectManager $manager): void
    {
        //...
    }
}
```
---

##  Entidad `state`

Genero un estado con `fixture` para la entidad `State`

```php
// ...
use App\Entity\State;
class AppFixtures extends Fixture{
    public function load(ObjectManager $manager): void {
        $state = new State();
        $state->setName('activo');
        $manager->persist($state);
        $manager->flush();
    }
}
```

Luego ejecuto el fixture en consola `php bin/console doctrine:fixtures:load --append`

.pull-center[
  ![:scale 25%](./img/fixture-data.png)
]

---


## Entity `State`

Genero el controlador con el comando  `make:controller` y recordar que luego de crear los controladores llevarlos al espacio correspondiente.

```markdow
symfony console make:controller State

created: src/Controller/StateController.php
created: templates/state/index.html.twig
```

```bash
//..
use App\Entity\State;

class StateController extends AbstractController
{
    /**
     * @Route("/backoffice/state", name="app_backoffice_state")
     */
    public function index(): Response
    {
        //...
    }
}
```

---

##  Entity `state` 

Agregar al controlador el metodo `list()`

En `StateController.php` debo crear el metodo `list` teniendo en cuenta los siguientes concepto.

* Incluir las `Entity`, en este caso las entidades `State` 
* En principio diseñamos la ruta y el nombre de la ruta (para uso interno del código)
* Creo una función `public` como respuesta un objeto `Response` 
* En esta función se usa el repositorio con la funciona `findAll()`
* Utilizo el template, en principio, `backoffice/state/list.html.twig` con sus parametros

```bash
//..
use App\Entity\State;

**
* @Route("/backoffice/state", name="app_backoffice_state_list")
*/
public function list(): Response { 
    $repository = $this->getDoctrine()->getRepository(State::class);
    $states = $repository->findAll();
    return $this->render('backoffice/state/list.html.twig', [
            'controller_name' => 'State List',
            'states'=>$states
    ]);   
}
```

---

## Entity `state`

Para una mejor vista agregar motor boostrap para el `backoffice` para el template con los siguientes paso tomado desde [NiceAdmin Publico](https://bootstrapmade.com/demo/NiceAdmin/) : 

Para poder integrar el framework de boostrap debemos seguir los siguientes pasos:

1. Llevar al `/public`  el template [Nice Admin](./doc/boostrap/backoffice.zip) y lo copio en `public`, con esta descarga tendremos un apartado para este estilo en la carpeta `backoffice`. 
1. Llevo el [Layout del Backoffice](./doc/template/plantillas/layout/backoffice/layout.zip) al `template`
1. Actualizo el archivo `template/backoffice/index.html.twig`.  

```bash
{% extends "backoffice/layout/backoffice_layout.html.twig" %}

{% block  content %}

<div class="container-fluid">
    <h1>Hello {{ controller_name }}!</h1>
</div>
{% endblock %}
```


---

## Entity `state`  

Genero el template para el `list()`

Modificar  el `templates/backoffice/state/list.html.twig` 

```php
{% extends 'backoffice/layout/backoffice_layout.html.twig' %}
{% block title %}Hello StateController!{% endblock %}
{% block content %}
<style>
    .example-wrapper { margin: 1em auto; max-width: 800px; width: 95%; font: 18px/1.5 sans-serif; }
    .example-wrapper code { background: #F5F5F5; padding: 2px 6px; }
</style>
<div class="example-wrapper">
    <h1>Hello {{ controller_name }}! ✅</h1>
   <table>
    <thead><th>ID</th><th>Nombre</th></thead>
    <tbody> 
        {% for state in states %}
            <tr>
                <td>{{ state.id }}</td>
                <td>{{ state.name }}</td>
            <tr>
        {% endfor %}
    </tbody>
</table>
</div>
{% endblock %}
```

---

## Entity `state`  

Copio los template de los Estados y Productos (con la que vamos a continuar).

Cuando verifiquemos que todo el `Framework del Boostrap`  este correctamente configurado vamos a colocar los restantes templates para el ABM estado y producto. 

1. Copio los templates [State](./doc/template/plantillas/backoffice/state/state.zip) en `templates/state`
1. Copio los templates [Product](./doc/template/plantillas/backoffice/product/product.zip) en `templates/product`

---

## Entity `state` 

Agrego las translations del template

Las `traducciones` se utiliza para unificar los terminos en diferente idiomas en base a una configuracion para eso se realiza las siguientes tareas.  

1. Configura el tranlations

Configurar el idioma por defecto `config/package/translations.yaml`

```yaml
framework:
    default_locale: es
    translator:
        default_path: '%kernel.project_dir%/translations'
        fallbacks:
            - es
```

1. Configurar los terminos en `translations` creando o copiando los documentos [Transaltions](./doc/translations/translations.zip)
1. Copio todo las tranlations correspondiente utilzados en los template agregar `tranlations/messages.es.yaml`

---

##  Entity `state` 

Configuro el `side bar` (menu principal) del template.

Ya teniendo el controlador y la entidad debemos empezar a codificar los metodos correspondientes. Teniendo en cuenta que ya tenemos el correspondiente controlador estaremos generando los correspondientes metodos.

Antes de hacer eso, ya que tenemos el controlador ProductController agrego en el archivo `templates/backoffice_sidebar.html.twig` el indice para acceder al listado de produccion

```html
<li class="nav-item">
    <a class="nav-link " href="{{ path('app_product_list') }}">
        <i class="bi bi-basket"></i>
        <span>Productos</span>
    </a>
</li><!-- End Dashboard Nav -->

//...

<td>
    <a href="{{ path('app_backoffice_state_delete', {'id': state.id}) }}" class="btn btn-danger disable-btn del-link" type="submit">
        <i class="bi bi-x-square"></i>
    </a>
</td>

//..

```

---

##  Entity `state` 

Agregar el mensaje en el template base.

En el templete base `/templates/base.html.twig` agrega el siguiente div para los mensaje de exito 

```markdown
<body>
//...
{% for message in app.flashes('success') %}
<div class="alert alert-success ml-10" style="margin-left:20px; margin-right:20px">
    {{ message }}
</div>
{% endfor %}
{% for message in app.flashes('error') %}
<div class="alert alert-danger ml-10" style="margin-left:20px; margin-right:20px">
    {{ message }}
</div>
{% endfor %}
//..
```

Desde el controlador puedo utilizar estos mensaje de la siguiente manera

```php
//..
$this->addFlash('success','Mensaje de exito..');
//..
```

---

## Entity `state`

Agregar al controlador el metodo `show()`

```php
/**
* @Route("/backoffice/state/show/{id}", name="app_backoffice_state_show")
*/
public function show($id): Response
{
    $repository = $this->getDoctrine()->getRepository(State::class);
    $state = $repository->findById($id);
    $message = '';
    if(!$state){   
        $message = "El estado no existe.";
    }
    return $this->render('backoffice/state/show.html.twig', [
        'controller_name' => 'Show State',
        'state'=>$state, 
        'message'=> $message
    ]);
}
```

Recordar siempre crear el método `getById()`en el repostorio.

---

## Entidad `Product`

Creo la base de datos y la siguiente entidad `Product` con los campos `Name, Descripcion, Price` con el tipo, tamaño y nulabilidad . 

Además teniendo en cuenta que un producto puede tener solo un estado se debe crear la relacion  `State` a `Product` de `OneToMany`.

.pull-center[
   ![:scale 25%](./img/product.png)
]

---

## Entidad `Product`

Se debe indicar los nombres de los campos, tipo de campo y si es nullable. 

```markdow 
$ symfony console make:entity Product

New property name (press <return> to stop adding fields):
 > name

 Field type (enter ? to see all types) [string]:
 > 

 Field length [255]:
 > 

 Can this field be null in the database (nullable) (yes/no) [no]:
 > 
 updated: src/Entity/Customer.php

```

---

## Entidad `Product`

Los tipos de relation determina las cardinalidad

```markdow 
 Add another property? Enter the property name (or press <return> to stop adding fields): state
 Field type (enter ? to see all types) [string]: relation
 What class should this entity be related to?: State

What type of relationship is this?
 ------------ --------------------------------------------------------------------- 
  Type         Description                                                          
 ------------ --------------------------------------------------------------------- 
  ManyToOne    Each Product relates to (has) one State.                            
               Each State can relate to (can have) many Product objects            
                                                                                    
  OneToMany    Each Product can relate to (can have) many State objects.           
               Each State relates to (has) one Product                             
  //..               
 ------------ --------------------------------------------------------------------- 
 Relation type? [ManyToOne, OneToMany, ManyToMany, OneToOne]:
 > ManyToOne

```

---

## Entidad `Product`

* Se debe decidir si el campo state_id debe ser null o no 
* En el objeto State se puede agregar los metodos  `getProducto`,  `addProduct` y `removeProduct`.
* También se puede decidir si al eliminar un estado se puede decidir que hacer con los productos.

```bash
Is the Product.state property allowed to be null (nullable)? (yes/no) [yes]: no

 Do you want to add a new property to State so that you can access/update 
 Product objects from it - e.g. $state->getProducts()? (yes/no) [yes]: yes
 A new property will also be added to the State class so that you can access the related Product objects from it.
 New field name inside State [products]: 
 Do you want to activate orphanRemoval on your relationship?
 A Product is "orphaned" when it is removed from its related State.
 e.g. $state->removeProduct($product)
 
 NOTE: If a Product may *change* from one State to another, answer "no".

 Do you want to automatically delete orphaned App\Entity\Product objects (orphanRemoval)? (yes/no) [no]: 

```
---

## Entidad `Product`

.pull-center[
   ![:scale 50%](./img/prod-state.png)
]

---

## Entidad `Customer`

.pull-center[
   ![:scale 50%](./img/customer.png)
]

---

## Entidad `Customer`

Se debe indicar los nombres de los campos, tipo de campo, si es nullable. 

```bash 
$ symfony console make:entity Customer
 created: src/Entity/Customer.php
 created: src/Repository/CustomerRepository.php
 
 Entity generated! Now let's add some fields!
 You can always add more fields later manually or by re-running this command.

 New property name (press <return> to stop adding fields):
 > name
 Field type (enter ? to see all types) [string]:
 > 
 Field length [255]:
 > 
 Can this field be null in the database (nullable) (yes/no) [no]:
 > 
 updated: src/Entity/Customer.php

```

---

## Entidad `Sales`

.pull-center[
   ![:scale 50%](./img/sales.png)
]

1. A Customer :  `ManyToOne` (un cliente puede hacer muchas ventas) 
2. A Product es de `ManyToOne` (un producto puede estar en muchas ventas)

```markdow 
$ symfony console make:entity Sales
```

---

## Entidad `Sales`

Crear los archivos para la migracion y crear las entidades en la base de datos.

```yaml
$ symfony console make:migration
$ symfony console doctrine:migrations:migrate
```

Se genera en un nuestra base de datos la siguiente estructura

.pull-center[
   ![:scale 50%](./img/der-all.png)
]


## Entity `Product`

Recordar que luego de crear los controladores llevarlos al espacio correspondiente

```markdow
symfony console make:controller Product

created: src/Controller/ProductController.php
created: templates/product/index.html.twig
```

---

## Entity `Product`

En `ProductController.php` debo crear el metodo `list` teniendo en cuenta los siguientes concepto.

* Incluir las `Entity`, en este caso las entidades `Product` y `State`
* En principio diseñamos la ruta y el nombre de la ruta (para uso interno del código)
* Y finalmente creo una funcion `public` como respuesta un objeto `Response` 

```markdow
use App\Entity\Product;
use App\Entity\State;

**
* @Route("/backoffice/product/list", name="app_bacjkoffice_product_list")
*/

public function list(): Response {   
       [.....]
}

```
---

## Entity `Product`

Template `product::list()`

```php
/**
* @Route("/backoffice/product/list", name="app_backoffice_product_list")
*/
public function list(){
    $repository_product = $this->getDoctrine()->getRepository(Product::class);
    $products = $repository_product->findAll();
    return $this->render('backoffice/product/list.html.twig', [
        'controller_name' => 'List',
        'productos'=>$products
    ]);
}
```
---

## Entity `Product`

Template `List Product`

```php
<table>
<thead><th>Nombre</th><th>Descripcion</th><th>Precio</th><th>Estado</th></thead>
<tbody>
    {% if productos ?? false %}   
    {% for producto in productos %}
        <tr>
        <td>{{ producto.name}}</td>
        <td>{{ producto.description}}</td>
        <td>{{ producto.price}}</td>
        <td>{{ producto.state.name}}</td>
        <td>
    {% endfor %}
    {% endif %}
</tbody>
```
---

## Entity `Product`

Controller `Product`: Metodo new()

Debo crear el metodo `new` teniendo en cuenta los siguientes concepto.

* Incluir las `Entity`, en este caso las entidades `Product` y `State`
* En principio diseñamos la ruta y el nombre de la ruta (para uso interno del código)
* Y finalmente creo una funcion `public` como respuesta un objeto `Response` 

```markdow
use App\Entity\Product;
use App\Entity\State;

**
* @Route("/backoffice/product/new", name="app_bacjkoffice_product_new")
*/

public function new(): Response {   
       [.....]
}

```

---

### Entity `Product`

Controller `Product`: Metodo new()

Para continuar debemos tener en cuenta que nuestro metodo va llamarse en dos ocasiones, cuando se presenta el formulario y cuando recibo la informacion luego de haber echo el `submit`. 
```php
//...

use App\Entity\State;

public function new(): Response {

    //Llamo a todos los State para ponerlo en el formularios
    $repository=$this->getDoctrine()->getRepository(State::class);
    $states=$repository->findAll();
    
    if(isset($_POST['submit'])){
        //...
    }
    return $this->render('backoffice/product/new.html.twig', [
                'controller_name' => 'New.',
                'states'=>$states
    ]);
}
```
Donde el bloque dentro del IF procesara lo enviado. Por fuera del IF es el flujo para presentar el formulario.

---

### Entity `Product`

Controller `Product`: Metodo new()

Queda decidir que se debe hacer para registrar el producto. Para ello se debe hacer las siguientes acciones: 

1. Obenter ambos `Repository` de `Product` y `State`
1. Obtener un objeto `State` en base al codigo recibido
1. Instanciar `Product`

```php
    //....
        $repository_state=$this->getDoctrine()->getRepository(State::class);
        if(isset($_POST['submit'])){
           //..
        } else {
            $states=$repository_state->findAll();
        }
        return $this->render('backoffice/product/new.html.twig', [
                    'controller_name' => 'New.',
                    'states'=>$states
        ]);
    //....
```

---

##  Entity `Product`

Controller `Product`: Metodo new()

1. Instanciar `Product`
1. Seteo los valores del producto (name,description,price y state)
1. Agrego el producto con el metodo `add` del propio `Repository` de producto
1. Retorno a una pagina puntual con el alias de la ruta

```php
    //....
    if(isset($_POST['submit'])){
        //Lee el estado
        $state = $repository_state->findById($_POST['pstate']);
        $product = new Product();
        $product->setName($_POST['pname']);
        $product->setDescription($_POST['pdescription']);
        $product->setPrice($_POST['pprice']);
        $product->setState($state);

        //Agrega el producto
        $repository_product=$this->getDoctrine()->getRepository(Product::class);  
        $repository_product->add($product);
        return $this->redirectToRoute("app_backoffice_product_list");
    }       
    //...
```


---

## Entity `Product`

Template `New Product`

Un template con extension `.twig`  se creara en la carpeta template dentro del directorio correspondiente con la siguientes caracteristicas: 

```html
{% extends 'backoffice/layout/backoffice_layout.html.twig' %}

{% endblock %}
```

El template debe contener `{% extends %}` para incluir el template base y `{% block %}{% endblock %}` donde se formara el propio `HTML`

---

## Entity `Product` 

Controller `Product`: Metodo edit()

```php
/**
* @Route("/backoffice/product/edit/{id}", name="app_backoffice_product_edit")
*/
public function edit($id): Response
{
    $repository_product = $this->getDoctrine()->getRepository(Product::class);
    $repository_state = $this->getDoctrine()->getRepository(State::class);
    $product = $repository_product->findById($id);

    if(isset($_POST['submit'])){
        //...
    } else {
        if(!$product){
            $this->addFlash('error', 'El producto no existe');
            return $this->redirectToRoute("app_backoffice_product_list");
        }
        $state=$product->getState();
        $states=$repository_state->findAll(); 
        return $this->render('backoffice/product/edit.html.twig', [
            'controller_name' => 'Edit',
            'product'=>$product,
            'product_state'=>$state->getId(),
            'states'=>$states
        ]);
    }
}
```

Recuerda activar el `getById()` del repositorio.

---

## Entity `Product`

Controller `Product`: Metodo edit()

```php
/**
* @Route("/backoffice/product/edit/{id}", name="app_backoffice_product_edit")
*/
public function edit($id): Response
{
    $repository_product = $this->getDoctrine()->getRepository(Product::class);
    $repository_state = $this->getDoctrine()->getRepository(State::class);
    $product = $repository_product->findById($id);

    if(isset($_POST['submit'])){
        $state = $repository_state->findById($_POST['pstate']); 
        $product->setName($_POST['pname']);
        $product->setDescription($_POST['pdescription']);
        $product->setPrice($_POST['pprice']);
        $product->setState($state);
        $repository_product->add($product);
        return $this->redirectToRoute("app_backoffice_product_list");
    } else {
       //...
    }
}
```


---

## Entity `Product` 

Template ` Edit Product`: Estructura del formulario (sin en el estado)

```html
//...
<form action="{{ path('app_backoffice_product_edit',  {'id': product.id}) }}" method="POST">
    <label for="pname">Nombre:</label><br>
    <input type="text" id="pname" name="pname" value="{{ product.name }}"><br>
    <label for="lname">Descripción:</label><br>
    <input type="text" id="pdescription" name="pdescription" value="{{ product.description }}"><br>
    <label for="pprice">Precio:</label><br>
    <input type="text" id="pprice" name="pprice" value="{{ product.price }}"><br><br>
    <input type="submit" name="submit" value="Submit">
</form> 
//..
```
---

## Entity `Product`

Template ` Edit Product`: Estructura del formulario (con el estado)

```html
//...
<form action="{{ path('app_backoffice_product_edit',  {'id': producto.id}) }}" method="POST">
    //...
    <select name="pstate">
        {% for state in states %}
            <option value="{{state.id}}">{{state.name}}</option>
        {% endfor%}
    </select><br><br>
    //...
</form> 
//...
```
---

## Entity `Product` 

Template ` Edit Product`: Estructura del formulario (con el estado seleccionado)

```html
//...
<form action="{{ path('app_backoffice_product_edit',  {'id': producto.id}) }}" method="POST">
    //...
     <select name="pstate">
            {% for state in states %}
                {% if state.id == product_state  %}
                    <option selected="true" value="{{state.id}} ">{{state.name}}</option>
                {% else %}
                    <option value="{{state.id}} ">{{state.name}}</option>    
                {% endif %}    
            {% endfor%}
        </select><br><br>
    //...
</form> 
//...
```
---

## Entity `Product` 

Controller `Product`: Metodo delete()

```php
/**
 * @Route("/backoffice/product/delete/{id}", name="app_backoffice_product_delete")
 */
public function delete($id): Response
{
    $repository_product = $this->getDoctrine()->getRepository(Product::class);
    $product = $repository_product->findById($id);     
    
    if($product){
        if(!$repository_product->remove($product))
            $this->addFlash('success', 'El producto se elimino correctamente.');  
        else
            $this->addFlash('error',"El producto no se pudo eliminar." );    
    } else {
        $this->addFlash('error','El producto no existe');
    }
    
    return $this->redirectToRoute("app_backoffice_product_list");
}
```

---

##  Entity `Product`

Controller `Product`: Metodo show()

```php
**
* @Route("/backoffice/product/show/{id}", name="app_backoffice_produc_show")
*/
public function show($id): Response
{
    $repository_product = $this->getDoctrine()->getRepository(Product::class);
    $product = $repository_product->findById($id);
    $message = '';
    if(!$product){   
        $message = "El producto no existe";
    }
    return $this->render('backoffice/product/show.html.twig', [
        'controller_name' => 'Show',
        'producto'=>$product, 
        'message'=> $message
    ]);
}
```
---

## Entity `product` 

Template ` Show Product`

```html
//..
{{ message }}
{% if producto %}
    <div class="example-wrapper">
        <label>Nombre: {{producto.name}}</label><br>         
        <label>Descripcion: {{producto.description}}</label><br>  
        <label>Precio: {{producto.price}}</label><br>   
        <label>Estado: {{producto.state.id}}</label><br>  
    </div>
{% endif %}
//...
```
---

# Referencias

* [How to Build a Login Form](https://symfony.com/doc/5.2/security/form_login_setup.html)
* [Security](https://symfony.com/doc/5.2/security.html)

---
class: center, middle, inverse

## Gracias!

