library(tidyverse) 
library(ggplot2)
library(infer)
library(tidyclust)
library(tidymodels)
library(dplyr)


crypto_data <- read.csv("C:/Users/user/Desktop/All files/Personal Projects/API crypto project/API.csv") #load API.csv from local computer


#Transforming data for Percent change visualization  
crypto_group <- crypto_data |>
  group_by(name) |>
  summarise(across(starts_with("quote.USD.percent_change"), mean, na.rm = TRUE))   #Grouped data by name and averaged quote.USD.percent_change into new dataframe

crypto_long <- crypto_group |>
  pivot_longer(
    cols = starts_with("quote.USD.percent_change"),
    names_to = "percent_changes",            
    values_to = "values"                           
  )

crypto_long <- crypto_long %>%
  mutate(
    percent_changes = str_replace(percent_changes, "quote\\.USD\\.percent_change_", "") # Replace prefix
  )

#Visualizing percent changes over time

crypto_long |>
  ggplot(aes(x = percent_changes, y = values, color = name)) +
  geom_point() +
  geom_line(aes(group = name)) +
  labs(
    x = "Time elapsed",  # Corrected labels() to labs()
    y = "Percent change (%)",
    title = "Cryptocurrencies and Percent Changes",
    color = "Crypto Currency"
  ) +
  theme_minimal()  




#transforming data for marketcap visualization 

crypto_data$Timestamp <- as.POSIXct(crypto_data$Timestamp, format = "%m/%d/%Y %H:%M")

crypto_data$Time <- format(crypto_data$Timestamp, "%H:%M:%S")  # Time in HH:MM:SS format

# Market cap distribution
cyrpto_market_cap <- crypto_data |>
  ggplot(aes(x = reorder(name, -quote.USD.market_cap_dominance), y = quote.USD.market_cap_dominance)) +
  geom_bar(stat = "identity", fill = "purple") +
  labs(title = "Cryptocurrency Market Cap Dominance", x = "Cryptocurrency", y = "Market Cap Dominance (%)") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))





#Price distribution
mean_price1 <- mean(crypto_data$quote.USD.price, na.rm = TRUE)

# Plot histogram with mean line
crypto_price_dist <- crypto_data |>
  ggplot(aes(x = quote.USD.price)) +
  geom_histogram(binwidth = 1000, fill = "blue", color = "black") +  # Histogram
  geom_vline(xintercept = mean_price1, color = "red", linetype = "dotted", size = 1) +  # Mean line
  labs(title = "Distribution of Cryptocurrency Prices after 15 minutes", 
       x = "Price (USD)", 
       y = "Count") +
  theme_minimal()  # Improve appearance





#Bootstrapping Price
crypto_boot20000 <- crypto_data |>
  rep_sample_n(size = 40, replace = TRUE, reps = 20000)

crypto_price_boot20000_means <- crypto_boot20000 |>
  group_by(replicate) |>
  summarize(mean_price = mean(quote.USD.price))

mean_bootstrap_mean <- mean(crypto_price_boot20000_means$mean_price, na.rm = TRUE)

crypto_price_boot20000_dist <- crypto_price_boot20000_means |>
  ggplot(aes(x= mean_price)) +
  geom_histogram(color = "lightblue", fill = "blue") +
  geom_vline(xintercept = mean_bootstrap_mean, color = "orange", linetype = "dashed", size = 1) +
  labs(x = "Sample mean price (Dollars)",
       y = "count",
       title = "Bootstrapped Distribution of Cypto currency prices") +
  theme(text = element_text(size = 12))

  
  
  
#Clustering Price
  set.seed(42)  # Ensure reproducibility
  crypto_clustering_data <- crypto_boot20000 |>
    slice_sample(n = 200) |>
    select(quote.USD.price, quote.USD.market_cap) |>
    drop_na() |>
    mutate(log_market_cap = log10(quote.USD.market_cap + 1))
  
  # Define the preprocessing recipe
  kmeans_recipe <- recipe(~ ., data = crypto_clustering_data) |>
    step_scale(all_predictors()) |>
    step_center(all_predictors())
  
  # Define K-Means model with K=3
  kmeans_spec <- k_means(num_clusters = 3) |>
    set_engine("stats")
  
  # Create and fit the workflow
  kmeans_fit <- workflow() |>
    add_recipe(kmeans_recipe) |>
    add_model(kmeans_spec) |>
    fit(data = crypto_clustering_data)
  
  # Add cluster labels to dataset
  clustered_data <- kmeans_fit |>
    augment(crypto_clustering_data)
  
  # Visualize the clusters
  ggplot(clustered_data, aes(x = log_market_cap, y = quote.USD.price, color = .pred_cluster)) +
    geom_point(alpha = 0.7, size = 3) +
    scale_y_log10() +  # Log-scale for better visualization
    theme_minimal() +
    labs(title = "K-Means Clustering of Cryptos by Price & Market Cap",
         x = "Log Market Cap",
         y = "Price (USD)",
         color = "Cluster")
 
  
  
  
  
  #Optimizations
  # Tune the optimal number of clusters using the Elbow Method If i had higher computer capacity
  # Create a tibble with range of K values to test
  crypto_clust_ks <- tibble(num_clusters = 2:6)
  
  # Modify model to tune num_clusters
  kmeans_spec_tune <- k_means(num_clusters = tune()) |>
    set_engine("stats", nstart = 5)  # Use multiple restarts for stability
  
  # Run the tuning process
  kmeans_results <- workflow() |>
    add_recipe(kmeans_recipe) |>
    add_model(kmeans_spec_tune) |>
    tune_cluster(resamples = apparent(crypto_clustering_data), grid = crypto_clust_ks) |>
    collect_metrics() |>
    filter(.metric == "sse_within_total") |>
    mutate(total_WSSD = mean) |>
    select(num_clusters, total_WSSD)
  
  # Plot the Elbow Method
  elbow_plot <- ggplot(kmeans_results, aes(x = num_clusters, y = total_WSSD)) +
    geom_point() +
    geom_line() +
    xlab("K (Number of Clusters)") +
    ylab("Total within-cluster sum of squares (WSSD)") +
    scale_x_continuous(breaks = 1:9) +
    theme(text = element_text(size = 12))
  
  # Display the Elbow Plot
  print(elbow_plot)
  


  
  
  
  
  

