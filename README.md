Flutter最終課題用のリポジトリです。

## Client IDとClient Secretのダウンロード
Client IDとClient Secretが記載されたqiita_auth_key.dartをこちらからダウンロードお願いします。
ファイルの格納場所はmobile_qiita_app/lib/qiita_auth_key.dartです。

qiita_auth_key.dartはセキュリティの観点より、.gitignoreでgitの管理下から外しています。
このファイルはmobile_qiita_appのプログラムを実行する上で欠かせないため、必ず指定場所にダウンロードお願いします。

<br>

## 必要な実装内容一覧と進める順番
 - [x] TopPage・認証以外の実装のみ
 - [x] BottomNavigationBar・タブアイコンをタップして画面を切り替える
 - [x] FeedPage・記事一覧データ表示
 - [x] FeedPage・記事一覧をタップして記事ページを表示
 - [x] FeedPage・検索バーを配置して検索
 - [x] FeedPage・ページネーション実装(リストを下まで到達したら追加読み込み)
 - [x] TagPage・タグ一覧を取得してデータ表示
 - [x] TagPage・タグをタップして遷移
 - [x] TagPage・ページネーション実装
 - [x] TagDetailListPage・タグに紐づいたデータ表示
 - [x] TagDetailListPage・記事をタップして記事ページを表示
 - [x] MyPage・ログイン画面での認証機能
 - [x] MyPage・認証したユーザーの情報表示
 - [ ] MyPage・フォロー - [ ]  フォロワーリストへの遷移
 - [ ] MyPage・ページネーション実装
 - [ ] FollowsFollowersListPage・ユーザー一覧実装
 - [ ] FollowsFollowersListPage・ページネーション実装
 - [ ] UserPage・ユーザー画面実装
 - [ ] UserPage・ページネーション実装
 - [ ] SettingPage・UI実装
 - [ ] SettingPage・利用規約・プライバシーポリシー
 - [ ] SettingPage・ログアウト
 - [ ] ErrorView・エラー画面
