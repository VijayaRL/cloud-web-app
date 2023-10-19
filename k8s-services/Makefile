# Set variables
REGION := us-east-1
EKS_CLUSTER := vrledu-dev

install-autoscaler:
	aws eks --region $(REGION) update-kubeconfig --name $(EKS_CLUSTER); \
	kubectl apply -f eks-cluster-autoscaler/eks-cluster-autoscaler.yaml