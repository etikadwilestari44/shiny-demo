# ==============================
# Prepare Data - Palmer Penguins
# ==============================

# Install package (jalankan sekali saja)
install.packages("palmerpenguins")

library(palmerpenguins)
library(dplyr)

# Load data
data(penguins)

# Cek struktur data
glimpse(penguins)

# ==============================
# Data Cleaning
# ==============================

penguins_clean <- penguins %>%
  filter(!is.na(bill_length_mm)) %>%
  select(
    species,
    island,
    sex,
    bill_length_mm,
    body_mass_g
  )

# ==============================
# Data Summary
# ==============================

penguins_summary <- penguins_clean %>%
  group_by(species) %>%
  summarise(
    jumlah_penguin = n(),
    rata_panjang_paruh = mean(bill_length_mm),
    rata_berat_badan = mean(body_mass_g)
  )

# Lihat hasil
penguins_summary
