#!/bin/bash

set -e

WITH_UPDATE=false
VENV_PATH=".venv"
PORT=8000
CONFIG_PATH="mkdocs.yml"

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --with-update)
            WITH_UPDATE=true
            shift
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# WithUpdateが指定されている場合、既存の仮想環境を削除
if [[ "$WITH_UPDATE" == true && -d "$VENV_PATH" ]]; then
    echo -e "\033[33m.venvを削除します ($VENV_PATH)\033[0m"
    rm -rf "$VENV_PATH"
fi

# 仮想環境を作成
if [[ ! -d "$VENV_PATH" ]]; then
    echo -e "\033[32m仮想環境を作成します ($VENV_PATH)\033[0m"
    python3 -m venv "$VENV_PATH"
    
    if [[ $? -eq 0 ]]; then
        echo -e "\033[32m仮想環境の作成に成功しました\033[0m"

        # 仮想環境を有効化
        source "$VENV_PATH/bin/activate"

        echo -e "\033[36mUpgrade pip\033[0m"
        python -m pip install --upgrade pip

        pip install mkdocs-material             # Material for MkDocsテーマをインストール
        pip install mkdocs                      # MkDocs本体をインストール
        pip install mkdocs-awesome-pages-plugin # ナビゲーション構造のカスタマイズ用プラグイン
        pip install pymdown-extensions          # Markdown拡張機能（コードハイライト、タブなど）をインストール
        pip install mkdocs-mermaid2-plugin      # Mermaid.jsを使用するためのMkDocsプラグインをインストール
        pip install mkdocs-open-in-new-tab      # リンクを新しいタブで開くためのMkDocsプラグインをインストール
        pip install mkdocs-to-pdf               # PDF出力のためのMkDocs to PDFプラグインをインストール
        pip install weasyprint                  # PDF出力のためのWeasyPrintをインストール

        mkdocs serve --dev-addr=127.0.0.1:$PORT -f "$CONFIG_PATH"
    else
        echo -e "\033[31m仮想環境の作成に失敗しました\033[0m" >&2
        exit 1
    fi
else
    # 仮想環境を有効化
    source "$VENV_PATH/bin/activate"

    mkdocs serve --dev-addr=127.0.0.1:$PORT -f "$CONFIG_PATH"
fi