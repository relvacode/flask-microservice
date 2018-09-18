## Python Flask Microservice

[![](https://images.microbadger.com/badges/image/relvacode/flask-microservice.svg)](https://microbadger.com/images/relvacode/flask-microservice "Get your own image badge on microbadger.com")


### Python Versions

This image comes in two varieties depending on what Python version you require.

  - `2.7`, `2`, `latest`
  - `3.6`, `3`

### Rapid Development

    docker run -d -v /path/to/project:/app -p 80:80 relvacode/flask-microservice
    
All dependencies will be installed on start-up and uWSGI will automatically reload the Python application after a change is detected (20 second interval).
    
### ONBUIILD
    
Use this in your Dockerfile:

    FROM relvacode/flask-microservice
    
When your image is built it will add the build context to `/app` and install any apt and pip dependencies during build time.
This is the recommended method for production deployments.

## Stack Overview

  * Ubuntu 18.04
  * Python
  * NGINX
    * Proxy the Python application on `/api`
    * Serve static files from `/app/static`
  * uWSGI
    * Serves Python application in `/app/app/api.py`
    
    
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

 * `/app`
   * `app/` - This is where your Python code goes
     * `api.py` - Your main flask application file
   * `static/` - Your static content such as .html, .js, .css files
   * `requirements.apt` - apt requirements, separated by newline
   * `requirements.pip` - pip requirements, separated by newline

## Environment Variables

### `UWSGI_MOUNTPOINT`

This sets what base URL to serve the API on. Defaults to `/api`.
To serve the API on root use `UWSGI_MOUNTPOINT=/`

### `UWSGI_ENTRYPOINT`

This sets what Python file/module in `/app/app` to serve using uWSGI. Do not include the file extension.
Defaults to `api` which equates to `/app/app/api.py`

### `UWSGI_APPLICATION`

This sets what variable inside UWSGI_ENTRYPOINT points to the the uWSGI (Flask) application.
Defaults to `app`.

### `UWSGI_CHDIR`

Change to this directory before loading the Python application.
Defaults to `/app/app`.

## Flask

To enable error logging of application errors to the container log you should add the `PROPAGATE_EXCEPTIONS` parameter to the Flask configuration.

    from flask import Flask
    app = Flask(__name__)
    app.config['PROPAGATE_EXCEPTIONS'] = True
    
    
