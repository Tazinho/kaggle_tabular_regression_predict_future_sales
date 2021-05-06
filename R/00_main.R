source("R/01_load_libraries.R")
source("R/02_load_data.R")
source("R/03_adjust_data_sets.R")
source("R/04_feature_engineering.R")

# Next Steps:
# - Predicte direkt auf Monatsebene
# - Nehme 10/2015 als Testdaten
# - Submitte mit neuem Modell für 11/2015

# Alternativ:
# 1. Führe Leerzeilen in Trainingsdatensatz ein
# 2. Predicte item_price im Trainingsdatensatz
# 3. Predicte item_price im Testdatensatz
# 4. Erstelle kumulative Features mittels Window Functions
# 5. Vorhersage auf Tagesebene (mit anschließender Aggregation)
