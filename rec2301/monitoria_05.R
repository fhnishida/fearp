# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
# MONITORIA 5 (29/09/2022)
library(dplyr)
bd_sw = starwars

# filter()
bd_sw1 = filter(bd_sw, species=="Human", height>=100)

# arrange()
bd_sw2 = arrange(bd_sw1, height, desc(mass))

# select()
bd_sw3 = select(bd_sw2, name:eye_color, sex:species)
bd_exemplo = select(bd_sw2, starts_with("s"))

# rename()
bd_sw4 = rename(bd_sw3,
                haircolor = hair_color,
                skincolor = skin_color,
                eyecolor = eye_color)

# mutate()
bd_sw5 = mutate(bd_sw4,
                height = height/100,
                BMI = mass/height^2,
                constante = 1)


# OPERADOR PIPE %>% # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
bd_sw_full = bd_sw %>% 
    filter(species=="Human", height>=100) %>%
    arrange(height, desc(mass)) %>%
    select(name:eye_color, sex:species) %>%
    rename(haircolor = hair_color,
           skincolor = skin_color,
           eyecolor = eye_color) %>% 
    mutate(height = height/100,
           BMI = mass/height^2,
           constante = 1)


# summarise()
starwars %>% summarise(
    n_obs = n(),
    mean_height = mean(height, na.rm=TRUE),
    mean_mass = mean(mass, na.rm=TRUE)
)

# group_by()
grouped_sw = starwars %>% group_by(sex)

starwars %>% mutate(
    mean_height = mean(height, na.rm=TRUE)
) %>% select(height, mean_height, sex)

grouped_sw %>% mutate(
    mean_height = mean(height, na.rm=TRUE)
) %>% select(height, mean_height, sex)

grouped_sw %>% ungroup()


# group_by() junto de summarise()
starwars %>% group_by(species, sex) %>% summarise(
    n_obs = n(),
    mean_height = mean(height, na.rm=TRUE),
    mean_mass = mean(mass, na.rm=TRUE)
) %>% View()


# Família de join
bd1 = starwars[1:6, c(1, 3, 11)]
bd2 = starwars[c(2, 4, 7:10), c(1:2, 6)]

inner_join(bd1, bd2, by="name")
left_join(bd1, bd2, by="name")
right_join(bd1, bd2, by="name")
full_join(bd1, bd2, by="name")



