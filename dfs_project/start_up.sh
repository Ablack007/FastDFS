#拷贝配置文件路径
./cfg.sh

# 杀死 已经启动的后台CGI程序
kill -9 `ps aux | grep "cgi_bin/upload.cgi" | grep -v grep | awk '{print $2}'`
kill -9 `ps aux | grep "cgi_bin/login.cgi" | grep -v grep | awk '{print $2}'`
kill -9 `ps aux | grep "cgi_bin/reg.cgi" | grep -v grep | awk '{print $2}'`

#启动 必要的业务后台cgi应用程序
spawn-fcgi -a 127.0.0.1 -p 8003 -f ./cgi_bin/upload.cgi
spawn-fcgi -a 127.0.0.1 -p 8004 -f ./cgi_bin/login.cgi
spawn-fcgi -a 127.0.0.1 -p 8005 -f ./cgi_bin/reg.cgi


#启动MySQL服务器
service mysql restart

# 杀死 已经启动的后台redis服务器
kill -9 `ps aux | grep "redis-server" | grep -v grep | awk '{print $2}'`


#启动redis服务器
redis-server ./conf/redis/redis.conf


#启动nginx服务器
/usr/local/nginx/sbin/nginx -s quit
/usr/local/nginx/sbin/nginx

#启动本地tracker
/usr/bin/fdfs_trackerd ./conf/fdfs/tracker/tracker.conf restart

#启动本地storage
/usr/bin/fdfs_storaged ./conf/fdfs/storage/storage.conf restart
