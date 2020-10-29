FROM node:10.9.0 AS compile-image
WORKDIR /app/frontend
COPY ./LiveMapApp/ClientApp/ ./
 
RUN npm install
RUN npm run build -- --prod

FROM mcr.microsoft.com/dotnet/core/sdk:3.1
WORKDIR /app

RUN mkdir code

RUN ls

COPY ./ ./code

RUN ls ./code

RUN dotnet build ./code/LiveMapApp/ --configuration Release -o ./

RUN mkdir ./ClientApp
RUN mkdir ./ClientApp/dist

COPY --from=compile-image /app/frontend/dist/ ./ClientApp/dist/
#RUN dotnet build --configuration Release -o out
RUN ls

ENV DB_HOST=postgres

EXPOSE 80

ENTRYPOINT ["dotnet", "./LiveMapApp.dll"]