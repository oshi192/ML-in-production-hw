## Deploy kubeflow-pipelines on k8s
### Instructions:
 - to create k8s cluster run create_kluster.sh script with 'master' or 'worker' command
```bash
#bash
./create_kluster.sh master
```
 - after successful eds of the script run deploy_kubeflow_pipelines_k8s.sh to deploy kubeflow pipelines. [Official docs](https://www.kubeflow.org/docs/components/pipelines/v1/installation/standalone-deployment/)
```bash
./deploy_kubeflow_pipelines_k8s.sh
```
 - to connect to pipeline UI you can find ip address by command:
```bash
 kubectl get service -n kubeflow ml-pipeline-ui
 
 ## the OUTPUT
 NAME             TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
ml-pipeline-ui   ClusterIP   10.101.44.175   <none>        80/TCP    7m33s
```
 - or use port-forward:
```bash
kubectl port-forward service/ml-pipeline-ui -n kubeflow 8080:80
```
 - now you can go to browser and paste 
    - http://localhost:8080/#/pipelines for port-forward
    - 10.101.44.175 for directly access