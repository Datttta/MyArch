require('lspconfig').rust_analyzer.setup {
   settings = {
      ['rust-analyzer'] = {
         cargo = {
            allFeatures = true,
            loadOutDirsFromCheck = true,
            buildScripts = {
               enable = true,
            },
         },
         checkOnSave = {
            enable = true,
            command = 'check',
         },
         procMacro = {
            enable = true,
         },
      },
   },
}
