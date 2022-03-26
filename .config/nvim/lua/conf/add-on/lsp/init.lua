local status_ok, _ = pcall(require, 'lspconfig')
if not status_ok then
	return
end

require('conf.add-on.lsp.lsp-installer')
require('conf.add-on.lsp.handlers').setup()
