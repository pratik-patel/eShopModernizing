@echo [93m Creating the 'deploy' folder tree[0m

@echo [93m Building Legacy Webforms project...[0m
..\nuget.exe restore eShopLegacyWebForms.sln
"C:\Program Files\Microsoft Visual Studio\18\Community\MSBuild\Current\Bin\amd64\MSBuild.exe" src\eShopLegacyWebForms\eShopLegacyWebForms.csproj /nologo /p:PublishProfile=FolderProfile.pubxml /p:DeployOnBuild=true /p:docker_publish_root=..\..\..\deploy\webforms\

@echo [93m Copying Dockerfile to deploy folder[0m
@copy /Y src\eShopLegacyWebForms\Dockerfile deploy\webforms\

@echo [93m Building docker images... [0m
docker-compose -f docker-compose.yml -f docker-compose.override.yml build

@echo [92m Done! Run 'docker-compose up' to start the containers[0m
