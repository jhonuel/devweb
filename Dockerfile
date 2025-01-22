# Usar una imagen base de Nginx
FROM nginx:alpine

# Copiar el archivo HTML a la carpeta donde Nginx lo servirá
COPY index.html /usr/share/nginx/html/index.html

# Exponer el puerto 80 para acceso web
EXPOSE 80

# Iniciar Nginx en primer plano
CMD ["nginx", "-g", "daemon off;"]
