# Вспомогательная функция для выполнения команд с учётом флага fvm
function Invoke-WithFvm {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Command,
        [switch]$fvm
    )

    if ($fvm) {
        # Формируем команду с префиксом "fvm exec"
        $fullCommand = "fvm exec $Command"
    }
    else {
        $fullCommand = $Command
    }
    Write-Host "$fullCommand" -ForegroundColor Magenta
    Invoke-Expression $fullCommand
}

function build {
    param(
        [switch]$fvm  # Флаг для выполнения команд через fvm
    )

    # Получаем текущую директорию
    $currentDir = Get-Location

    # Если текущая директория оканчивается на "_flutter"
    if ($currentDir -match '_flutter$') {
        # Выполняем команды в текущей директории
        Invoke-WithFvm "dart run build_runner build" -fvm:$fvm
        Invoke-WithFvm "fluttergen" -fvm:$fvm
    }
    else {
        # Ищем поддиректорию, оканчивающуюся на "_flutter"
        $flutterDir = Get-ChildItem -Directory | Where-Object { $_.Name -match '_flutter$' }

        if ($flutterDir) {
            # Переходим в найденную поддиректорию
            Set-Location $flutterDir.FullName

            Invoke-WithFvm "dart run build_runner build" -fvm:$fvm
            Invoke-WithFvm "fluttergen" -fvm:$fvm

            # Возвращаемся в исходную директорию
            Set-Location ..
        }
        else {
            Write-Host "Не найдена директория, оканчивающаяся на '_flutter'."
        }
    }
}

function build-server {
    param(
        [switch]$f,    # Флаг для принудительного создания миграции
        [switch]$fvm   # Флаг для выполнения команд через fvm
    )

    # Получаем текущую директорию
    $currentDir = Get-Location

    # Если текущая директория оканчивается на "_server"
    if ($currentDir -match '_server$') {
        Invoke-WithFvm "serverpod generate" -fvm:$fvm

        if ($f) {
            Invoke-WithFvm "serverpod create-migration -f" -fvm:$fvm
        }
        else {
            Invoke-WithFvm "serverpod create-migration" -fvm:$fvm
        }

        Invoke-WithFvm "dart run bin/main.dart --role maintenance --apply-migrations" -fvm:$fvm
    }
    else {
        # Ищем поддиректорию, оканчивающуюся на "_server"
        $serverDir = Get-ChildItem -Directory | Where-Object { $_.Name -match '_server$' }

        if ($serverDir) {
            # Переходим в найденную поддиректорию
            Set-Location $serverDir.FullName

            Invoke-WithFvm "serverpod generate" -fvm:$fvm

            if ($f) {
                Invoke-WithFvm "serverpod create-migration -f" -fvm:$fvm
            }
            else {
                Invoke-WithFvm "serverpod create-migration" -fvm:$fvm
            }

            Invoke-WithFvm "dart run bin/main.dart --role maintenance --apply-migrations" -fvm:$fvm

            # Возвращаемся в исходную директорию
            Set-Location ..
        }
        else {
            Write-Host "Не найдена директория, оканчивающаяся на '_server'."
        }
    }
}

function build-full {
    param(
        [switch]$f,    # Флаг для принудительного создания миграции
        [switch]$fvm   # Флаг для выполнения команд через fvm
    )

    build -fvm:$fvm
    build-server -f:$f -fvm:$fvm
}
