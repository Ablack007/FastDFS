
CC=gcc
CPPFLAGS= -I./include -I/usr/local/include/hiredis -I/usr/include/mysql/ -I/usr/include/fastcommon/
CFLAGS=-Wall 
LIBS=-lmysqlclient -lhiredis -lfcgi -lm -lfdfsclient

#path
TEST_PATH=./test
COMMON_PATH=./common
CGI_BIN_PATH=./cgi_bin
CGI_SRC_PATH=./cgi_src

#找到COMMON_PATH目录下所有的.c文件
src = $(wildcard $(COMMON_PATH)/*.c)

#将COMMON_PATH目录下所有的.c  转换成.o给obj
obj = $(patsubst $(COMMON_PATH)/%.c, $(COMMON_PATH)/%.o, $(src))

#===============================test测试代码=======================
test_log=$(TEST_PATH)/test_log 		  		# 日志的使用
test_upload=$(TEST_PATH)/test_upload  		# fdfs上传文件
test_redis=$(TEST_PATH)/test_redis    		# redis客户端
test_sql_redis=$(TEST_PATH)/test_sql_redis 	# mysql和redis配合使用

#===============================cgi程序===========================
upload.cgi=$(CGI_BIN_PATH)/upload.cgi 	#upload.cgi 上传
login.cgi=$(CGI_BIN_PATH)/login.cgi 	#login.cgi  登陆
reg.cgi=$(CGI_BIN_PATH)/reg.cgi 		#reg.cgi    注册


#目标
target=	$(test_log) \
		$(test_upload) \
		$(test_redis) \
		$(test_sql_redis) \
		$(upload.cgi) \
		$(login.cgi) \
		$(reg.cgi)


ALL:$(target)

#生成所有的.o文件
$(obj):$(COMMON_PATH)/%.o:$(COMMON_PATH)/%.c
	$(CC) -c $< -o $@ $(CPPFLAGS) $(CFLAGS) 


#=================================test测试代码===================================
#test_log程序
$(test_log):	$(TEST_PATH)/test_log.o \
				$(COMMON_PATH)/make_log.o 
	$(CC) $^ -o $@ $(LIBS)

#upload程序
$(test_upload):	$(TEST_PATH)/upload_file.o \
				$(COMMON_PATH)/make_log.o 
	$(CC) $^ -o $@ $(LIBS)
	
#test_redis程序
$(test_redis):	$(TEST_PATH)/test_redis.o \
				$(COMMON_PATH)/make_log.o \
				$(COMMON_PATH)/redis_op.o
	$(CC) $^ -o $@ $(LIBS)
	
# mysql和redis配合使用
$(test_sql_redis):	$(TEST_PATH)/sql_redis.o \
					$(COMMON_PATH)/deal_mysql.o \
					$(COMMON_PATH)/redis_op.o \
					$(COMMON_PATH)/make_log.o 
	$(CC) $^ -o $@ $(LIBS)
	
#===============================cgi程序===========================
#上传文件upload.cgi程序
$(upload.cgi):	$(CGI_SRC_PATH)/upload_cgi.o \
				$(COMMON_PATH)/make_log.o  \
				$(COMMON_PATH)/util_cgi.o \
				$(COMMON_PATH)/cfg.o \
				$(COMMON_PATH)/cJSON.o
	$(CC) $^ -o $@ $(LIBS)
	
#登陆login.cgi程序
$(login.cgi):	$(CGI_SRC_PATH)/login_cgi.o \
				$(COMMON_PATH)/make_log.o  \
				$(COMMON_PATH)/util_cgi.o \
				$(COMMON_PATH)/cJSON.o \
				$(COMMON_PATH)/deal_mysql.o \
				$(COMMON_PATH)/cfg.o \
				$(COMMON_PATH)/url_code.o
	$(CC) $^ -o $@ $(LIBS)
	
#注册reg.cgi程序
$(reg.cgi):	$(CGI_SRC_PATH)/reg_cgi.o \
			$(COMMON_PATH)/make_log.o  \
			$(COMMON_PATH)/util_cgi.o \
			$(COMMON_PATH)/cJSON.o \
			$(COMMON_PATH)/deal_mysql.o \
			$(COMMON_PATH)/redis_op.o  \
			$(COMMON_PATH)/cfg.o \
			$(COMMON_PATH)/url_code.o
	$(CC) $^ -o $@ $(LIBS)


#clean指令
clean:
	-rm -rf $(target) $(TEST_PATH)/*.o $(CGI_SRC_PATH)/*.o $(COMMON_PATH)/*.o

distclean:
	-rm -rf $(target) $(TEST_PATH)/*.o $(CGI_SRC_PATH)/*.o $(COMMON_PATH)/*.o

#将clean目标 改成一个虚拟符号
.PHONY: clean ALL distclean
