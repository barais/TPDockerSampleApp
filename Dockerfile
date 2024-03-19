FROM adoptopenjdk/openjdk11:alpine-slim

ADD pom.xml /app/pom.xml
ADD src /app/src
ADD lib /app/lib
ADD haarcascades /app/haarcascades

WORKDIR /app

RUN apk add maven \
    && mvn install:install-file -Dfile=./lib/opencv-3410.jar -DgroupId=org.opencv  -DartifactId=opencv -Dversion=3.4.10 -Dpackaging=jar \
    && mvn package

CMD java -Djava.library.path=lib/ubuntuupperthan18/ -jar target/fatjar-0.0.1-SNAPSHOT.jar

