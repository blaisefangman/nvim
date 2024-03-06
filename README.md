Neovim plugins derived largely from this guide: https://vonheikemen.github.io/devlog/tools/neovim-plugins-to-get-started/

Neovim LSP setup based on this related guide: https://vonheikemen.github.io/devlog/tools/setup-nvim-lspconfig-plus-nvim-cmp/

Some formatting taken from: https://github.com/folke/trouble.nvim

Tried to keep the changes minimally invasive as I prefer a simple, lightweight vim experience.

nvim as Godot external editor on Windows
-----
Prerequisites: [ncat](https://nmap.org/ncat/)

To get nvim working as a Godot external editor on Windows
  
- In Godot, go to Editor > Editor Settings > Text Editor > External
- Set Exec Path to `C:\path\to\nvim.exe` (probably in Program Files)
- Set Exec Flags to `--server 127.0.0.1:55432 --remote-send "<C-\><C-N>:n {file}<CR>:call cursor({line},{col})<CR>"`

Then, in your chosen command prompt
- Run `nvim --listen 127.0.0.1:55432 .` in your Godot project's folder

Now, if you open a gdscript file in Godot it should open in the listening nvim instance, and Godot LSP features should be working.

The above based on: https://mb-izzo.github.io/nvim-godot-solution/ and https://www.reddit.com/r/neovim/comments/13ski66/comment/jrsikd5/
