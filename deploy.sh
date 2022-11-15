docker build -t aaron2905/multi-client:latest -t aaron2905/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t aaron2905/multi-server:latest -t aaron2905/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t aaron2905/multi-worker:latest -t aaron2905/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push aaron2905/multi-client:latest
docker push aaron2905/multi-server:latest
docker push aaron2905/multi-worker:latest
docker push aaron2905/multi-client:$SHA
docker push aaron2905/multi-server:$SHA
docker push aaron2905/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=aaron2905/multi-server:$SHA
kubectl set image deployments/client-deployment client=aaron2905/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=aaron2905/multi-worker:$SHA
