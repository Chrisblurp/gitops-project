This project is a complete, production-style DevOps pipeline designed to simulate how modern engineering teams build, deploy, and manage applications in real-world environments.


🔹 PHASE 1 — Application Setup
Step 1: Clone Repository
git clone <your-repo-url>
cd project-root

Step 2: Run Application Locally
cd app
python app.py
Test in browser

🔹 PHASE 2 — Dockerization
Step 3: Build Docker Image

Step 4: Run Container

Step 5: Push to DockerHub

🔹 PHASE 3 — CI/CD Pipeline
Step 6: Setup GitHub Actions
Create workflow file
Pipeline should:
* Checkout code
* Build Docker image
* Scan image (Trivy)
* Push to DockerHub

Step 7: Push Code
Verify pipeline runs in GitHub Actions.

🔹 PHASE 4 — Kubernetes Deployment
Step 8: Apply Deployment

Step 9: Expose Service

Step 10: Verify

🔹 PHASE 5 — GitOps (ArgoCD)
Step 11: Install ArgoCD
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

Step 12: Access ArgoCD
kubectl port-forward svc/argocd-server -n argocd 8080:443 (make necessary changes)

Step 13: Deploy App via GitOps
* Connect repo in ArgoCD
* Sync application

🔹 PHASE 6 — Infrastructure as Code (Terraform)
Step 14: Initialize Terraform
cd terraform
terraform init
terraform plan
terraform apply

Step 15: Connect to Cluster
aws eks update-kubeconfig --region us-east-1 --name devops-gitops-cluster

🔹 PHASE 7 — Monitoring & Observability
Step 16: Install Prometheus
helm install prometheus prometheus-community/prometheus

Step 17: Install Grafana
helm install grafana prometheus-community/grafana

Step 18: Access Grafana
kubectl port-forward svc/grafana 3000:80

🔹 PHASE 8 — Internal Ingress
Step 19: Install Ingress Controller
helm install ingress-nginx ingress-nginx/ingress-nginx \
--set controller.service.type=ClusterIP

Step 20: Apply Ingress
kubectl apply -f k8s/ingress.yaml

Step 21: Access Application
kubectl port-forward svc/ingress-nginx-controller 8081:80
Open:
http://localhost:8081

🔹 PHASE 9 — Blue/Green Deployment
Step 22: Deploy Green Version
kubectl apply -f k8s/deployment-green.yaml

Step 23: Switch Traffic
kubectl edit svc gitops-service
Change selector:
version: green

Step 26: Rollback (Optional)
Switch back to:
version: blue


Deliverables:
Screenshot of:
* Running pods
* Grafana dashboard
* ArgoCD sync status
