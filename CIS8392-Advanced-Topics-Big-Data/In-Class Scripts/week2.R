

iris
View(iris)

ncol(iris)

vec = vector("numeric", ncol(iris))

for(i in 1:ncol(iris)) {
  
  if(!is.numeric(iris[,i])) {
    vec[i] <- NA
    next
  }
  
  vec[i] <- mean(iris[  , i ])
}



for()

!is.numeric(iris[,4])

result
iris[  , 5 ]
vec

result = NULL
try({result = 1 + "gsu"})
try({result = 1 + "gsu"}, silent = T)


out <- tryCatch({
  # code
}, error=function(cond) {
  # What to do or return if there is an error
}, warning=function(cond) {  # This is optional...
  # What to do or return if there is a warning
}, finally={  # This is optional...
  # Here goes everything that should be executed at the end,
  # regardless of success or error.
}
)

add_one <- function(num) {
  num <- num + 1  # be sure to match the input variable name 
  return(num)  # return() says what the output is
}
a = add_one("big data")
print(a)




add_one <- function(num) {
  
  out <- tryCatch({
    num + 1
  }, error=function(cond) {
    NA
  })
  
  return(out)  # return() says what the output is
}

add_one(1)
add_one("big data")

add_one <- function(num) {
  
  if(is.numeric(num)) {
    out = num+1
  } else {
    out = NA
  }
  
  return(out) 
}




add_two_values <- function(v1=0, v2=0) {
  
  if(!is.numeric(v1)) return(NA)
  if(!is.numeric(v2)) return(NA)
  
  out = v1+v2
  
  return(out)
}

add_two_values("gsu", "uga")
add_two_values(1)
add_two_values(1,2)


library(repurrrsive)
sw_people

repurrrsive::sw_people

sw_people[[1]]


library(tidyverse)
mass = map_dbl(sw_people, function(x){
  as.numeric(x$mass)
})

height = map_dbl(sw_people, function(x){
  as.numeric(x$height)/100
})
height

bmi = mass/(height^2)
bmi

sw_people[[1]]
sw_people[[2]]
sw_people[[86]]


name = map_chr(sw_people, function(x){
  x$name
})

gender = map_chr(sw_people, function(x){
  x$gender
})

df = data.frame(
  name,
  gender, 
  height,
  mass, 
  bmi
)

View(df)

df = df %>% 
  mutate(bmi_category = ifelse(
    bmi < 18.5, "Underweight", 
    ifelse(bmi < 24.9, "Normal weight", 
           ifelse(bmi<29.9, "Overweight", "Obesity"))))




height = map_dbl(gh_users, 
                 ~as.numeric(.$height)/100)




gh_users[[1]]$updated_at - gh_users[[1]]$created_at

gh_users[[1]]$updated_at
as.Date(gh_users[[1]]$updated_at) - 
  as.Date(gh_users[[1]]$created_at)


gh_users %>% 
  map(~ as.Date(.$updated_at)-as.Date(.$created_at))


?rnorm



vec = rnorm(100, mean =100, sd=100)
hist(vec)


gh_users[[1]]



library(httr)

hadley = GET("https://api.github.com/users/hadley")
hadley_content = content(hadley)
hadley_content
hadley_followers = GET("https://api.github.com/users/hadley/followers")
hadley_followers_content = content(hadley_followers)
hadley_followers_content


hadley_repos = GET("https://api.github.com/users/hadley/repos")
hadley_repos_content = content(hadley_repos)
hadley_repos_content

google_members = GET("https://api.github.com/orgs/google/members")
class(google_members)

google_members_content = content(google_members)

google_members_content
