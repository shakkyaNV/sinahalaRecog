# Initial Read files
library(tidyverse)
library(here)
here()

df_raw = read_csv(here("Data/UCI_handWritten/data.csv"))

df_raw %>% head()

df_raw %>% 
  rowwise() %>% 
  transmute(
  
  char = char, 
  key = key, 
  person = person, 
  attemp_num_one = attempt_one %>% 
    str_split(pattern = " # ", simplify = T) %>% 
    str_c(collapse = " ") %>% 
    str_split(" ") %>% 
    map(., as.integer) %>% 
    unlist() %>% list(), 
  
  attemp_num_two = attempt_two %>% 
    str_split(pattern = " # ", simplify = T) %>% 
    str_c(collapse = " ") %>% 
    str_split(" ") %>% 
    map(., as.integer) %>% 
    unlist() %>% list()
  )  %>% 
  transmute(
    
    char = char, 
    key = key, 
    person = person, 
    x1 = list(attemp_num_one[seq(1, length(attemp_num_one), 2)]),
    y1 = list(attemp_num_one[seq(0, length(attemp_num_one), 2)]),
    x2 = list(attemp_num_two[seq(1, length(attemp_num_two), 2)]),
    y2 = list(attemp_num_two[seq(0, length(attemp_num_two), 2)])
  ) -> df


