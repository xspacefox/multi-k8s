docker build -t spacefox42/multi-client:latest -t spacefox42/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t spacefox42/multi-server:latest -t spacefox42/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t spacefox42/multi-worker:latest -t spacefox42/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push spacefox42/multi-client:latest
docker push spacefox42/multi-server:latest
docker push spacefox42/multi-worker:latest

docker push spacefox42/multi-client:$SHA
docker push spacefox42/multi-server:$SHA
docker push spacefox42/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=spacefox42/multi-server:$SHA
kubectl set image deployments/client-deployment client=spacefox42/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=spacefox42/multi-worker:$SHA