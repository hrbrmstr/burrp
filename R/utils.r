burp_time <- function(x) {
  tmp <- gsub("[[:alnum:]]+ ([[:digit:]]{4})", "\\1", x)
  as.POSIXct(tmp, format="%a %b %d %H:%M:%S %Y")
}

make_response <- function(raw_resp, req_url, req_time) {

  hdr_end <- find_sequence(raw_resp, charToRaw("\r\n\r\n"))

  if (hdr_end < 0) {
    warning("Malformed response, returning raw response vector")
    return(raw_resp)
  }

  hdrs <- rawToChar(raw_resp[0:(hdr_end-1)])

  hdrs <- readr::read_lines(hdrs)

  status_parts <- stri_split_fixed(hdrs[1], " ")[[1]]

  hdrs <- hdrs[-1]

  tmp <- as_tibble(stri_split_fixed(hdrs, ":", 2, simplify=TRUE))

  hdrs <- insensitive(as.list(setNames(trimws(tmp$V2), tmp$V1)))

  list(
    url = req_url,
    status_code = as.numeric(status_parts[2]),
    headers = hdrs,
    all_headers = list(
      list(
        status_code = as.numeric(status_parts[2]),
        version = status_parts[1],
        headers = hdrs
      )
    ),
    date = anytime(req_time),
    content = raw_resp[(hdr_end+4):length(raw_resp)]
  ) -> resp
  class(resp) <- "response"

  resp

}
