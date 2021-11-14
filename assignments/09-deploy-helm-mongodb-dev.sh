kubectl create secret generic bookinfo-dev-ratings-mongodb-secret \
  --from-literal=mongodb-password=CHANGEME \
  --from-literal=mongodb-root-password=CHANGEME

cd ratings/

kubectl create configmap bookinfo-dev-ratings-mongodb-initdb \
  --from-file=databases/ratings_data.json \
  --from-file=databases/script.sh

kubectl run mongodb-client --rm --tty -i --restart='Never' --image bitnami/mongodb:5.0.3-debian-10-r30 \
  --command -- mongo admin --host bookinfo-dev-ratings-mongodb --username root --password CHANGEME