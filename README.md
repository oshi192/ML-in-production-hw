## Lecture-02
### ML-in-production-hw
PR #1: Write a dummy docker file with a simple server and push it to your docker hub registry
#### Docker:
 to build:
 ```
 sudo docker build -t oshi192/yurii-web-app:latest -f Dockerfile .
 ```
 to pull:
 ```
 docker pull oshi192/yurii-web-app:latest
 ```
 to run:
 ```
 docker run -p 80:5000 oshi192/yurii-web-app:latest
 ```
 link to check output : [localhost](http://127.0.0.1)
 

[link to yurii-web-app docker image](https://hub.docker.com/repository/docker/oshi192/yurii-web-app)\


### Lecture-03
#### Storage and processing of ML data
 - MiniODeploy  [minio documentation](https://github.com/minio/operator/blob/master/README.md#deploy-the-minio-operator-and-create-a-tenant)
 - if needed you could create k8s cluster by running [create_kluster.sh](https://github.com/prjktr-hw/ML-in-production-hw/blob/lecture-03-hw-Storage_and_processing_of_ML_data/scripts/create_kluster.sh) script
    ```commandline
    ./create_kluster.sh master
    ```
 - to deploy minio operator just run [minio_deploy.sh](https://github.com/prjktr-hw/ML-in-production-hw/blob/lecture-03-hw-Storage_and_processing_of_ML_data/scripts/minio_deploy.sh) script
    ```commandline
    ./minio_deploy.sh
    ```
 - after script ends run next command to check if minio is running:
   ```commandline
   kubectl get all -n minio-operator
   ```
 - the output should be like these:
   ```commandline
   kubectl get all -n minio-operator
   NAME                                  READY   STATUS              RESTARTS   AGE
   pod/console-7fc4cfb6dc-rpnm2          0/1     ContainerCreating   0          14s
   pod/minio-operator-84bdfd654c-4vhhm   0/1     ContainerCreating   0          14s
   pod/minio-operator-84bdfd654c-fznrm   0/1     Pending             0          14s
   
   NAME               TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)             AGE
   service/console    ClusterIP   10.110.177.191   <none>        9090/TCP,9443/TCP   14s
   service/operator   ClusterIP   10.99.76.216     <none>        4222/TCP,4221/TCP   14s
   
   NAME                             READY   UP-TO-DATE   AVAILABLE   AGE
   deployment.apps/console          0/1     1            0           14s
   deployment.apps/minio-operator   0/2     2            0           14s
   
   NAME                                        DESIRED   CURRENT   READY   AGE
   replicaset.apps/console-7fc4cfb6dc          1         1         0       14s
   replicaset.apps/minio-operator-84bdfd654c   2         2         0       14s
   ```
   
   To get access the Operator Console run next:
   ```commandline
   kubectl minio proxy -n minio-operator
   ```
Then login and click create tenant to open the creation workflow.

configuration:
 - **name** : any name
 - **namespace**: minio-tenant-1 (this namespace was created when you had run minio_deploy script)
 - **Storage Class**: local-path
 - **Storage Class**: local-path
 - **Number of Servers**: 1
 - **Drives per Server**: 1
 - **Total Size**: 2

Wait while tenant will be created.

**Important!** Console preparing pretty long time (need to wait while console button become in active state)

   