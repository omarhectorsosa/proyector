#!/bin/bash

## Detectar version mayor

PYTHON=`which python`
PROJECTOR_FOLDER="./proyector"

if [ ! -d ${PROJECTOR_FOLDER} ]; then
    echo "No se encontró la carpeta «${PROJECTOR_FOLDER}». Asegurate de estar en la raiz del proyecto."
    exit 3
else
    cd ${PROJECTOR_FOLDER}    
fi

if [ -z "${PYTHON}" ]; then
    echo "No se encontró python instalado en el sistema."
    exit 1
else
    PYTHON_MAJOR_VERSION=`${PYTHON} -c "import sys;print(sys.version_info.major)"`
fi

case ${PYTHON_MAJOR_VERSION} in
    2)      
        echo "Python 2 detectado..."
        python -m SimpleHTTPServer
        ;;
    3)  
        echo "Python 3 detectado..."
        python -m http.server 
        ;;
    *)
        echo "No se pudo detecar la version de python."
        exit 2
esac

exit 0

