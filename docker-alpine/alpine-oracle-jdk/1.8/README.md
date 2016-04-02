docker-alpine-oraclejdk8

This image is based on Alpine Linux image, which is only a 5MB image, and contains
[OracleJDK 7](http://www.oracle.com/technetwork/java/javase/overview/index.html).

## Usage Example

docker build -t edwin/alpine-oraclejdk8 .

```sh
$ echo -e 'public class Main { public static void main(String[] args) { System.out.println("Hello World"); } }' > Main.java
$ docker run --rm -v `pwd`:/tmp --workdir /tmp edwin/alpine-oraclejdk8 \
  sh -c 'javac Main.java && java Main'
```

Once you have run this command you will get printed 'Hello World' from Java!

