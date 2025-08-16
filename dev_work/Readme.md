## =====Terraform commands =====##

terraform init
terraform apply -auto-approve
aws eks update-kubeconfig --name todo-api-cluster --region ap-south-1


## ==== lubectl commands=====
kubectl get pods
kubectl port-forward svc/todo-api 8080:8080
curl http://localhost:8080/healthz
