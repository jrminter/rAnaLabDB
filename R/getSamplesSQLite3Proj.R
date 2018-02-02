#' getSamplesSQLite3Proj
#'
#' Query the SQLite3 anaLabDB database for all samples
#' associated with a specific project.
#'
#' @param projID project ID String for query, e.g. "Wolf analysis"
#' @param dbPath path to database, e.g. "D:/Data/db/anaLabDBtest/anaLabDB.db"
#' @param csvOut path for csv, e.g. "../dat/csv/samples.csv"
#'
#' @import RSQLite
#' @import utils
#'
#' @export
#'
#' @examples
#' # not run
getSamplesSQLite3Proj <- function(projID,
                                  dbPath,
                                  csvOut){
  con <- dbConnect(RSQLite::SQLite(), dbname=dbPath)
  tables <- dbListTables(con)
  query = sprintf("select Lab_ID,Client_Sample_ID,Sample_Info,Date_In,Date_Out from samples where PROJECT_ID = \"%s\" ", projID)
  res <- dbSendQuery(con, query)
  samples <-fetch(res, n = -1)
  samples$Lab_ID <- tolower(samples$Lab_ID)
  print(tail(samples))
  write.csv(samples, csvOut, row.names=FALSE)
  dbDisconnect(con)
}
