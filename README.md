# uWSGI and NGINX Stack for Python Web Applications

Designed for rapid development of Python web applications
  
### Rapid Development

    docker run -d -v /path/to/project:/app -p 80:80 relvacode/flask-microservice
    
uWSGI will automatically reload the Python application after a change is detected (20 second interval).
    
### ONBUIILD
    
Use this in your Dockerfile:

    FROM relvacode/flask-microservice
    
When your image is built it will add the build context to `/app` and install any apt and pip dependencies.

## Stack Overview

  * Ubuntu 16.04 Base
  * Python 2.7.11
  * NGINX
    * Performs proxying to uWSGI
    * Also serves static content
  * uWSGI
    * Serves Python application
  * /sbin/init
    * `--install` - Installs pip and apt packages
    * `--execute` - Executes the application
    
    
### Default Packages

#### Python Packages
  * flask
  * flask-restful
  * uwsgi
  
#### Ubuntu Packages
  * nginx
  * python-pip
  * python-setuptools
  

## Application Folder Structure

The home directory where applications are served is `/app`.
 Under this directory your application should have this folder structure

 * /app
       * app/ - This is where your Python code goes
         * `api.py` - Your main WSGI Python application
       * static/ - Your static content such as .html, .js, .css files
         * `index.html`
         * js/
         * css/
       * `requirements.apt` - apt-get requirements, separated by newline
       * `requirements.pip` - pip requirements, separated by newline

## Flask

To enable error logging of application errors to the container log you should add the `PROPAGATE_EXCEPTIONS` parameter to the Flask configuration.

    from flask import Flask
    app = Flask(__name__)
    app.config['PROPAGATE_EXCEPTIONS'] = True
    
    
