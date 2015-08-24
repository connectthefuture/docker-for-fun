 1、首先尝试构建这几个image
 docker-compose up -d zookeeper kafka schemaregistry postgres
 2、成功之后，进入postgres，配置bottledwater的扩展
 docker-compose run --rm postgres psql
 
然后键入如下命令
create extension bottledwater;
create table test (id serial primary key, value text);
insert into test (value) values('hello world!');
3、下一步是启动bottledwater
 docker-compose run -d bottledwater
4、
docker-compose run --rm consumer --from-beginning --topic test
docker-compose stop

docker-compose rm -vf