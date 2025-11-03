# Final Project - Data Science for Political Analytics

This project use two primary data sources:

1. AP-NORC VoteCast (2024) — Voter Perception Data

AP-NORC VoteCast provides nationally representative survey data on voter attitudes, demographics, and candidate evaluations during the 2024 U.S. election.

Note: The full raw VoteCast file (~367MB) exceeds GitHub’s 100MB file size limit and is subject to AP-NORC licensing restrictions.
Therefore, the raw dataset is not included in this repository.

Instead, this repository contains a 5,000-row subset of VoteCast (vc_small) that includes key variables needed to analyze gendered perceptions of political leadership and competence.

Included variables
| Category                            | Variables                                                                                                                          |
| ----------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| Demographics                        | `GENDER`, `AGE65`, `RACETH`, `EDUC`, `LGBT`                                                                                        |
| Partisanship & Ideology             | `PARTY`, `PARTYFULL`, `IDEO`                                                                                                       |
| Vote History                        | `QVOTE2022S`, `QVOTE2020`, `PRESVOTE`                                                                                              |
| Affect Toward Candidates & Parties  | `FAVHARRIS`, `FAVTRUMP`, `FAVBIDEN`, `FAVREP`, `FAVDEM`                                                                            |
| Competence & Leadership Traits      | `HARRISCAPABLE`, `HARRISSTRONG`, `HARRISMENTALCAP`, `HARRISHONEST`, `TRUMPCAPABLE`, `TRUMPSTRONG`, `TRUMPMENTALCAP`, `TRUMPHONEST` |
| Policy & Representation Perceptions | `HARRISPOLICY`, `TRUMPPOLICY`, `HARRISCHANGE`, `TRUMPCHANGE`                                                                       |
| Additional Leadership Evaluations   | `EXTREMETRUMP`, `EXTREMEHARRIS`, `AUTHHARRIS`, `AUTHTRUMP`, `TESTEDHARRIS`, `TESTEDTRUMP`, `HARRISLOOKSOUT`, `TRUMPLOOKSOUT`       |

These variables were selected because they capture leadership traits, competence-related evaluations, voter ideology, and partisan affect — all central to testing gendered leadership perception hypotheses.

Accessing Full VoteCast Data

To reproduce full analyses locally:

Request/download VoteCast data here:
https://apnorc.org/projects/ap-votecast/

Place the raw file in:
data/raw/

2. Media Cloud — Media Framing Data

Media data was collected using the Media Cloud Explorer interface.

Search Queries Used:
"Kamala Harris"
"Donald Trump"
"Joe Biden"
"Nikki Haley"

Filters

U.S. news media sources 
US Most Visited News Online

Election period: Jan 1, 2024 — Nov 15, 2024

Exports Downloaded
 - Top Words
 - Top Sources
 - Attention Over Time

Media Cloud Explorer does not support bulk download of full article text due to copyright constraints.
Therefore, this study uses metadata, keyword frequency, and manual reading of sample stories for qualitative context.

Reproducibility Instructions

To fully reproduce this analysis:

1. Download VoteCast from AP-NORC
2. Save file to data/raw/
3. Download Media Cloud exports 

