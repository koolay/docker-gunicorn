hug镜像
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

## ENV

- `APP_BIND`: gunicorn listen bind, 例如 0.0.0.0:8000
- `APP_WORKS`: gunicorn 进程数, 推荐(cpu核x2)+1
- `APP_LOG_LEVEL`: 日志级别(DEBUG,INFO,WARN,ERROR),  生产环境使用ERROR
