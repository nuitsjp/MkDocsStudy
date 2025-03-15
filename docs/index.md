# はじめに

KAMISHIBAIは、Generic Host上でMVVMパターンをサポートするWPF用の画面遷移ライブラリです。ViewModelのコンストラクターに引数を宣言することで、専用の画面遷移メソッドをコード生成します。

画面遷移時にstringをわたす場合、つぎのようにViewModelを定義します。

```cs
[Navigate]
public class FirstViewModel
{
    public FirstViewModel(string message)
    {
        Message = message;
    }

    public string Message { get; }
}
```

すると専用の画面遷移メソッドが自動生成され、つぎのように呼び出すことができます。

```cs
await _presentationService.NavigateToFirstAsync("Hello, KAMISHIBAI!");
```

またはDIを併用することも可能です。

```cs
public FirstViewModel(
    string message, 
    [Inject] ILogger<FirstViewModel> logger)
```

コンストラクターの引数にInjectAttributeを宣言することで、messageとはことなり、DIコンテナーから依存性を注入することもできます。先の画面遷移とまったく同じように画面遷移を呼び出すことができます。

KAMISHIBAIでは画面遷移時の型安全性が保障され、nullableを最大限に活用した安全な実装が実現できます。

KAMISHIBAIは、WPFの機能を一切制限せず下記を実現します。

- Generic Hostのサポート
- MVVMパターンを適用したViewModel起点の画面遷移
- 型安全性の保証された画面遷移時パラメーター
- 画面遷移にともなう一貫性あるイベント通知
- nullableを最大限活用するためのサポート

Generic Hostをサポートすることで、ほとんどの .NETの最新テクノロジーがWPFで活用できます。

KAMISHIBAIは下記の機能を提供します。

- 画面遷移
- 新しい画面・ダイアログの表示
- メッセージダイアログ・ファイル選択・保存ダイアログの表示

KAMISHIBAIを利用することで、もっとも効率よく、安全にMVVMパターンに則った画面遷移を実現できます。

そして既存のあらゆるMVVMフレームワークと同居が可能です。ただしひとつだけ制約が発生します。

画面遷移にはKAMISHIBAIを利用してください。

では実際にKAMISHIBAIを利用してみましょう！