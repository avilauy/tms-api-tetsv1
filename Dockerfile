# ==========================================
# Newman Executor - TMS API Automation
# ==========================================
FROM node:18-alpine

USER root

WORKDIR /app

# -------------------------------
# Cache de dependencias
# -------------------------------
COPY package*.json ./

# Instalación de dependencias
RUN npm install

# Validación (falla si newman no está)
RUN npx newman -v

# -------------------------------
# Copiamos el resto del proyecto
# -------------------------------
COPY . .

# -------------------------------
# Directorios de salida
# -------------------------------
RUN mkdir -p /app/allure-results /app/test-results

# -------------------------------
# Variables de entorno
# -------------------------------
ENV NODE_ENV=production

# -------------------------------
# Comando por defecto
# -------------------------------
CMD ["npx", "newman", "run", "TMSQAAPITEST.postman_collection.json", "-d", "datagetaction.json"]
