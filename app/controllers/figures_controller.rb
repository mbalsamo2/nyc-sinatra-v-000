class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :"/figures/index"
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :"/figures/new"
  end

  get '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    erb :"/figures/show"
  end

  get '/figures/:id/edit' do
    @figure = Figure.find_by_id(params[:id])
    @titles = Title.all
    @landmarks = Landmark.all
    erb :"/figures/edit"
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

  post '/figures/:id' do
    @figure = Figure.find_by_id(params[:id])
    @figure.update(params[:figure])
    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end
    if !params[:title][:name].empty?
      @figure.titles << Title.create(params[:title])
    end
    @figure.save

    redirect to "/figures/#{@figure.id}"
  end


end
