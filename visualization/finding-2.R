library(dplyr)
library(ggplot2)
library(scales)
stories <- read_csv("../data_clean/mediacloud_stories_2024_candidates.csv")
soft_terms <- c(
  "education", "school", "schools", "teacher", "teachers",
  "childcare", "children", "families", "family",
  "health", "healthcare", "medicaid", "medicare",
  "abortion", "reproductive", "maternity",
  "welfare", "food assistance", "snap"
)

hard_terms <- c(
  "economy", "economic", "inflation", "jobs", "tax", "taxes",
  "budget", "deficit",
  "defense", "military", "border", "immigration",
  "crime", "policing", "police",
  "terrorism", "foreign policy"
)
scored <- stories %>%
  mutate(
    title_clean = normalize_text(title),
    soft_hits   = count_hits(title_clean, soft_terms),
    hard_hits   = count_hits(title_clean, hard_terms)
  )
candidate_frames <- scored %>%
  mutate(frame_simple = ifelse(soft_hits > hard_hits, "Soft", "Hard")) %>%
  group_by(candidate, gender, frame_simple) %>%
  summarise(n = n(), .groups = "drop") %>%
  group_by(candidate) %>%
  mutate(pct = n / sum(n))

ggplot(candidate_frames,
       aes(x = reorder(candidate, pct),
           y = pct,
           fill = frame_simple)) +
  geom_col(position = "fill", width = 0.6, color = "white") +
  scale_y_continuous(labels = percent) +
  scale_fill_manual(values = c("Soft"="#FF9BBF", "Hard"="#6C8FF5")) +
  labs(
    title = "Soft vs Hard Issue Framing by Candidate",
    x = "Candidate",
    y = "Share of Headlines",
    fill = "Frame"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    plot.title = element_text(face="bold", hjust=0.5)
  )
