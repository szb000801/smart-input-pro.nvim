local M = {}

function M.setup()
	if not vim.g.vscode then
		vim.notify("smart-input-pro: Not in VSCode Neovim environment", vim.log.levels.WARN)
		return
	end

	local ok, vscode = pcall(require, 'vscode')
	if not ok then
		vim.notify("smart-input-pro: Failed to load vscode module", vim.log.levels.ERROR)
		return
	end

	vim.api.nvim_create_autocmd("InsertEnter", {
		callback = function()
			vscode.call("smartInputPro.receiveVimModeChange", { args = { "Insert" } })
		end,
	})

	vim.api.nvim_create_autocmd("InsertLeave", {
		callback = function()
			vscode.call("smartInputPro.receiveVimModeChange", { args = { "Normal" } })
		end,
	})

	vim.notify("smart-input-pro: Loaded successfully", vim.log.levels.INFO)
end

-- 自动初始化
if vim.g.vscode then
	M.setup()
end

return M
