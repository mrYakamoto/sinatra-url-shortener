urls = ["http://nytimes.com",
        "http://cnn.com",
        "http://stackoverflow.com/questions/88311/how-best-to-generate-a-random-string-in-ruby",
        "http://www.amazon.com/Laugh-Out-Loud-Jokes-Kids-Rob-Elliott/dp/0800788036/ref=sr_1_5?ie=UTF8&qid=1396536942&sr=8-5&keywords=jokes"]

urls.each do |u|
  Url.create!(full_url: u)
end
