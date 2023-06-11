@echo off
:: Remove the existing Docker image, if it exists
docker rmi abhiramns/farmin

:: Build the Docker image
docker build -t abhiramns/farmin .
if not %errorlevel%==0 goto error

:: Log in to Docker Hub
docker login
if not %errorlevel%==0 goto error

:: Push the Docker image
docker push abhiramns/farmin
if not %errorlevel%==0 goto error

echo Docker image pushed successfully

ssh -i D:/creds/linode/linode-debian root@172.232.71.167

exit /b 0

:error
echo Error encountered, exiting script
exit /b 1


