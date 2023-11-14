# Wrap text in unordered list html
wrap_li <- function(dir) {
  
  # Base url
  url_base <- "https://FOSIL-project.github.io"
  
  # Create tibble of links and wrap in httml for list
  posts <- fs::dir_ls(glue::glue("{here::here('posts')}/{dir}"), regexp = ".qmd") |>
    tibble::as_tibble() |>
    dplyr::mutate(
      value = stringr::str_remove_all(value, here::here()), 
      value = stringr::str_replace_all(value, ".qmd", ".html"), 
      lang = stringr::str_remove_all(value, glue::glue("/posts/{dir}/")), 
      lang = stringr::str_remove_all(lang, ".html"), 
      lang = dplyr::case_when(
        lang == "index" ~ "English", 
        lang == "index_sp" ~ "Español", 
        lang == "index_fr" ~ "Français", 
        lang == "index_cp" ~ "官話", 
        lang == "index_ro" ~ "Română", 
        lang == "index_hi" ~ "हिंदी"
      ), 
      url = glue::glue("{value}"), 
      li  = glue::glue("<li><a class='dropdown-item' href='{url}'>{lang}</a></li>\n")
    ) |>
    dplyr::pull(li)
  
  return(posts)
}

print_list <- function(dir, butt_text = "text") {
  
  # Create vectors of button elements
  open_div  <- "<div class='dropdown'>"
  open_but  <- " <button class='btn-sm btn-secondary dropdown-toggle' type='button' id='dropdownMenuButton1' data-bs-toggle='dropdown' aria-expanded='false'>"
  close_but <- " </button>"
  open_ul   <- " <ul class='dropdown-menu dropdown-menu-dark' aria-labelledby='dropdownMenuButton1'>"
  close_ul  <- " </ul>"
  close_div <- "</div>"
  items     <- wrap_li(dir)
  
  # Put all the pieces together
  cat(
    paste0(open_div, "\n"), 
    paste0(open_but, "\n"), 
    paste0(" ", butt_text, "\n"), 
    paste0(close_but, "\n"), 
    paste0(open_ul, "\n"), 
    paste0(" ", items, "\n"), 
    paste0(close_ul, "\n"), 
    paste0(close_div)
  )
}
