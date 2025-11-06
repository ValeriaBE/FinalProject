# Final Project - Data Science for Political Analytics

This project uses two primary data sources to investigate how candidate gender influences perceptions of political competence and how media framing reinforces these perceptions.

1. AP-NORC VoteCast (2020 & 2024) — Voter Perception Data

AP-NORC VoteCast provides nationally representative survey data on voter attitudes, demographics, ideology, and candidate evaluations during U.S. elections.
For this study, we analyze Senate races from 2020 and 2024 to assess whether female candidates are perceived as less competent than male candidates, controlling for partisanship, ideology, and experience.

Purpose:
To measure how gender shapes voter perceptions of political competence and whether these effects vary across regions (urban vs. rural) and partisan contexts.

Note:
The full VoteCast dataset (~367MB per year) exceeds GitHub’s 100MB upload limit and is subject to AP-NORC licensing restrictions. Therefore, the raw datasets are not included in this repository.

Included Sample:
This repository contains a 5,000-row subset (vc_small.csv) derived from the 2024 VoteCast data. It includes core variables necessary for modeling voter perceptions of competence and leadership traits by candidate gender.

Included variables
| Category                            | Variables                                                                                                                          |
| ----------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| Demographics                        | `GENDER`, `AGE65`, `RACETH`, `EDUC`, `INCOME`, `REGION`                                                                                        |
| Partisanship & Ideology             | `PARTY`, `PARTYFULL`, `IDEO`                                                                                                       |
| Vote History                        | `QVOTE2022S`, `QVOTE2020`, `PRESVOTE`                                                                                              |
| Affect Toward Candidates & Parties  | `FAVHARRIS`, `FAVTRUMP`, `FAVBIDEN`, `FAVREP`, `FAVDEM`                                                                            |
| Competence & Leadership Traits      | `HARRISCAPABLE`, `HARRISSTRONG`, `HARRISMENTALCAP`, `HARRISHONEST`, `TRUMPCAPABLE`, `TRUMPSTRONG`, `TRUMPMENTALCAP`, `TRUMPHONEST` |
| Policy & Representation Perceptions | `HARRISPOLICY`, `TRUMPPOLICY`, `HARRISCHANGE`, `TRUMPCHANGE`                                                                       |
| Additional Leadership Evaluations   | `EXTREMETRUMP`, `EXTREMEHARRIS`, `AUTHHARRIS`, `AUTHTRUMP`, `TESTEDHARRIS`, `TESTEDTRUMP`, `HARRISLOOKSOUT`, `TRUMPLOOKSOUT`       |
| Regional context                    | `SIZEPLACE`                                                                                                                       |

These variables capture the dimensions central to testing the competence gap hypothesis and the moderating role of ideology, region, and experience.

Accessing Full VoteCast Data

To reproduce full analyses locally:

Request/download VoteCast data here:
https://apnorc.org/projects/ap-votecast/


2. Media Cloud — Media Framing Data
Media data were collected using the Media Cloud Explorer platform to analyze how news outlets frame male and female Senate candidates in terms of competence and emotion.

Purpose:
To evaluate whether media coverage reinforces gendered perceptions of competence by associating male candidates with strength and experience and female candidates with empathy and emotion.

Search Queries Used:
"Kamala Harris"
"Donald Trump"
"Joe Biden"
"Nikki Haley"
+ plus selected Senate candidate names from the 2020 and 2024 election cycles.

Filters
U.S. News Media Sources (U.S. Most Visited News Online)
Election Coverage Period: January 1, 2020 – November 15, 2024

Exports Downloaded
- Top Words: keyword frequency and framing language
- Top Sources: media outlet identifiers and partisan classification
- Attention Over Time: temporal trends in candidate mentions

Note:
Media Cloud does not permit bulk downloads of full-text articles due to copyright restrictions. As a result, this study relies on metadata, keyword frequencies, and qualitative review of selected stories to identify competence-related and emotion-related framing.



