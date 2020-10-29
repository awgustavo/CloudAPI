FROM mcr.microsoft.com/dotnet/core/sdk:3.1
WORKDIR /app

COPY ./CloudAPI ./
RUN dotnet build --configuration Release -o out

ENV DB_HOST=postgres

EXPOSE 80

ENTRYPOINT ["dotnet", "/app/out/CloudAPI.dll"]