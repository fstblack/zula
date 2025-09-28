@echo off
title KDMapper Loader

:: Nome do executável a ser aberto após carregar o driver (altere conforme necessário)
set "EXE_FILE=zula.exe"

:: Procura por arquivos .sys no diretório atual
for %%f in (*.sys) do (
    set "DRIVER_FILE=%%f"
    goto :found
)

echo [ERRO] Nenhum arquivo .sys encontrado no diretorio atual!
pause
exit /b 1

:found
echo Arquivo .sys encontrado: %DRIVER_FILE%
echo Executavel a ser aberto: %EXE_FILE%
echo.
set /p "confirm=Carregar driver e abrir programa? (S/N): "
if /i not "%confirm%"=="S" exit /b 0

echo.
echo Carregando %DRIVER_FILE%...
kdmapper.exe "%DRIVER_FILE%"

:: Verifica se o driver foi carregado com sucesso
if %errorlevel% equ 0 (
    echo.
    echo [SUCESSO] Driver carregado com sucesso!
    
    :: Verifica se o .exe existe
    if exist "%~dp0%EXE_FILE%" (
        echo Abrindo %EXE_FILE%...
        timeout /t 2 /nobreak >nul
        start "" "%~dp0%EXE_FILE%"
        echo Programa iniciado!
    ) else (
        echo [AVISO] %EXE_FILE% nao encontrado no diretorio atual!
        echo O driver foi carregado, mas o programa nao pode ser aberto.
    )
) else (
    echo.
    echo [ERRO] Falha ao carregar o driver. Codigo de erro: %errorlevel%
    echo O programa nao sera aberto.
)

echo.
pause
