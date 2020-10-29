FROM node:10.9.0 AS compile-image
WORKDIR /app/frontend
COPY ./LiveMapApp/ClientApp/ ./
 
RUN npm install
RUN npm run build -- --prod


FROM mcr.microsoft.com/dotnet/core/sdk:3.1 as base
WORKDIR /app

COPY ./ ./
RUN dotnet build LiveMapApp --configuration Release -o out

RUN mkdir ./out/ClientApp
RUN mkdir ./out/ClientApp/dist

COPY --from=compile-image /app/frontend/dist/ ./out/ClientApp/dist/
#RUN dotnet build --configuration Release -o out
RUN mv  ./LiveMapApp ./LiveMapApp_Code
RUN cp -R ./out/* ./

RUN ls

ENV DB_HOST=postgres

EXPOSE 80

ENTRYPOINT ["dotnet", "./LiveMapApp.dll"]