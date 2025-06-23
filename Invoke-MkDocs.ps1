param (
    [switch] $WithUpdate
)

$ErrorActionPreference = "Stop"

[string] $VenvPath = ".venv"
[int] $Port = 8000
[string] $ConfigPath = "mkdocs.yml"

# WithUpdateが指定されている場合、既存の仮想環境を削除
if ($WithUpdate -and (Test-Path $VenvPath)) {
    Write-Host ".venvを削除します ($VenvPath)" -ForegroundColor Yellow
    Remove-Item -Recurse -Force $VenvPath
}

# 仮想環境を作成
if (-not (Test-Path $VenvPath)) {
    Write-Host "仮想環境を作成します ($VenvPath)" -ForegroundColor Green
    python -m venv $VenvPath
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "仮想環境の作成に成功しました" -ForegroundColor Green

        # 仮想環境を有効化
        $activateScript = Join-Path $VenvPath -ChildPath "Scripts\Activate.ps1"
        & $activateScript

        Write-Host "Upgrade pip" -ForegroundColor Cyan
        python -m pip install --upgrade pip

        pip install mkdocs-material             # Material for MkDocsテーマをインストール
        pip install mkdocs                      # MkDocs本体をインストール
        pip install mkdocs-awesome-pages-plugin # ナビゲーション構造のカスタマイズ用プラグイン
        pip install pymdown-extensions          # Markdown拡張機能（コードハイライト、タブなど）をインストール
        pip install mkdocs-mermaid2-plugin      # Mermaid.jsを使用するためのMkDocsプラグインをインストール
        pip install mkdocs-open-in-new-tab      # リンクを新しいタブで開くためのMkDocsプラグインをインストール
        pip install mkdocs-to-pdf               # PDF出力のためのMkDocs to PDFプラグインをインストール
        pip install weasyprint                  # PDF出力のためのWeasyPrintをインストール

        mkdocs serve --dev-addr=127.0.0.1:$Port -f $ConfigPath
    } else {
        Write-Error "仮想環境の作成に失敗しました"
    }
}
else {
    # 仮想環境を有効化
    $activateScript = Join-Path $VenvPath -ChildPath "Scripts\Activate.ps1"
    & $activateScript

    mkdocs serve --dev-addr=127.0.0.1:$Port -f $ConfigPath
}
