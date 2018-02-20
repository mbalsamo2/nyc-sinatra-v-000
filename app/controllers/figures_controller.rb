class FiguresController < ApplicationController

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :"/figures/new"
  end

  post '/figures' do
    @figure = Figure.create(params[:figure])
    @landmark = Landmark.find_by(params[:landmark])
    @figure.landmarks = !@landmark ? @figure.landmarks << Landmark.create(params[:landmark]) : @figure.landmarks << @landmark
    @title = Title.find_by(params[:title])
    @figure.titles = !@title ? @figure.titles << Title.create(params[:title]) : @figure.titles << @title
    @figure.save

    redirect to "/figures/#{@figure.id}"
  end
end
