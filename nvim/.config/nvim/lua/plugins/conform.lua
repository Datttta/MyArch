return {
   {
      'stevearc/conform.nvim',
      opts = {
         formatters_by_ft = {
            lua = { 'stylua' },
            python = { 'ruff_format' },
            rust = { 'rustfmt' },
            c = { 'clang_format' },
            cpp = { 'clang_format' },
            json = { 'prettier' },
            jsonc = { 'prettier' },
            sql = { 'sql_formatter' },
            terraform = { 'terraform_fmt' },
            yaml = { 'yamlfmt' },
            sh = { 'shfmt' },
            bash = { 'shfmt' },
            dockerfile = { 'dockerfmt' },
            ['docker-compose'] = { 'prettier' },
            css = { 'prettier' },
         },
      },
   },
}
