Getting started with  moochine( Lua web development) using docker as your Lua web application server
-----------------------------------------------


In this blog post I will guide you through a path to getting you started with moochine  by using the container technology software [Docker][1].

Why [Docker][1] ?
-----------------

From their web page:
> Docker is an open-source project to easily create lightweight, portable, self-sufficient containers from any application. The same container that a developer builds and tests on a laptop can run at scale, in production, on VMs, bare metal, OpenStack clusters, public clouds and more. 

This means that we have an excellent way to reproduce and contain a development setup for the Lua project we will be creating that will not mess up your system the way most application package managers like npm, luarocks, virtualenv + easy_install/pip likes to do. Another major drawback with most application package managers are that they are not good at creating isolated enviroments, so you will have version conflicts or breakage if application1 wants a different version of a library than application2. Or like invirtualenv's case it will still be tied to the system in some ways.

The goal of this guide is to end up in this type of setup:

    Internets => nginx:80
                  |--> docker (app1):8080 
                  |       |--> nginx+lua: 8080
                  |--> docker (app2):8090
                  |       |--> nginx+lua: 8090
                  ...

The point is that we use [Docker][1] the way we normally would use an app server like uwsgi, gunicorn, nodejs, php5-fpm or similar.

Why [Openresty][2] ?
--------------------

A downside with running Lua(jit) inside your Nginx is that this is not enabled by default in most distributions of Nginx, and since Nginx does not (yet) support dynamic loading of modules which means a recompile of Nginx is needed to get support for running Lua. And while Nginx recompilation is really fast, and it while it supports hot code reload, it is still painful because of security and maintainability considerations.

To get Lua support in Nginx we will be using the Nginx-bundle called [Openresty][2]. Openresty comes bundled with many Nginx and Lua modules useful for web development.



Why [Moochine][3] ?
--------------------

A (very) simple and lightweight web framework based on ngx-openresty.
### Building our Dockerfile


A Dockerfile is:
> Docker can act as a builder and read instructions from a text Dockerfile to automate the steps you would otherwise take manually to create an image. Executing docker build will run your steps and commit them along the way, giving you a final image

We will create a Dockerfile which sets up a Ubuntu with [Openresty][2].

Installation help for Ubuntu will be provided, if you use a different Linux distribution please find instructions here: <http://www.docker.io/gettingstarted/#h_installation>

Installation of [Docker][1] on Ubuntu with kernel 3.8 or newer:

    sudo curl https://get.docker.io/gpg | sudo apt-key add -

    sudo sh -c "echo deb http://get.docker.io/ubuntu docker main\
    echo deb "echo deb http://get.docker.io/ubuntu docker main" | sudo tee /etc/apt/sources.d/docker.list
    sudo apt-get update
    sudo apt-get install lxc-docker
    
### Create a project directory, with logdir, nginx.conf and Dockerfile

    git clone git://github.com/appwilldev/moochine-demo.git
    cd moochine-demo
    
    cat <<EOF > Dockerfile
    # Dockerfile for openresty
    # VERSION   0.0.3
    
    FROM ubuntu:14.04
    MAINTAINER edwin uestc <edwin_uestc@163.com>
    ENV REFRESHED_AT 2014-08-07
    
    ENV    DEBIAN_FRONTEND noninteractive
    RUN    echo "deb-src http://mirrors.163.com/ubuntu/  trusty main" >> /etc/apt/sources.list
    RUN    sed 's/main$/main universe/' -i /etc/apt/sources.list
    RUN    apt-get update
    RUN    apt-get upgrade -y
    RUN    apt-get -y install wget vim git libpq-dev
    
    # Openresty (Nginx)
    RUN    apt-get -y build-dep nginx \
      && apt-get -q -y clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*
    RUN    wget http://openresty.org/download/ngx_openresty-1.5.12.1.tar.gz \
      && tar xvfz ngx_openresty-1.5.12.1.tar.gz \
      && cd ngx_openresty-1.5.12.1 \
      && ./configure --with-luajit  --with-http_addition_module --with-http_dav_module --with-http_geoip_module --with-http_gzip_static_module --with-http_image_filter_module --with-http_realip_module --with-http_stub_status_module --with-http_ssl_module --with-http_sub_module --with-http_xslt_module --with-ipv6 --with-http_postgres_module --with-pcre-jit \
      && make \
      && make install \
      && rm -rf /ngx_openresty*
    
    EXPOSE 8080

    RUN    mkdir -p /opt \
    &&  cd /opt   \
    &&      git clone git://github.com/appwilldev/moochine.git  \
    &&       export OPENRESTY_HOME=/usr/local/openresty  \
    &&  export MOOCHINE_HOME=/opt/moochine   \
    &&      git clone git://github.com/appwilldev/moochine-demo.git  \

    &&      cd moochine-demo   \
    &&  PWD= 'pwd'    \
    &&         echo  $PWD  \

    &&    NGINX_FILES=$PWD"/nginx_runtime"  \

    &&    mkdir -p $NGINX_FILES"/conf"  \
    &&    mkdir -p $NGINX_FILES"/logs"  \

    &&    cp $PWD"/conf/mime.types" $NGINX_FILES"/conf/"  \

    &&    sed -e "s|__MOOCHINE_HOME_VALUE__|$MOOCHINE_HOME|" \
        -e "s|__MOOCHINE_APP_PATH_VALUE__|$PWD|" \
        $PWD/conf/nginx.conf > $NGINX_FILES/conf/p-nginx.conf  \

    &&    $OPENRESTY_HOME/nginx/sbin/nginx -p $NGINX_FILES/ -c conf/p-nginx.conf  \
    
    &&    echo "nginx started!"
    EOF
    
### Build the image using our Dockerfile
    
 sudo docker build - < Dockerfile -t="edwin/moochine-openresty" .
This will create the contained environment which we then can re-use and launch for many projects later. The `-t` flag is the name for the image, you can choose your own name here if you want, to help you refer to the image by name later. The name mostly matters if you want to share/submit your docker image to repositories, see: <http://docs.docker.io/en/latest/use/workingwithrepository/> for more information about that.


    
Now we can start the docker image that we built. We will map the directory from the host to the container so you can continue to use your favorite editor and development environment from the host. Note that the nginx.conf and app lives outside the container, so you can re-use this container image for all of your lua projects.

### Run our newly created Docker image

    sudo docker run -t -i -p 8080:8081 -v=`pwd`:/moochine-demo -w=/moochine-demo edwin/moochine-openresty 
`-p` expose the container port 8080 to the host port 8081.
`-v` is the shared directory.
`-w` is the working directoriy inside the container.
`-t` and `-i` for interactive tty.
`edwin/moochine-openresty` is the name of the image. List images with `sudo docker images`


### 2.2 程序目录结构
    
    moochine-demo #程序根目录
    |
    |-- routing.lua # URL Routing配置
    |-- application.lua # moochine app 描述文件
    |
    |-- app #应用目录
    |   `-- test.lua #请求处理函数
    |
    |-- bin #脚本目录
    |   |-- debug.sh #关闭服务->清空error log->启动服务->查看error log
    |   |-- reload.sh #平滑重载配置
    |   |-- start.sh #启动
    |   |-- stop.sh #关闭
    |   |-- console.sh #moochine控制台。注意:moochine控制台需要安装Python2.7或Python3.2。
    |   `-- cut_nginx_log_daily.sh #Nginx日志切割脚本
    |
    |-- conf  #配置目录
    |    `-- nginx.conf  #Nginx配置文件模版。需要配置 `set $MOOCHINE_APP_NAME 'moochine-demo';` 为真实App的名字。
    |
    |-- templates  #ltp模版目录
    |    `-- ltp.html  #ltp模版文件
    |
    |-- static  #静态文件(图片,css,js等)目录
    |    `-- main.js  #js文件
    |
    |-- moochine_demo.log #调试日志文件。在 application.lua 可以配置路径和Level。
    |
    `-- nginx_runtime #Nginx运行时目录。这个目录下的文件由程序自动生成，无需手动管理。
        |-- conf
        |   `-- p-nginx.conf #Nginx配置文件(自动生成)，执行 ./bin/start.sh 时会根据conf/nginx.conf 自动生成。
        |
        `-- logs #Nginx运行时日志目录
            |-- access.log #Nginx 访问日志
            |-- error.log #Nginx 错误日志
            `-- nginx.pid #Nginx进程ID文件
    

### 2.3 启动/停止/重载/重启 方法
    ./bin/start.sh #启动
    ./bin/stop.sh #停止
    ./bin/reload.sh #平滑重载配置
    ./bin/debug.sh #关闭服务->清空error log->启动服务->查看error log

注意：以上命令只能在程序根目录执行，类似 `./bin/xxx.sh` 的方式。    

### 2.4 测试
    curl "http://localhost:9800/hello?name=xxxxxxxx"
    curl "http://localhost:9800/ltp"
    tail -f moochine_demo.log #查看 调试日志的输出
    tail -f nginx_runtime/logs/access.log  #查看 Nginx 访问日志的输出
    tail -f nginx_runtime/logs/error.log  #查看 Nginx 错误日志和调试日志 的输出

### 2.5 通过moochine控制台调试
    ./bin/console.sh #运行后会打开一个console，可以输入调试代码检查结果。注意:moochine控制台需要安装Python2.7或Python3.2。

## 三、开发Web应用
### 3.1 URL Routing: routing.lua
    #!/usr/bin/env lua
    -- -*- lua -*-
    -- copyright: 2012 Appwill Inc.
    -- author : ldmiao
    --
    
    local router = require('mch.router')
    router.setup()
    
    ---------------------------------------------------------------------
    
    map('^/hello%?name=(.*)',           'test.hello')
    
    ---------------------------------------------------------------------
    

### 3.2 请求处理函数：app/test.lua
请求处理函数接收2个参数，request和response，分别对应HTTP的request和response。从request对象拿到客户端发送过来的数据，通过response对象返回数据。request和response对象也可以通过ngx.ctx.request, ngx.ctx.response来获取。

    #!/usr/bin/env lua
    -- -*- lua -*-
    -- copyright: 2012 Appwill Inc.
    -- author : ldmiao
    --
    
    module("test", package.seeall)
    
    local JSON = require("cjson")
    local Redis = require("resty.redis")
    
    function hello(req, resp, name)
        if req.method=='GET' then
            -- resp:writeln('Host: ' .. req.host)
            -- resp:writeln('Hello, ' .. ngx.unescape_uri(name))
            -- resp:writeln('name, ' .. req.uri_args['name'])
            resp.headers['Content-Type'] = 'application/json'
            resp:writeln(JSON.encode(req.uri_args))

            resp:writeln({{'a','c',{'d','e', {'f','b'})
        elseif req.method=='POST' then
            -- resp:writeln('POST to Host: ' .. req.host)
            req:read_body()
            resp.headers['Content-Type'] = 'application/json'
            resp:writeln(JSON.encode(req.post_args))
        end 
    end

### 3.3 request对象的属性和方法
以下属性值的详细解释，可以通过 http://wiki.nginx.org/HttpLuaModule 和 http://wiki.nginx.org/HttpCoreModule 查找到。

    --属性
    method          = ngx.var.request_method    -- http://wiki.nginx.org/HttpCoreModule#.24request_method
    schema          = ngx.var.schema            -- http://wiki.nginx.org/HttpCoreModule#.24scheme
    host            = ngx.var.host              -- http://wiki.nginx.org/HttpCoreModule#.24host
    hostname        = ngx.var.hostname          -- http://wiki.nginx.org/HttpCoreModule#.24hostname
    uri             = ngx.var.request_uri       -- http://wiki.nginx.org/HttpCoreModule#.24request_uri
    path            = ngx.var.uri               -- http://wiki.nginx.org/HttpCoreModule#.24uri
    filename        = ngx.var.request_filename  -- http://wiki.nginx.org/HttpCoreModule#.24request_filename
    query_string    = ngx.var.query_string      -- http://wiki.nginx.org/HttpCoreModule#.24query_string
    user_agent      = ngx.var.http_user_agent   -- http://wiki.nginx.org/HttpCoreModule#.24http_HEADER
    remote_addr     = ngx.var.remote_addr       -- http://wiki.nginx.org/HttpCoreModule#.24remote_addr
    remote_port     = ngx.var.remote_port       -- http://wiki.nginx.org/HttpCoreModule#.24remote_port
    remote_user     = ngx.var.remote_user       -- http://wiki.nginx.org/HttpCoreModule#.24remote_user
    remote_passwd   = ngx.var.remote_passwd     -- http://wiki.nginx.org/HttpCoreModule#.24remote_passwd
    content_type    = ngx.var.content_type      -- http://wiki.nginx.org/HttpCoreModule#.24content_type
    content_length  = ngx.var.content_length    -- http://wiki.nginx.org/HttpCoreModule#.24content_length

    headers         = ngx.req.get_headers()     -- http://wiki.nginx.org/HttpLuaModule#ngx.req.get_headers
    uri_args        = ngx.req.get_uri_args()    -- http://wiki.nginx.org/HttpLuaModule#ngx.req.get_uri_args
    post_args       = ngx.req.get_post_args()   -- http://wiki.nginx.org/HttpLuaModule#ngx.req.get_post_args
    socket          = ngx.req.socket            -- http://wiki.nginx.org/HttpLuaModule#ngx.req.socket
    
    --方法
    request:read_body()                         -- http://wiki.nginx.org/HttpLuaModule#ngx.req.read_body
    request:get_uri_arg(name, default)
    request:get_post_arg(name, default)
    request:get_arg(name, default)

    request:get_cookie(key, decrypt)
    request:rewrite(uri, jump)                  -- http://wiki.nginx.org/HttpLuaModule#ngx.req.set_uri
    request:set_uri_args(args)                  -- http://wiki.nginx.org/HttpLuaModule#ngx.req.set_uri_args
    

### 3.4 response对象的属性和方法
    --属性
    headers         = ngx.header                -- http://wiki.nginx.org/HttpLuaModule#ngx.header.HEADER
    
    --方法
    response:set_cookie(key, value, encrypt, duration, path)
    response:write(content)
    response:writeln(content)
    response:ltp(template,data)
    response:redirect(url, status)              -- http://wiki.nginx.org/HttpLuaModule#ngx.redirect

    response:finish()                           -- http://wiki.nginx.org/HttpLuaModule#ngx.eof
    response:is_finished()
    response:defer(func, ...)                   -- 在response返回后执行

### 3.5 打印调试日志
在 `application.lua` 里定义log文件的位置和Level
    
    logger:i(format, ...)  -- INFO
    logger:d(format, ...)  -- DEBUG
    logger:w(format, ...)  -- WARN
    logger:e(format, ...)  -- ERROR
    logger:f(format, ...)  -- FATAL
    -- format 和string.format(s, ...) 保持一致：http://www.lua.org/manual/5.1/manual.html#pdf-string.format

查看调试日志

    tail -f moochine_demo.log

查看nginx错误日志

    tail -f nginx_runtime/logs/error.log  #查看 Nginx 错误日志和调试日志 的输出

### 3.6 常见错误
1. MOOCHINE URL Mapping Error
1. Error while doing defers
1. Moochine ERROR

## 四、Multi-App 与 Sub-App

### 4.1 multi-app
    多个 moochine-app 可以运行与同一nginx进程中，只要将本例子中nginx.conf内moochine-app相关段配置多份即可。

### 4.2 sub-app
    某moochine-app可以作为另一app的sub-app运行，在主app的application.lua内配置：

    subapps={
        subapp1 = {path="/path/to/subapp1", config={}},
        ...
    }


## 五、参考 
1. http://wiki.nginx.org/HttpLuaModule 
1. http://wiki.nginx.org/HttpCoreModule 
1. http://openresty.org
1. https://github.com/appwilldev/moochine

*Awesome!*

### Deploy


To serve content to the internets let me show you to configure Nginx running on the host to get content from our helloproj Docker image. You could easily have two (or more!) running Docker process on different ports, one with `lua_code_cache on` on one port for production, and one without it for development. Here is a simplistic nginx conf that will proxy the connections to the Docker image:

    cat <<EOF > /etc/nginx/sites-enabled/helloproj.conf
    server {
        listen 80;
       
        location / {
            proxy_pass http://127.0.0.1:8080/;
            proxy_set_header  X-Real-IP  $remote_addr;
        }
    }
    EOF
        
Basically we just proxy every request to the container using the built in proxy feature of Nginx. We also use set the real IP header to the clients IP address so the contained Nginx process can see the client's IP address. 

To extend/improve this setup you could set the root directory to be the same directory as the helloproj and then serve static content using the host nginx, and let the contained nginx only worry about dynamic content. It could also be extended to cache requests using one of the many Nginx caching techniques.

To start and keep your containers running you can use many different techniques, some viable solutions are systemd, supervisord, upstart, or just a good old initscript.

### Potential pitfalls

Running two Nginxes will have an impact on performance compared to running a single app on a single front facing Nginx, because every request will be proxied. This is similar to what many app servers will also have to do in some ways, but usually one of the advantages of Lua (and php!) is that you can run your application directly inside the webserver without any proxying. So for instance if you have an application that handles large uploads you need to think about how you want to handle that. 


The source for this guide is available in a [GitHub repository][3]. Please fork and send changes if you have suggestions or improvements.


  [1]: http://docker.io/ "Docker"
  [2]: http://openresty.org/
  [3]: https://github.com/torhve/openresty-docker
