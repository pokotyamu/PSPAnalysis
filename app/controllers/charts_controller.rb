# -*- coding: utf-8 -*-

class ChartsController < ApplicationController
  protect_from_forgery except: :charts_action

  def show
    end_at = Date.today
    start_at = end_at - 6
    categories = start_at.upto(end_at).to_a
    data = [5, 6, 3, 1, 2, 4, 7]
    data2 = [1, 9, 3, 7, 3, 6, 10]
    @h = []

    3.times do |i| 
      h = LazyHighCharts::HighChart.new("graph") do |f|
        f.title(:text => "Sample graph#{i}")
        f.chart(:type => "column")
        f.xAxis(:categories => categories)
        f.series(:name => "sample", :data => data)
        f.series(:name => "sample2", :data => data2)
      end
      @h << h
    end
  end

  def create
    puts params[:json] #jsonデータを受け取り，グラフデータを作成
    @@hoge = params[:json] #最悪クラス変数にしてしまうのもあり
    redirect_to :action => "show"
  end







  
end
