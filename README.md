# Gendered Issue Framing in 2024 U.S. Political News Coverage

## Overview
This project examines whether female political candidates are more likely than male candidates to be associated with “soft” political issues (e.g., education, health, family) rather than “hard” issues (e.g., economy, defense, foreign policy) in U.S. news coverage during the 2024 election cycle.
This question is motivated by longstanding research in political communication showing that media framing often reinforces gendered expectations of political leadership. By analyzing text from online news sources, the project assesses whether these patterns were visible in 2024 Senate-related coverage.

Media framing shapes:

- voter perceptions of candidate competence
- beliefs about leadership traits
- perceived electability
- candidate agenda-setting power

If news coverage consistently links women with soft issues and men with hard issues, this can reinforce gender stereotypes in politics.

## Data sources

### Media Cloud (Search API)
All news articles used in this project were collected through the Media Cloud Search API, specifically the search/story-list endpoint.
Media Cloud aggregates online news sources from across the U.S. and allows researchers to programmatically access story metadata and text snippets.

#### API endpoint used:

https://search.mediacloud.org/api/search/story-list

#### Parameters included:

| Parameter   | Purpose                                               |
| ----------- | ----------------------------------------------------- |
| `q`         | Query string (candidate’s full name in quotes)        |
| `start`     | Start date for the search window                      |
| `end`       | End date for the search window                        |
| `platform`  | Specifies dataset (we used `"onlinenews-mediacloud"`) |
| `page_size` | Up to 500 stories per request                         |

#### Candidate List

We analyzed eight high-profile 2024 Senate-related politicians across both parties:
| Candidate          | Party | State | Gender |
| ------------------ | ----- | ----- | ------ |
| Tammy Baldwin      | D     | WI    | F      |
| Kirsten Gillibrand | D     | NY    | F      |
| Katie Britt        | R     | AL    | F      |
| Elizabeth Warren   | D     | MA    | F      |
| Ted Cruz           | R     | TX    | M      |
| Rick Scott         | R     | FL    | M      |
| Josh Hawley        | R     | MO    | M      |
| J.D. Vance         | R     | OH    | M      |

These candidates help balance:
- female vs. male
- Democratic vs. Republican
- geographic diversity
- media visibility

## How the Data Was Collected

### Step 1: Set up authenticated request

Each request includes:
- API token
- JSON return format
- User agent header
- base URL

### Step 2: Query the search/story-list endpoint
One query per candidate:
req |>
  req_url_path_append("search/story-list") |>
  req_url_query(
    q        = "\"Candidate Name\"",
    start    = "2024-01-01",
    end      = "2024-11-27",
    platform = "onlinenews-mediacloud",
    page_size = 500
  )

### Step 3: Handle errors and rate limits

The script uses:
- random sleep delays
- exponential backoff retry logic
- tryCatch() to avoid crashing when the API returns 429 Too Many Requests

### Step 4: Loop over candidates

A for loop runs the request for each of the eight candidates and collects the results into a list.

### Step 5: Combine into a dataset

dplyr::bind_rows() merges all candidate story results into one cleaned CSV located in:

data_clean/mediacloud_stories_2024_candidates.csv

## Reproducibility

To reproduce the data collection:
- Obtain a Media Cloud API token.
- Store it in your environment as MEDIACLOUD_TOKEN.
- Run the R script (api_mediacloud.R) to:
  - query the API for each candidate,
  - collect story metadata,
  - and save mediacloud_stories_2024_candidates.csv in data_clean/.

This file serves as the basis for subsequent analysis of gender and media coverage.





