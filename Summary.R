summary_info <- list()

summary_info$num_movies <- nrow(ratings_df)
summary_info$min_year <- min(ratings_df$Year, na.rm = TRUE)
summary_info$max_year <- max(ratings_df$Year, na.rm = TRUE)
summary_info$num_movies_netflix <- nrow(filter(ratings_df, Netflix == 1))
summary_info$num_movies_hulu <- nrow(filter(ratings_df, Hulu == 1))
summary_info$num_movies_prime <- nrow(filter(ratings_df, Prime.Video == 1))
summary_info$num_movies_disney <- nrow(filter(ratings_df, Disney. == 1))
