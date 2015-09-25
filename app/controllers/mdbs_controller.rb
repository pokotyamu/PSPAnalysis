# -*- coding: utf-8 -*-
class MdbsController < ApplicationController
  def index
    @mdbs = Mdb.all
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
  
end
