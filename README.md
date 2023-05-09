# Instrucciones
Para la instalación del módulo debe tener en cuenta lo siguiente:
- Tener instaladas las librerias necesarias
- Tener instalado MySQL
- Tener instalado Python3
- Tener instalado pip
- Tener Python agregado al PATH (carpetas python/scripts y python/)

## Librerias
Ejecutar los siguientes comandos en la terminal:
- pip install django
- pip install pyautogui
- pip install mysqlclient
- pip install mysql
- pip install virtualenv

## Pasos para la ejecución
1. Clonar repositorio: 
    - git clone https://github.com/DIEGOPARDO22/testing_farmacia.git

2. En caso de que se pida usuario y contraseña, como usuario se inserta el predeterminado y como contraseña se debe generar un token personal de Github e insertarlo. Puede consultar los siguientes videos guía:
    - https://youtu.be/VdGzPZ31ts8
    - https://www.youtube.com/watch?v=1RJHiHzUnk8
    - https://www.youtube.com/watch?v=FFzPazMC6hQ

3. Una vez clonado el repositorio, debe dirigirse a la carpeta "Script BD", donde encontrará el archivo "ScriptBD.sql" que deberá arrastrar o abrir con MySQL Workbench para su ejecución. Una vez abierto el archivo con MySQL Workbench deberá hacer clic en el ícono de rayo sin el cursor.

4. Con la base de datos ya creada, debe dirigirse a la carpeta hospital, abrir el archivo "settings.py" y modificar la línea número 83 en la sección "DATABASES", colocando la contraseña que utilizó para iniciar sesión en MySQL Workbench. En caso sea necesario, modificar también el usuario y el puerto.

5. Con ayuda de la terminal, colocarse dentro de la carpeta "testing_farmacia" (la carpeta general), y ejecutar el comando:
    - py manage.py runserver

6. Esto le brindará una dirección url que deberá copiar y pegar en el navegador de su preferencia para poder tener acceso al módulo.

7. Todo el código fuente se encuentra en la carpeta general "testing_farmacia"

## Contacto
En caso de errores, problemas o consultas para la ejecución del módulo, puede contactar con cualquiera de los miembros del equipo:
- Albarracín Payé Mauricio Genaro
- Nozoe Calderón Sebastián Araki
- Ordoñez Arratia Joseph Fernando
- Osorio Flores Harold Gonzalo
- Pardo Yepez Diego Valentino