FROM mcr.microsoft.com/dotnet/core/sdk:3.1
WORKDIR /app

COPY ./ ./
#RUN dotnet build --configuration Release -o out
RUN apt-get update && \
    apt-get install -y wget && \
    apt-get install -y gnupg2 && \
    wget -qO- https://deb.nodesource.com/setup_10.x | bash - && \
    apt-get install -y build-essential nodejs
    
RUN dotnet publish ./LiveMapApp/ --configuration Release -o out

ENV DB_HOST=postgres

EXPOSE 80

ENTRYPOINT ["dotnet", "/app/out/LiveMapApp.dll"]