# Proyector

__Proyector__ es un proyecto que busca simplificar la producción y el mantenimiento de presentaciones mediante el uso de [Markdown](https://es.wikipedia.org/wiki/Markdown), [Remark.js](https://github.com/remarkjs/remark) y [Animate.css](https://daneden.github.io/animate.css/).

La idea central es que preparar una presentación con diapositivas sea trivial y que las presentaciones puedan ser proyectadas con o sin acceso a internet (exceptuando claro los enlaces externos.)

## Instalacion

```bash
git clone $PROJECT_URL
```

## Ejecucion Local

Para la ejecución local es necesario contar con una consola bash y python instalado.
Dentro de la carpeta raiz del proyecto se puede proyectar ejecutando:

```bash
./bin/proyectar.sh
```

## Integracion continua y publicación

* Los commmits a `development` quedan disponibles en http://dev.funcional.g.psa.com.ar
* Los commmits a `master` quedan disponibles en http://doc.funcional.g.psa.com.ar