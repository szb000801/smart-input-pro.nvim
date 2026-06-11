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

	-- 可以通过 :lua vim.g.smart_input_pro_debug = true/false 动态改变
	local function is_debug()
		return vim.g.smart_input_pro_debug == true
	end

	vim.api.nvim_create_autocmd("InsertEnter", {
		callback = function()
			if is_debug() then
				vim.notify("smart-input-pro: InsertEnter triggered", vim.log.levels.DEBUG)
			end
			local call_ok, call_result = pcall(function()
				return vscode.call("smartInputPro.receiveVimModeChange", { args = { "Insert" } })
			end)
			if not call_ok then
				vim.notify("smart-input-pro: InsertEnter failed: " .. tostring(call_result), vim.log.levels.ERROR)
			end
		end,
	})

	vim.api.nvim_create_autocmd("InsertLeave", {
		callback = function()
			if is_debug() then
				vim.notify("smart-input-pro: InsertLeave triggered", vim.log.levels.DEBUG)
			end
			local call_ok, call_result = pcall(function()
				return vscode.call("smartInputPro.receiveVimModeChange", { args = { "Normal" } })
			end)
			if not call_ok then
				vim.notify("smart-input-pro: InsertLeave failed: " .. tostring(call_result), vim.log.levels.ERROR)
			end
		end,
	})

	vim.notify("smart-input-pro: Loaded successfully", vim.log.levels.INFO)
end

if vim.g.vscode then
	M.setup()
end

return M
