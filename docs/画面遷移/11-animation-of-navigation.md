---
title: "画面遷移時にアニメーションを追加する"
---

Storyboardを適用することで、画面遷移時にアニメーションを追加できます。

![](../images/animation.gif)

```xml
<Window ...>
    <Window.Resources>
        <Storyboard x:Key="ExitStoryboard">
            <DoubleAnimation 
                Storyboard.TargetName="MainFrame"
                Storyboard.TargetProperty="(kamishibai:NavigationFrame.Opacity)" 
                From="1" To="0" Duration="0:0:0.5"/>
        </Storyboard>
        <Storyboard x:Key="EntryStoryboard">
            <DoubleAnimation 
                Storyboard.TargetName="MainFrame"
                Storyboard.TargetProperty="(kamishibai:NavigationFrame.Opacity)" 
                From="0" To="1" Duration="0:0:0.5"/>
        </Storyboard>
    </Window.Resources>
    <Grid>
        <kamishibai:NavigationFrame 
            x:Name="MainFrame"
            ExitForwardStoryboard="{StaticResource ExitStoryboard}"
            EntryForwardStoryboard="{StaticResource EntryStoryboard}"
            ExitBackwardStoryboard="{StaticResource ExitStoryboard}"
            EntryBackwardStoryboard="{StaticResource EntryStoryboard}"/>
    </Grid>
</Window>
```

Storyboardは4つのタイミングに設定が可能です。

|プロパティ|説明|
|--|--|
|ExitForwardStoryboard|前方に画面遷移する際、遷移元にStoryboardを適用する|
|EntryForwardStoryboard|前方に画面遷移する際、遷移先にStoryboardを適用する|
|ExitBackwardStoryboard|戻る時、遷移元にStoryboardを適用する|
|EntryBackwardStoryboard|戻る時、遷移先にStoryboardを適用する|

たとえば前方に遷移する場合、つぎの順で実行されます。

1. ExitForwardStoryboard
2. 画面遷移
3. EntryForwardStoryboard

これらは同期的に処理されるため、退場のアニメーション後に、入場アニメーションをつなげることができます。

画面遷移イベントはアニメーション中に実行されます。詳しく説明すると、つぎの通りとなります。

1. **ExitForwardStoryboardの開始**
2. IPausingAsyncAware#OnPausingAsync
3. IPausingAware#OnPausing
4. INavigationFramework#Pausing
5. INavigatingAsyncAware#OnNavigatingAsync
6. INavigatingAware#OnNavigating
7. INavigationFramework#Navigating
8. **ExitForwardStoryboardの終了を待機**
9. 画面遷移
10. **EntryForwardStoryboardの開始**
11. INavigatedAsyncAware#OnNavigatedAsync
12. INavigatedAware#OnNavigated
13. INavigationFramework#Navigated
14. IPausedAsyncAware#OnPausedAsync
15. IPausedAware#OnPaused
16. INavigationFramework#Paused
17. **EntryForwardStoryboardの終了を待機**
