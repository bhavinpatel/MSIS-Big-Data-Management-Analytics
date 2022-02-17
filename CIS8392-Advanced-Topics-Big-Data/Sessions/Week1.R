?factorial
??read
paste("Big", "Data", "Analytics", 
      "sajfldsaflkadsjlads", 
      sep=" ")
?paste


f_name = "Yu-Kai"
l_name = "Lin"

length_f_name <- nchar(f_name)
length_l_name <- nchar(l_name)

paste(f_name, l_name)

length_f_name * length_l_name 
length_f_name / length_l_name 

length_f_name > length_l_name






y = c("a", "b", "c")

z = c(1, 2, NULL)
sum(z, na.rm=T)

vec <- c("value1"=10, "value2"=20, 
         "value3"=30, "value4"=40)

vec
names(vec) = NULL
vec

1:100




x = list(
  "name" = c("Alice", "Bob", 
             "Claire", "Daniel"),
  "female" = c(T, F, T, F),
  "age" = c(20, 25, 30, 35)
)

x
x[[1]][2]
x[["name"]][2]
x$name[2]



name = c("Alice", "Bob", "Claire", "Deniel")
female = c(T, F, T, F)
age = c(20, 25, 30, 35)

df = data.frame(
  name, 
  female, 
  age
)

df
rownames(df) = c("row_1", "row_2", 
                 "row_3", "row_4")
df
df$age
mean(df$age)


rownames(df)[3] = "something"

df


install.packages("tidyverse")

getwd() 

list.files("C:/CIS8392/data")
list.files(path = "data/")

df <- read.csv(file="C:/CIS8392/data/HousePrices.csv")
df
class(df)

library(tidyverse)
df2 = read_csv(file="C:/CIS8392/data/HousePrices.csv")
df2

View(df2)

df_na <- read_csv(file="data/HousePrices_with_missing_values.csv", 
                  na = c("","NA", "Not Available"))
df_na


library("jsonlite") #load the library into R before you can use it.
df = read_csv("data/HousePrices.csv")
json_content = toJSON(df)
df2=fromJSON(json_content)
write(json_content, file="data/my_HousePrices.json") 
write_json(df, path = "data/my_HousePrices.json")
result_list = read_json("data/my_HousePrices.json") # a list
result_df = read_json("data/my_HousePrices.json", simplifyDataFrame=T) 


result <- stream_in(file("https://api.github.com/repos/tidyverse/ggplot2"))
str(result) #notice that the data type of the owner column is data.frame
result_flat <- flatten(result)
colnames(result_flat)


p1 = ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))
p2 = ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, color = class))
p1
p2




library(ggthemes)
df = read_csv("data/HousePrices.csv")

df = df %>% 
  mutate(driveway2 = ifelse(
    driveway == "yes", 
    "With Driveway", 
    "Without Driveway"))

View(df)

ggplot(df, mapping = aes(x = lotsize, 
                         y = price, 
                         color = aircon,
                         size = bedrooms)) + 
  geom_point() +
  geom_smooth() + 
  facet_wrap(~driveway2) + 
  xlab("Lot Size") + 
  ylab("Price") + 
  labs(title="House Price Data")+
  theme_gdocs() +
  scale_color_gdocs()



View(df)

df %>% 
  select(price, aircon, gasheat, garage) %>% 
  filter(garage == 0)


df %>% 
  mutate(price_per_bedroom = price/bedrooms) %>% 
  select(price, bedrooms, price_per_bedroom) %>% 
  arrange(desc(price_per_bedroom))

df %>% 
  mutate(has_4_or_more_bedrooms = bedrooms>=4) %>% 
  group_by(has_4_or_more_bedrooms) %>% 
  summarise(abc = n())


table1





