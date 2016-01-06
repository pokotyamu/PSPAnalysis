# -*- coding: utf-8 -*-
require 'open-uri'
require 'json'

class ChartsController < ApplicationController
  protect_from_forgery :except => [:create] #:charts_action
  @@charts = []
  
  def show
    @charts = @@charts
    @@charts = [] #一度出力したら初期化
  end

  def create
    response = open('https://java-psp-analysis.herokuapp.com/test/hoge')
    #    @json = JSON.parse("#{params[:json]}")
    data = response.read
    puts data
    @json = JSON.parse(data)
    
    @json.each do |key,value|
      h = LazyHighCharts::HighChart.new("graph") do |f|
        f.title(:text => value["title"])
        f.chart(:type => value["type"])
        f.xAxis({title: {text: value["xAxis"]["title"]["text"], margin: 20}, categories: value["xAxis"]["categories"]})
        f.series(:name => value["series"]["name"] , :data => value["series"]["data"])
      end
      @@charts << h
    end
    redirect_to :action => "show"
  end
end
