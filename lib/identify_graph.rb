# -*- coding: utf-8 -*-
module IdentifyGraph
  def create_graph(f, value)
    f.title(:text => value["title"])

    case value["type"]
    when "line" then
      line_graph(f,value)
      f.plotOptions(:line => { :dataLabels => {:enabled => true}})
    when "column" then
      column_graph(f,value)
      f.plotOptions(:column => { :dataLabels => {:enabled => true}})
    when "pie" then
      pie_graph(f,value)
    when "scatter" then
      scatter_graph(f,value)
    else
      puts "どれにもあてはまってないよーーーー"
    end
    return f
  end

  def line_graph(f,value)
    f.xAxis({title: {text: value["xAxis"]["title"], margin: 20}, categories: value["xAxis"]["categories"]})
    f.yAxis({title: {text: value["yAxis"]["title"], margin: 20}})
    value["yAxis"]["series"].each do |se|
      f.series(:name => se["name"] , :data => se["data"])
    end
  end

  def column_graph(f,value)
    line_graph(f,value)
    f.plotOptions(column: {stacking: value["yAxis"]["plotOptions"]["column"]["stacking"]})
  end

  def pie_graph(f, value)
    data = []
    value["series"].each do |s|
      s["data"].each do |d|
        data << [d["name"],d["y"].pop]
      end
      f.series(:name => s["name"],:data => data)
      f.plotOptions(:pie => {:allowPointSelect => true, :cursor => 'pointer',
          :dataLabels => {
            :enabled => true,
            :format => '<b>{point.name}</b>: {point.percentage:.1f} % ( {point.y} )'
          }})
    end
  end

  def scatter_graph(f,value)
    f.yAxis({title: {text: value["yAxis"]["title"], margin: 20}})

    value["yAxis"]["series"].each do |s|
      data = []
      s["data"].each do |d|
        data << d
      end
      f.series(:name => s["name"], :data => data)
    end


  end
end
