@echo off
echo Starting CLIProxyAPI...
echo Ensure config.yaml is present with host: "0.0.0.0" setting.
echo.
if exist cli-proxy-api.exe (
    .\cli-proxy-api.exe -config config.yaml
) else (
    echo ERROR: cli-proxy-api.exe not found!
    echo Please check the folder content.
)
pause
