make_request <- function(raw_req, req_url, req_time) {

  hdr_end <- find_sequence(raw_req, charToRaw("\r\n\r\n"))

  if (hdr_end < 0) {
    warning("Malformed request, returning raw response vector")
    return(raw_req)
  }

  hdrs <- rawToChar(raw_req[0:(hdr_end-1)])

  hdrs <- readr::read_lines(hdrs)

  req_parts <- stri_split_fixed(hdrs[1], " ")[[1]]

  hdrs <- hdrs[-1]

  tmp <- as_tibble(stri_split_fixed(hdrs, ":", 2, simplify=TRUE))

  hdrs <- insensitive(as.list(setNames(trimws(tmp$V2), tmp$V1)))

  list(
    method = req_parts[1],
    url = req_url,
    headers = as.vector(hdrs),
    fields = NULL,
    date = anytime(req_time),
    options = list(
      useragent = hdrs[["useragent"]],
      post = (req_parts[1] == "POST"),
      postfieldsize = length(raw_req[(hdr_end+4):length(raw_req)]),
      postfields = raw_req[(hdr_end+4):length(raw_req)]
    ),
    auth_token = NULL,
    output = list()
  ) -> req
  class(req) <- "request"

  req

}
