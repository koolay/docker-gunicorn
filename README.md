docker run hug + nginx proxy
-----------

## How to run

```
docker run -d --restart=always --name myapp -p 8000:8000 \
    -e APP_BIND=0.0.0.0:8000
    -e APP_WORKS=5 \
    -e APP_LOG_LEVEL=INFO \
    -v <project root>:/home/app/webapp \
    registry.cn-hangzhou.aliyuncs.com/koolay/hug:latest

```

nginx proxy

```
docker run --rm --name nginx -p 80:80 \
    -v nginx/nginx.conf:/etc/nginx/nginx.conf \
    -v nginx/webapp.conf:/etc/nginx/conf.d/default.conf \
    -v frontend/static:/home/app/webapp/public \
     daocloud.io/library/nginx:1.10.0-alpine
```

## ENV

- `APP_BIND`: gunicorn listen bind, eg. 0.0.0.0:8000
- `APP_WORKS`: gunicorn number of process. (cpux2)+1
- `APP_LOG_LEVEL`: DEBUG,INFO,WARN,ERROR
