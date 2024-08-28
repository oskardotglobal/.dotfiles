{...}: {
  home.file."/.config/nvim/init.vim" = {
    enable = true;
    source = ./config/init.vim;
  };
}
