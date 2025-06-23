# MkDocsStudy

このリポジトリは、**MkDocs** を使ったドキュメントサイト構築の学習用プロジェクトです。  
特に **日本語対応**、**MermaidダイアグラムのWeb/PDF表示**、および関連プラグインの活用方法に重点を置いています。

---

## 目的

- MkDocsで日本語ドキュメントを快適に作成・検索できる環境を構築する
- Mermaid.jsによるダイアグラムをWeb表示・PDF出力の両方で正しく扱う
- よく使うプラグインや拡張機能の導入・設定例をまとめる

---

## 主な構成・特徴

- **テーマ**: [Material for MkDocs](https://squidfunk.github.io/mkdocs-material/)
- **日本語検索対応**: `search`プラグインのlang設定・トークン分割パターン調整
- **Mermaid.js対応**: `mkdocs-mermaid2-plugin`（Web表示）、`mkdocs-to-pdf`＋`weasyprint`（PDF出力）
- **ナビゲーション制御**: `mkdocs-awesome-pages-plugin`
- **Markdown拡張**: `pymdown-extensions`
- **リンク新規タブ**: `mkdocs-open-in-new-tab`
- **PDF出力**: `mkdocs-to-pdf`, `weasyprint`

---

## セットアップ手順

1. **リポジトリをクローン**

   ```sh
   git clone <このリポジトリのURL>
   cd MkDocsStudy
   ```

2. **PowerShellスクリプトで仮想環境構築＆依存パッケージ導入**

   ```powershell
   .\Invoke-MkDocs.ps1
   ```

   - `-WithUpdate` オプションを付けると仮想環境を再作成します。

3. **ローカルサーバ起動**

   スクリプト実行後、自動で `http://127.0.0.1:8000` でサイトが開きます。

---

## MermaidダイアグラムのWeb/PDF対応

- **Web表示**:  
  `mkdocs-mermaid2-plugin` により、Markdown内のMermaidコードブロックが自動的に描画されます。

- **PDF出力**:  
  `mkdocs-to-pdf` + `weasyprint` を利用し、Mermaidダイアグラムを含むページをPDF化できます。

---

## 日本語対応のポイント

- `mkdocs.yml` の `search` プラグインで `lang: ja` を指定
- トークン分割パターンや最小検索文字数も日本語向けに調整済み

---

## 主要ファイル

- `mkdocs.yml` … サイト設定・プラグイン構成
- `Invoke-MkDocs.ps1` … 仮想環境構築・依存パッケージ導入・サーバ起動スクリプト
- `docs/` … ドキュメント本体（Markdownファイル）

---

## 参考

- [MkDocs公式](https://www.mkdocs.org/)
- [Material for MkDocs公式](https://squidfunk.github.io/mkdocs-material/)
- [mkdocs-mermaid2-plugin](https://github.com/fralau/mkdocs-mermaid2-plugin)
- [mkdocs-to-pdf](https://github.com/orzih/mkdocs-to-pdf)

---