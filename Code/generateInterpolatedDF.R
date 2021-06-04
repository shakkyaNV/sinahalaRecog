mostLameFuncEver <- function(df, n_int = 100) {
  # remove head in next line for real use-case 
  
  df %>% #head() %>% 
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
    
    mutate(
      x1 = list(attemp_num_one[seq(1, length(attemp_num_one), 2)]),
      y1 = list(attemp_num_one[seq(0, length(attemp_num_one), 2)]),
      x2 = list(attemp_num_two[seq(1, length(attemp_num_two), 2)]),
      y2 = list(attemp_num_two[seq(0, length(attemp_num_two), 2)])) %>% 
    
    mutate(
      x1 = list(c(x1 %>% unlist()) - x1[1] ),
      y1 = list(c(y1 %>% unlist()) - y1[1] ),
      x2 = list(c(x2 %>% unlist()) - x2[1] ),
      y2 = list(c(y2 %>% unlist()) - y2[1] )) %>% 
    
    transmute(
      char = char, 
      key = key, 
      person = person, 
      inter_x1 = (x1 %>% unlist() %>% approx(x = ., n = n_int))[[2]] %>% list(),
      inter_y1 = (y1 %>% unlist() %>% approx(x = ., n = n_int))[[2]] %>% list(),
      inter_x2 = (x2 %>% unlist() %>% approx(x = ., n = n_int))[[2]] %>% list(),
      inter_y2 = (y2 %>% unlist() %>% approx(x = ., n = n_int))[[2]] %>% list()
    )
}


secondMostLameFuncEver <- function(df) {
  df %>% 
    select(-c(ends_with("2"), person)) %>% 
    mutate(
      time = c(1:100) %>% list()
    ) %>% 
    unnest(cols = c(time, inter_x1, inter_y1)) %>% 
    pivot_wider(id_cols = c(char,key,time), 
                names_from = time, 
                values_from = c(inter_x1, inter_y1)) %>% 
    return(df)
}
