local M = {}

local ns = vim.api.nvim_create_namespace("LspRenameHighlight")

local function add_highlight(bufnr, range, encoding)
  local start_col = vim.lsp.util._get_line_byte_from_position(bufnr, range.start, encoding)
  local end_col = vim.lsp.util._get_line_byte_from_position(bufnr, range["end"], encoding)
  if start_col and end_col and end_col > start_col then
    vim.api.nvim_buf_add_highlight(bufnr, ns, "LspRenameTarget", range.start.line, start_col, end_col)
  end
end

local function highlight_references(bufnr, client, params)
  if not client or not client.supports_method("textDocument/references") then
    return
  end
  local ref_params = vim.tbl_deep_extend("force", params, { context = { includeDeclaration = true } })
  client:request("textDocument/references", ref_params, function(err, result)
    if err or not result then
      return
    end
    for _, ref in ipairs(result) do
      if ref.range then
        add_highlight(bufnr, ref.range, client.offset_encoding)
      end
    end
  end, bufnr)
end

function M.rename_with_highlight()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  local encoding
  for _, client in ipairs(clients) do
    if client.supports_method("textDocument/prepareRename") or client.supports_method("textDocument/rename") then
      encoding = client.offset_encoding or "utf-16"
      break
    end
  end
  if not encoding and clients[1] then
    encoding = clients[1].offset_encoding or "utf-16"
  end

  local params = vim.lsp.util.make_position_params(0, encoding)

  vim.lsp.buf_request_all(bufnr, "textDocument/prepareRename", params, function(responses)
    local target
    for client_id, resp in pairs(responses or {}) do
      if not resp.err and resp.result then
        local client = vim.lsp.get_client_by_id(client_id)
        if client then
          local range = resp.result.range or resp.result
          if range then
            target = {
              client = client,
              range = range,
              placeholder = resp.result.placeholder,
            }
            break
          end
        end
      end
    end

    local original_text
    if target then
      vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
      add_highlight(bufnr, target.range, target.client.offset_encoding)
      highlight_references(bufnr, target.client, params)

      original_text = table.concat(
        vim.api.nvim_buf_get_text(
          bufnr,
          target.range.start.line,
          vim.lsp.util._get_line_byte_from_position(bufnr, target.range.start, target.client.offset_encoding),
          target.range["end"].line,
          vim.lsp.util._get_line_byte_from_position(bufnr, target.range["end"], target.client.offset_encoding),
          {}
        ),
        "\n"
      )
      original_text = target.placeholder or original_text
    else
      original_text = vim.fn.expand("<cword>")
      if original_text == "" then
        vim.notify("无法重命名此符号", vim.log.levels.WARN)
        return
      end
      local cursor = vim.api.nvim_win_get_cursor(0)
      local line_nr = cursor[1] - 1
      local line = vim.api.nvim_buf_get_lines(bufnr, line_nr, line_nr + 1, false)[1] or ""
      local match = { vim.fn.matchstrpos(line, vim.pesc(original_text), cursor[2]) }
      local start_col = match[2] or cursor[2]
      local end_col = match[3] or (start_col + #original_text)
      if start_col >= 0 and end_col > start_col then
        vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
        vim.api.nvim_buf_add_highlight(bufnr, ns, "LspRenameTarget", line_nr, start_col, end_col)
      end
      local ref_client = vim.iter(clients):find(function(c)
        return c.supports_method("textDocument/references")
      end)
      if ref_client then
        highlight_references(bufnr, ref_client, params)
      end
    end

    vim.ui.input({ prompt = "Rename to: ", default = original_text }, function(new_name)
      vim.api.nvim_buf_clear_namespace(bufnr, ns, 0, -1)
      if new_name and #new_name > 0 and new_name ~= original_text then
        vim.lsp.buf.rename(new_name)
      end
    end)
  end)
end

return M
