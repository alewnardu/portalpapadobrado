# portalpapadobrado
Repositório do projeto do sistema Papa Dobrado

## Instalação

### Docker

docker compose up --build -d

### Prisma

docker exec -it portalpapadobrado_app npm install 

docker exec -it portalpapadobrado_app npm list

docker exec -it portalpapadobrado_app npx prisma migrate dev

docker exec -it portalpapadobrado_app npx prisma generate