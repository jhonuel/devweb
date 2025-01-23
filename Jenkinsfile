
pipeline {
    agent { label 'server' }

    environment {
        DOCKER_IMAGE = "jhonuel/devweb"                      // Nombre de la imagen en Docker Hub
        REGISTRY = "docker.io"                               // Registro Docker
        KUBECONFIG = "/root/kube_config_cluster.yml"         // Ruta al archivo kubeconfig
    }

    stages {
        stage('Desplegar en Kubernetes') {
            steps {
                script {
                    echo "Preparando despliegue en Kubernetes..."

                    // Verifica el archivo kubeconfig
                    sh "kubectl --kubeconfig=${KUBECONFIG} config view"

                    // Crea un archivo de manifiesto Kubernetes dinámico
                    writeFile file: 'k8s-deployment.yaml', text: """
apiVersion: apps/v1
kind: Deployment
metadata:
  name: devweb-deployment
  labels:
    app: devweb
spec:
  replicas: 3
  selector:
    matchLabels:
      app: devweb
  template:
    metadata:
      labels:
        app: devweb
    spec:
      containers:
      - name: devweb-container
        image: ${REGISTRY}/${DOCKER_IMAGE}:latest
        ports:
        - containerPort: 8080
---
apiVersion: v1
kind: Service
metadata:
  name: devweb-service
spec:
  selector:
    app: devweb
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
  type: LoadBalancer
"""

                    // Aplica el manifiesto en el clúster
                    sh "kubectl --kubeconfig=${KUBECONFIG} apply -f k8s-deployment.yaml"
                }
            }
        }
    }

    post {
        success {
            echo "Pipeline completado con éxito. La aplicación está desplegada en Kubernetes."
        }
        failure {
            echo "El pipeline falló. Revisa los registros para más detalles."
        }
    }
}
