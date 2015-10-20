# -*- coding: utf-8 -*-
require 'json'

class MdbsController < ApplicationController
  def index
    @mdbs = Mdb.all
    respond_to do |format|
      format.html
      format.json {render "index", :formats => [:json],:handlers => [:jbuilder]}
    end

  end

  def import
    Mdb.import(params[:file])
    redirect_to root_url, notice: "追加しました"
  end

  def download
    data_file = Mdb.find(params[:mdb_id])
    send_data(data_file.file,
      filename: data_file.file_name)
  end

  def destroy
    @mdb = Mdb.find(params[:mdb_id])
    @mdb.destroy
    respond_to do |format|
      format.html {redirect_to root_url, notice: "successfully destroyed"}
    end
  end

  def analyze
    @mdb = Mdb.find(params[:mdb_id])
    respond_to do |format|
      format.json {render "analyze", :formats => [:json],:handlers => [:jbuilder]}
    end
  end
  
end
