#include <Rcpp.h>
using namespace Rcpp;

//' Find the first occurrence (if any) of a sequence of raw bytes
//' (\code{pattern}) in \code{buffer}.
//'
//' @param buffer vector to search in
//' @param pattern sequence of bytes to look for
//' @return index in \code{buffer} or \code{-1} if not found
//' @export
// [[Rcpp::export]]
int find_sequence(RawVector buffer, RawVector pattern) {
  RawVector::iterator it;
  it = std::search(buffer.begin(), buffer.end(), pattern.begin(), pattern.end());
  int pos = it - buffer.begin() + 1;
  if (pos > buffer.size()) pos = -1;
  return(pos);
}