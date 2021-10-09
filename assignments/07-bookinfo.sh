docker build -t ratings .

docker run -d --name ratings -p 8080:8080 ratings

docker build -t details .

docker run -d --name details -p 8081:8081 details

docker build -t reviews .

docker run -d --name reviews -p :8082:8082 --link ratings:ratings \
    -e 'RATINGS_SERVICE=http://ratings:8080' reviews

docker build -t productpage .

docker run -d --name productpage -p 8083:8083 --link details:details --link ratings:ratings --link reviews:reviews \
    -e 'DETAILS_HOSTNAME=http://details:8081' -e 'RATINGS_HOSTNAME=http://ratings:8080' -e 'REVIEWS_HOSTNAME=http://reviews:8082' productpage

