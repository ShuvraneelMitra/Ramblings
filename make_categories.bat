@echo off
setlocal enabledelayedexpansion

REM Directory containing posts
set POSTS_DIR=_posts

REM Output folder for category pages (can be . or categories)
set OUT_DIR=.

echo === Generating category pages ===

REM Delete old generated category files if any
for %%f in (%OUT_DIR%\*.md) do (
    findstr /B /C:"category:" "%%f" >nul && del "%%f"
)

REM Loop through all Markdown posts and extract categories
for /R "%POSTS_DIR%" %%f in (*.md) do (
    for /F "tokens=2 delims=[]" %%a in ('findstr /R "^categories:" "%%f"') do (
        for %%c in (%%a) do (
            set cat=%%~c
            set cat=!cat:,=!
            set cat=!cat:"=!
            set cat=!cat:[=!
            set cat=!cat:]=!
            set cat=!cat: =!
            if not "!cat!"=="" (
                set FILE=%OUT_DIR%\!cat!.md
                if not exist "!FILE!" (
                    echo Creating category page: !cat!
                    (
                        echo --- 
                        echo layout: category
                        echo title: !cat!
                        echo category: !cat!
                        echo permalink: /!cat!/
                        echo ---
                    ) > "!FILE!"
                )
            )
        )
    )
)

echo Done!
pause
