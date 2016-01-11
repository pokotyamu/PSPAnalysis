# -*- coding: utf-8 -*-
require 'open-uri'
require 'json'

class ChartsController < ApplicationController
  protect_from_forgery :except => [:create] #:charts_action

  include IdentifyGraph

  @@charts = []
  def show
    response = open("http://localhost:5000/result")
    data = response.read
    puts data
    @json = JSON.parse(data)
    @json.each do |key,value|
      h = LazyHighCharts::HighChart.new("graph") do |f|
        f = create_graph(f,value)
        #戻り値の関係なのか，最後にtype指定しないと上手くグラフtypeが切り替わらない．
        f.chart(:type => value["type"])
      end
      @@charts << h
    end

    @charts = @@charts
    @@charts = [] #一度出力したら初期化

  end

  def create
    response = open("http://localhost:5000/result")
    #response = open('https://java-psp-analysis.herokuapp.com/result')
    data = response.read
    puts data
    @json = JSON.parse(data)
    @json.each do |key,value|
      h = LazyHighCharts::HighChart.new("graph") do |f|
        create_graph(f,value)
        f.chart(:type => value["type"])
        f.xAxis({title: {text: value["xAxis"]["title"], margin: 20}, categories: value["xAxis"]["categories"]})
        f.yAxis({title: {text: value["yAxis"]["title"], margin: 20}})
        value["yAxis"]["series"].each do |se|
          f.series(:name => se["name"] , :data => se["data"])          
        end
        puts f.chart
      end
      @@charts << h
    end
    redirect_to :action => "show"
  end
end
