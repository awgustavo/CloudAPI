FROM mcr.microsoft.com/dotnet/core/sdk:3.1
WORKDIR /app

COPY ./ ./

#RUN dotnet build --configuration Release -o out

    
RUN dotnet publish ./CloudAPI/ --configuration Release -o out

ENV DB_HOST=postgres

EXPOSE 80

ENTRYPOINT ["dotnet", "/app/out/CloudAPI.dll"]