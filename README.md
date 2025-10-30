# smart-input-pro.nvim - Smart Input Pro 的 Neovim 实现

一个用于 VSCode Neovim 环境的轻量桥接插件：将 Neovim 的模式变化同步到 Smart Input Pro（VSCode 扩展），以便扩展进行模式敏感的行为。

- 适用范围：VSCode + `vscode-neovim` + Smart Input Pro（VSCode 扩展）
- 运行开销：极小，仅两个自动命令

---

## 安装要求

- Neovim `>= 0.7.0`
  - 说明：本插件使用 `vim.api.nvim_create_autocmd`（Neovim 0.7+ 提供）。
- VSCode 安装并启用 `vscode-neovim` 扩展（用于在 VSCode 内嵌 Neovim，并暴露 `require('vscode')` API）。
- 必须安装 Smart Input Pro VSCode 插件
  - 兼容性要求：扩展需提供命令 `smartInputPro.receiveVimModeChange`。
  - 版本建议：请使用稳定版本；若扩展端命令更名或签名变更，请同步升级本插件或固定扩展版本以保持兼容。

---

## 安装

### 使用 lazy.nvim
```lua
{
  "szb000801/smart-input-pro.nvim",
  opts = {}, -- 当前无可配置项
  config = function(_, opts)
    require("smart-input-pro").setup()
  end,
}
```

### 使用 packer.nvim
```lua
use {
  "szb000801/smart-input-pro.nvim",
  config = function()
    require("smart-input-pro").setup()
  end,
}
```

### 使用 vim-plug
```vim
Plug 'szb000801/smart-input-pro.nvim'
" 在合适位置添加：
lua << EOF
require("smart-input-pro").setup()
EOF
```

VSCode 环境提示：
- 安装并启用 `vscode-neovim` 扩展，确保其已正确指向你的 Neovim 可执行文件。
- 安装并启用 Smart Input Pro VSCode 扩展，使其在当前工作区生效。

---


## 故障排查

- 非 VSCode 环境
  - 现象：调用 `setup()` 无任何效果。
  - 处理：本插件仅在 VSCode + `vscode-neovim` 环境下工作；纯 Neovim 使用不适用。

- 找不到 `vscode` 模块
  - 现象：`require('vscode')` 报错。
  - 处理：确认已安装并启用 `vscode-neovim` 扩展；在 VSCode 中使用 Neovim。

- VSCode 扩展命令未找到
  - 现象：调用 `smartInputPro.receiveVimModeChange` 提示不存在。
  - 处理：确认 Smart Input Pro VSCode 扩展已安装并启用；检查扩展版本是否提供该命令。

- 自动命令未触发
  - 现象：模式切换未上报或延迟。
  - 处理：确保插件已正确加载；若使用懒加载，请保证在进入 Insert 模式之前执行 `setup()`。

- 版本不匹配
  - 现象：扩展或本插件更新后不兼容。
  - 处理：同步升级 VSCode 扩展与本插件到对应版本，或回滚到已知可用的版本组合。

---

## 贡献指南

欢迎贡献改进（如新增模式事件、可选配置、兼容性适配等）：
- 提交 Issue：清晰描述场景、期望行为与复现步骤。
- 提交 PR：保持改动最小、风格一致；附上测试或使用说明。
- 开发建议：在 VSCode 中联调扩展端与 Neovim 端；新增事件需确保在非 VSCode 环境下安全退出。

---

## 开发文档链接

- Smart Input Pro（VSCode 扩展）文档与 API：请参考扩展官方仓库与文档。
- `vscode-neovim` 扩展文档：用于了解 `require('vscode')` 的调用约束与调试方法。

---

## 许可协议

请遵循本仓库所采用的许可证（如未声明，请在引入前确认授权条款）。

