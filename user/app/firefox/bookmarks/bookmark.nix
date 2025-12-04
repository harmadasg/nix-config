{
  force = true;
  settings = [
    {
      name = "Bookmarks Toolbar";
      toolbar = true;
      bookmarks =
        (import ./personal.nix)
        ++ [
          {
            name = "Work";
            bookmarks = import ./work.nix;
          }
        ];
    }
  ];
}

