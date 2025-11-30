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
soft_only <- scored %>%
  mutate(frame_simple = ifelse(soft_hits > hard_hits, "Soft", "Hard")) %>%
  filter(frame_simple == "Soft") %>%
  count(gender) %>%
  mutate(pct = n / sum(n))
ggplot(soft_only,
       aes(x = gender, y = pct, fill = gender)) +
  geom_col(width = 0.6) +
  geom_text(aes(label = percent(pct, 0.1)),
            vjust = -0.3, size = 4) +
  scale_y_continuous(labels = percent,
                     limits = c(0, max(soft_only$pct) * 1.2)) +
  scale_fill_manual(values = c("F"="#FF9BBF", "M"="#6C8FF5")) +
  labs(
    title = "Among Soft-Issue Headlines, Most Feature Female Candidates",
    x = "Gender",
    y = "Share of Soft Headlines"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    legend.position = "none",
    plot.title = element_text(face="bold", hjust=0.5)
  )
