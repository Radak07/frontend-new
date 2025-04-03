# Stage 1: Build React app

FROM node:22.11.0 AS build
WORKDIR /app
COPY . .
RUN npm install --legacy-peer-deps
RUN npm run build

# Stage 2: Set up Express server with React build files
FROM node:22.11.0 AS final
WORKDIR /server
COPY server/ ./
RUN npm install --legacy-peer-deps
COPY --from=build /app/build ./build
EXPOSE 5000
CMD ["node", "index.js"]
