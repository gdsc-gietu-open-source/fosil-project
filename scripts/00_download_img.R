# link to download latest version of fosil hex sticker
img_link <- "https://raw.githubusercontent.com/jvcasillas/hex_stickers/master/stickers/fosil-project.png"

# download file
download.file(
  url = img_link, 
  destfile = here::here("img", "fosil-project.png"), 
  method = "curl", 
  quiet = FALSE, 
  mode = "w", 
  cacheOK = FALSE
  )
