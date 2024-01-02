# Stage 1: Build the first project
FROM mcr.microsoft.com/dotnet/sdk:8.0-nanoserver-1809 AS build1
ARG BUILD_CONFIGURATION=Release
WORKDIR "/Invinsense.Server"
COPY ["Invinsense.Server/Invinsense.Server.csproj", "."]
RUN dotnet restore "/Invinsense.Server.csproj"
COPY . .
WORKDIR "/Invinsense.Server/."
RUN dotnet build "./Invinsense.Server.csproj" -c %BUILD_CONFIGURATION% -o /app/build1

# Stage 2: Publish the first project
FROM build1 AS publish1
ARG BUILD_CONFIGURATION=Release
WORKDIR "/Invinsense.Server/Invinsense.Server"
RUN dotnet publish "./Invinsense.Server.csproj" -c %BUILD_CONFIGURATION% -o /app/publish1 /p:UseAppHost=false

# Stage 3: Build the second project
FROM mcr.microsoft.com/dotnet/sdk:8.0-windowsservercore-ltsc2019 AS build2
WORKDIR "/WazuhScheduler"
COPY ["WazuhScheduler/WazuhScheduler.csproj", "."]
RUN dotnet restore "./WazuhScheduler.csproj"
COPY . .
WORKDIR "/WazuhScheduler/."
RUN dotnet build "./WazuhScheduler.csproj" -c %BUILD_CONFIGURATION% -o /app/build2

# Stage 4: Publish the second project
FROM build2 AS publish2
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "./WazuhScheduler.csproj" -c %BUILD_CONFIGURATION% -o /app/publish2 /p:UseAppHost=true

# Stage 5: Create the final image
FROM mcr.microsoft.com/dotnet/runtime:8.0-nanoserver-1809 AS final
WORKDIR /app
COPY --from=publish1 /app/publish1 .
COPY --from=publish2 /app/publish2 .
ENTRYPOINT ["dotnet", "Invinsense.Server.dll"]
