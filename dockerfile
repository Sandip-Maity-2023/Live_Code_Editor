# Build the Frontend [dist folder]
# Copy the dist folder content in Backend/public folder

FROM node:20-alpine as client-builder

COPY ./client /app

WORKDIR /app

RUN npm install

RUN npm run build

# Build the Backend
FROM node:20-alpine

COPY ./server /app

WORKDIR /app

RUN npm install

COPY --from=client-builder /app/dist /app/public

CMD ["node", "server.js"]