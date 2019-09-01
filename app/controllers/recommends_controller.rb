class RecommendsController < ApplicationController
  def index
    #おすすめ投稿
    all_sightseeings = Post.all.pluck(:sightseeing).uniq
    @averages =[]
    all_sightseeings.each do |sightseeing|
      posts = Post.where(sightseeing: sightseeing)
      average = posts.pluck(:evaluation).sum.to_f / posts.length
      country1 = posts.pluck(:country_spot).uniq
      country = country1.join()
      image_url1 = posts.pluck(:image_url).uniq
      image_url = image_url1.join()
      @averages.push([sightseeing, average, country, image_url])
    end
    
    @comment = []
    @averages.each do |average|
      name = average[0]
      posts = Post.where(sightseeing: name)
      content = posts.pluck(:content)
      evaluation = posts.pluck(:evaluation)
      @comment.push([name, content, evaluation])
    end
    p @comment
    
    
    
  end
end