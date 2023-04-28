Для запуску

```
docker build -t build_lang . && docker rm -f build_lang | docker run --name build_lang -v src:/app/src build_lang && docker start build_lang;  
```
