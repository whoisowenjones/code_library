# file type icons
$("a.file").each(->
  filetypes =
    pdf: ["pdf"],
    doc: ["doc", "docx"],
    xls: ["xls", "xlsx"],
    txt: ["txt"],
    zip: ["zip"]
  href = $(this)[0].href
  ext = href.match(/(?!\.)[a-zA-Z]{3,4}$/)
  if ext
    ext = ext[0]
    for k, v of filetypes
      $(this).addClass(k) if ext in v
)
