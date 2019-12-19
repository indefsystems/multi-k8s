docker build -t indefsystems/multi-docker-client:latest -t indefsystems/multi-docker-client:$SHA -f ./client/Dockerfile ./client
docker build -t indefsystems/multi-docker-server:latest -t indefsystems/multi-docker-server:$SHA -f ./server/Dockerfile ./server
docker build -t indefsystems/multi-docker-worker:latest -t indefsystems/multi-docker-worker:$SHA -f ./worker/Dockerfile ./worker

docker push -t indefsystems/multi-docker-client:latest
docker push -t indefsystems/multi-docker-server:latest
docker push -t indefsystems/multi-docker-worker:latest

docker push -t indefsystems/multi-docker-client:$SHA
docker push -t indefsystems/multi-docker-server:$SHA
docker push -t indefsystems/multi-docker-worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=indefsystems/multi-docker-server:$SHA
kubectl set image deployments/client-deployment client=indefsystems/multi-docker-client:$SHA
kubectl set image deployments/worker-deployment worker=indefsystems/multi-docker-worker:$SHA

