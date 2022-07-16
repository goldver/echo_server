# echo_server PRJ

## Run app with Kubernetes (Minikube) 
**prerequisites:**

1. [Install Minikube](https://kubernetes.io/ru/docs/tasks/tools/install-minikube/)
2. enable ingress:
```bash
minikube addons enable ingress
```

**run:**

apply k8s resourses
```bash
kubectl apply -f ./deploy
```
1. make sure the app is working:
```bash
curl $(kubectl get ing -o jsonpath="{.items[0].status.loadBalancer.ingress[0].ip}"):80/index.html
```
result should be like:
```bash
> <!DOCTYPE html>
    <html lang="en">
      <head>
        <title>This is the title of the webpage!</title>
      </head>
      <body>
        <p>Hello world from ConfigMap!</p>
      </body>
    </html>
```
2. make sure the app echo server is working:
```bash
kubectl port-forward service/echo-server-app-service 5000
http://localhost:5000/index.html
curl http://localhost:5000/echo -X POST -d "hello"
```
result should be like:
```bash
> echo string: b'string to be returned' ip: 172.x.x.x
```

## Create a module for a managed Kubernetes cluster with 1 node pool
**prerequisites:**

1. [Install Terraform](https://learn.hashicorp.com/tutorials/terraform/install-cli)
2. Configure Terraform with "Access key ID" and "Secret access key" from your AWS account's terraform user to let it work with resourses

**run:**

cd to root module
```bash
cd terraform-eks/
```
initialize a working directory and check resources
```terraform init; terrafrom plan```

apply 
```terraform apply```

configure kubectl context with just created AWS EKS K8s cluster (aws cli should be installed)
```bash
aws eks update-kubeconfig --name <eks_cluster_name>
```
cd to the root folder of project and apply k8s resourses
```bash
kubectl apply -f ./deploy
```

Contributing
------------
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: Michael Vershinin

Support
-------------------
goldver@gmail.com
