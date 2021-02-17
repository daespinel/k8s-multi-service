docker build -t dafespinelsa/multi-client:latest -t dafespinelsa/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dafespinelsa/multi-server:latest -t dafespinelsa/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dafespinelsa/multi-worker:latest -t dafespinelsa/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push dafespinelsa/multi-client:latest
docker push dafespinelsa/multi-server:latest
docker push dafespinelsa/multi-worker:latest
docker push dafespinelsa/multi-client:$SHA
docker push dafespinelsa/multi-server:$SHA
docker push dafespinelsa/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployment/server-deployment server=dafespinelsa/multi-server:$SHA
kubectl set image deployment/worker-deployment worker=dafespinelsa/multi-worker:$SHA
kubectl set image deployment/client-deployment client=dafespinelsa/multi-client:$SHA