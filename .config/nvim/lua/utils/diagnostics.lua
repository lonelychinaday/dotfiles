local M = {}

local diagnostic_signs = {
	Error = "",
	Warn = "",
	Hint = "",
	Info = "󰋽",
}




M.setup = function()
	vim.diagnostic.config({
		signs = {
			text = {
				[vim.diagnostic.severity.ERROR] = diagnostic_signs.Error,
				[vim.diagnostic.severity.WARN] = diagnostic_signs.Warn,
				[vim.diagnostic.severity.INFO] = diagnostic_signs.Info,
				[vim.diagnostic.severity.HINT] = diagnostic_signs.Hint,
			},
		},
		underline = true,
		virtual_text = true,
		virtual_lines = false,
		update_in_insert = true, -- 在插入模式下更新错误
		severity_sort = true, -- 按严重程度排序
	})

	-- 诊断过滤：每行只显示严重程度最高的一个诊断
	-- local orig_set = vim.diagnostic.set

	-- vim.diagnostic.set = function(namespace, bufnr, diagnostics, opts)
	-- 	if not diagnostics or #diagnostics == 0 then
	-- 		return orig_set(namespace, bufnr, diagnostics, opts)
	-- 	end

	-- 	-- 获取当前 buffer 的所有诊断（包括其他 namespace 的）
	-- 	local all_diagnostics = vim.diagnostic.get(bufnr)
		
	-- 	-- 合并新的诊断
	-- 	for _, diag in ipairs(diagnostics) do
	-- 		table.insert(all_diagnostics, diag)
	-- 	end

	-- 	-- 按行号分组
	-- 	local line_diagnostics = {}
	-- 	for _, diag in ipairs(all_diagnostics) do
	-- 		local line = diag.lnum
	-- 		if not line_diagnostics[line] then
	-- 			line_diagnostics[line] = {}
	-- 		end
	-- 		table.insert(line_diagnostics[line], diag)
	-- 	end

	-- 	-- 每行只保留严重程度最高的诊断
	-- 	local filtered = {}
	-- 	for line, diags in pairs(line_diagnostics) do
	-- 		-- 按严重程度排序：ERROR(1) < WARN(2) < INFO(3) < HINT(4)
	-- 		table.sort(diags, function(a, b)
	-- 			return (a.severity or 4) < (b.severity or 4)
	-- 		end)
			
	-- 		-- 只保留第一个（严重程度最高的）
	-- 		if diags[1] then
	-- 			table.insert(filtered, diags[1])
	-- 		end
	-- 	end

	-- 	-- 清空当前 namespace 的诊断，然后设置过滤后的
	-- 	orig_set(namespace, bufnr, {}, opts)
		
	-- 	-- 使用一个统一的 namespace 设置所有诊断
	-- 	local unified_ns = vim.api.nvim_create_namespace("unified_diagnostics")
	-- 	return orig_set(unified_ns, bufnr, filtered, opts)
	
	-- end
end

return M
