# Etapa 1: Compilar la aplicación Flutter
FROM cirrusci/flutter:stable AS builder
WORKDIR /app
# Copia todos los archivos del repositorio
COPY . .
# Compila la versión web; ajusta la ruta según tu estructura de directorios
RUN cd landing_page && flutter build web

# Etapa 2: Servir la aplicación usando Nginx
FROM nginx:alpine
# Copia los archivos compilados al directorio de Nginx para contenido estático
COPY --from=builder /app/landing_page/build/web /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
