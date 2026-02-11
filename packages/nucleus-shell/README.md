# nucleus-shell

QuickShellベースのデスクトップシェル環境パッケージ

## 概要

このパッケージは [nucleus-shell](https://github.com/xZepyx/nucleus-shell) をNixOSのflakeとHome Managerで簡単にインストールできるようにしたものです。

## インストール方法

### 1. Home Managerモジュールとしてインストール（推奨）

flakeを使用している場合、Home Managerモジュールとして組み込むことができます。

#### `flake.nix`での設定

```nix
{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, quickshell, ... }: {
    nixosConfigurations.your-hostname = nixpkgs.lib.nixosSystem {
      modules = [
        # ... 他のモジュール

        home-manager.nixosModules.home-manager
        {
          home-manager.users.your-username = {
            imports = [ self.homeManagerModules.nucleus-shell ];
            programs.nucleus-shell.enable = true;
          };
        }
      ];
    };
  };
}
```

#### 既存のHome Manager設定ファイルでの使用

すでにHome Manager設定ファイル（例: `users/hayato/home.nix`）がある場合:

```nix
# users/hayato/home.nix
{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.self.homeManagerModules.nucleus-shell
    # または直接パスを指定
    # ../../../packages/nucleus-shell/hm-module.nix
  ];

  programs.nucleus-shell.enable = true;
}
```

### 2. パッケージのみをインストール

モジュールを使わずにパッケージだけをインストールする場合:

```nix
{ config, pkgs, ... }:

{
  home.packages = [
    (pkgs.callPackage ../../packages/nucleus-shell { })
  ];
}
```

この場合、依存関係は手動で管理する必要があります。

## インストール後の確認

システムを再構築します:

```bash
sudo nixos-rebuild switch --flake .#your-hostname
```

設定ファイルが正しくインストールされているか確認:

```bash
ls ~/.config/quickshell/nucleus-shell/
```

## 含まれる依存関係

Home Managerモジュールを使用すると、以下が自動的にインストールされます:

- **QuickShell** (Qt6モジュール付き)
  - qtmultimedia
  - qt5compat
  - qtsvg
  - qtimageformats
- **upower** - 電源管理
- **ddcutil** - ディスプレイコントロール
- **material-symbols** - Material Symbolsフォント
- **google-fonts** - Google Fonts

## QuickShellの起動

インストール後、QuickShellを起動すると自動的にnucleus-shellが読み込まれます:

```bash
quickshell
```

または、Niriなどのウィンドウマネージャーの起動設定に追加します。

## カスタマイズ

### 設定ファイルの場所

設定ファイルは `~/.config/quickshell/nucleus-shell/` にシンボリックリンクとして配置されます。

カスタマイズしたい場合は、モジュールを無効化してファイルを直接コピーするか、overlayを使用してください。

### パッケージバージョンの指定

カスタムバージョンを使用する場合:

```nix
programs.nucleus-shell = {
  enable = true;
  package = pkgs.callPackage ../../packages/nucleus-shell {
    # カスタムオプション
  };
};
```

## トラブルシューティング

### QuickShellが起動しない

QuickShellが正しくインストールされているか確認:

```bash
which quickshell
quickshell --version
```

### 設定ファイルが見つからない

シンボリックリンクが正しく作成されているか確認:

```bash
ls -la ~/.config/quickshell/nucleus-shell
readlink ~/.config/quickshell/nucleus-shell
```

### フォントが表示されない

material-symbolsとgoogle-fontsがインストールされているか確認:

```bash
fc-list | grep -i material
```

## ライセンス

nucleus-shell本体: MIT License

## リンク

- [nucleus-shell GitHub](https://github.com/xZepyx/nucleus-shell)
- [QuickShell 公式サイト](https://quickshell.outfoxxed.me/)
