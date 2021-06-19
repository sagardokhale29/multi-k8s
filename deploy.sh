docker build -t sagardokhale29/multi-client:latest -t sagardokhale29/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sagardokhale29/multi-server:latest -t sagardokhale29/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sagardokhale29/multi-worker:latest -t sagardokhale29/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push sagardokhale29/multi-client:latest
docker push sagardokhale29/multi-server:latest
docker push sagardokhale29/multi-worker:latest 

docker push sagardokhale29/multi-client:$SHA
docker push sagardokhale29/multi-server:$SHA
docker push sagardokhale29/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=stephengrider/multi-server:$SHA
kubectl set image deployments/client-deployment client=stephengrider/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=stephengrider/multi-worker:$SHA