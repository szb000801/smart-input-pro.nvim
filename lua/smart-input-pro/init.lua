local M = {}

function M.setup()
	local vscode = require("vscode")
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
end

return M
