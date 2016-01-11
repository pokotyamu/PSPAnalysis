# -*- coding: utf-8 -*-
require 'open-uri'
require 'json'

class ChartsController < ApplicationController
  protect_from_forgery :except => [:create] #:charts_action

  include IdentifyGraph

  @@charts = []
  def show
    @charts = @@charts
    @@charts = [] #一度出力したら初期化

  end

  def create
    #response = open("http://localhost:5000/result")
    response = open('https://java-psp-analysis.herokuapp.com/result')
    data = response.read
    @json = JSON.parse(data)
    @json.each do |key,value|
      h = LazyHighCharts::HighChart.new("graph") do |f|
        f = create_graph(f,value)
        #戻り値の関係なのか，最後にtype指定しないと上手くグラフtypeが切り替わらない．
        f.chart(:type => value["type"])
      end
      @@charts << h
    end
    redirect_to :action => "show"
  end
end
