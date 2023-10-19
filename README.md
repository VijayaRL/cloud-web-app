### Run Terraform to create EKS Cluster

Go to terraform/resources/ folder and run 

Terraform Plan
```
terraform init -var-file="dev.tfvars"
terraform plan -var-file="dev.tfvars"
```

Terraform Apply
```
terraform init -var-file="dev.tfvars"
terraform apply -var-file="dev.tfvars"
```

### Install EKS Cluster Autoscaler

Update your AWS Account ID in eks-cluster-autoscaler.yaml at line 6 

Go to k8s-services folder and run 

```
aws eks --region us-east-1 update-kubeconfig --name vrledu-dev
kubectl apply -f eks-cluster-autoscaler/eks-cluster-autoscaler.yaml
```

### Build and Push the docker image to DockerHub

```
docker build -t datawavelabs/apache_webserver:latest .
docker push -t datawavelabs/apache_webserver:latest
```

### Install ArgoCD 

```
kubectl create ns argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.5.8/manifests/install.yaml
```

Update service type from ClusterIP to LoadBalancer
```
kubectl get service argocd-server -n argocd -o json | jq '.spec.type = "LoadBalancer"' | kubectl apply -f -
```

Admin is the username and get password as
```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```

Access the ArgoCD server using Service External IP

### Run Argocd application

```
kubectl apply -f web-app.yaml
```

### Access web application 

```
http://<load-balancer>/index.html
```