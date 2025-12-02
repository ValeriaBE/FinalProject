###############################
# 01_fetch_stories.R
###############################

library(httr2)
library(dplyr)
library(readr)
library(tibble)
library(stringr)

# ---- 0. API setup ----
mc_token <- "71e181a5dcaabf6dda8e80e44a1465c4e0d981fc"#personal token from media cloud

base_request <- request("https://search.mediacloud.org/api/") |>
  req_headers(
    Authorization = paste0("Token ", mc_token),
    Accept        = "application/json",
    `User-Agent`  = "mediacloud R-test"
  )

# ---- 1. Candidate list ----
candidates <- tibble::tribble(
  ~candidate,           ~party, ~state, ~gender,
  "Tammy Baldwin",      "D",    "WI",   "F",
  "Kirsten Gillibrand", "D",    "NY",   "F",
  "Katie Britt",        "R",    "AL",   "F",
  "Elizabeth Warren",   "D",    "MA",   "F",
  "Ted Cruz",           "R",    "TX",   "M",
  "Rick Scott",         "R",    "FL",   "M",
  "Josh Hawley",        "R",    "MO",   "M",
  "Sherrod Brown",      "D",    "OH",   "M"
)
# Ran the first set and it errored out for these two candidates, so running them separately
failed_candidates <- tibble::tribble(
  ~candidate,           ~party, ~state, ~gender,
  "Ted Cruz",            "R",    "TX",   "M",
  "Sherrod Brown",       "D",    "OH",   "M"
)

# ---- 2. Date range ----
start_date <- "2024-01-01"
end_date   <- "2024-11-27"

# ---- 3. Helper function ----
fetch_stories_for_candidate <- function(name, party, state, gender,
                                        start = start_date,
                                        end = end_date,
                                        page_size = 500) {
  
  message("Fetching stories for: ", name)
  Sys.sleep(runif(1, 1, 3)) # random sleep between 1 to 3 seconds to slow down requests
  query_string <- paste0('"', name, '"')
  
  resp <- base_request |>
    req_url_path_append("search/story-list") |>
    req_url_query(
      q        = query_string,
      start    = start,
      end      = end,
      platform = "onlinenews-mediacloud",
      page_size = page_size
    ) |>
    req_retry(
      max_tries = 5,
      backoff = ~ min(60, 2 ^ .x)  # exponential backoff up to 60s
    ) |>
    req_perform() |>
    resp_body_json(simplifyVector = TRUE)
  
  stories <- resp$stories
  
  if (is.null(stories) || length(stories) == 0) {
    message("  -> No stories found for ", name)
    return(tibble())
  }
  
  stories_tbl <- tibble::as_tibble(stories) |>
    mutate(candidate = name,
           party = party,
           state = state,
           gender = gender)
  
  return(stories_tbl)
}

# ---- 4. Loop version ----
failed_results <- list()
all_results <- list()  # empty list to collect candidate tables
counter <- 1

#just change candidates to failed_candidates to run the failed ones separately
for (i in 1:nrow(failed_candidates)) {
  row <- failed_candidates[i, ]
  
  temp <- tryCatch(
    fetch_stories_for_candidate(
      name   = row$candidate,
      party  = row$party,
      state  = row$state,
      gender = row$gender
    ),
    error = function(e) {
      message("  -> Error for ", row$candidate, ": ", e$message)
      tibble()  # return empty tibble if error
    }
  )
  
  failed_results[[counter]] <- temp
  counter <- counter + 1
}

# Combine all candidate data frames into one big one
all_stories <- dplyr::bind_rows(all_results)
failed_stories <- dplyr::bind_rows(failed_results)
#run this when running failed candidates separately
final_all_stories <- dplyr::bind_rows(all_stories, failed_stories)


# ---- 5. Save ----
dir.create("data_clean", showWarnings = FALSE)
readr::write_csv(final_all_stories, "data_clean/mediacloud_stories_2024_candidates_new.csv")

