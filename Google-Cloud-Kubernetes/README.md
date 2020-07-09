# Google Cloud Kubernetes Deployment for Computer Vision (opencv)

<b>As seen in: https://www.linkedin.com/pulse/running-kubernetes-cluster-google-cloud-rubens-zimbres-phd/</b>

<img src=https://github.com/RubensZimbres/Repo-2020/blob/master/Google-Cloud-Kubernetes/k8s.png>  

```
$ sudo apt-get install kubectl
$ wget https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-293.0.0-linux-x86_64.tar.gz
$ ./google-cloud-sdk/install.sh

$ cd project
$ gcloud config set disable_prompts false

$ gcloud auth login
$ gcloud config set project marcomarketing
$ gcloud auth configure-docker
$ gcloud init
$ gcloud beta auth configure-docker us-central1-docker.pkg.dev

$ sudo usermod -aG docker $USER
#$ newgrp docker

$ sudo apt install docker.io
$ cat service-account.json | docker login -u _json_key --password-stdin https://us-central1-docker.pkg.dev

$ gcloud builds submit --tag gcr.io/<project-id>/example-gke . --timeout=85000

$ gcloud container clusters create example-gke --num-nodes 1 --enable-basic-auth --issue-client-certificate --enable-autoscaling --min-nodes 1 --max-nodes 3 --region us-central1 --machine-type n1-standard-2 --local-ssd-count 1 --scopes=cloud-platform,storage-full,compute-rw,service-control,cloud-source-repos --async --preemptible --enable-autorepair

$ gcloud container clusters get-credentials example-gke --region=us-central1

$ kubectl create secret generic my-app-sa-key --from-file service-account.json
$ kubectl get secret

$ kubectl apply -f deployment.yaml

$ kubectl get pods
$ kubectl logs <pod-name>
$ kubectl describe pod example-gke-12345

$ allow-all-network-policy.yaml

$ kubectl apply -f service.yaml
```
