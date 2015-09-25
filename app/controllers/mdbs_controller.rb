# -*- coding: utf-8 -*-
class MdbsController < ApplicationController
  def index
    @mdbs = Mdb.all
  end

  def import
    Mdb.import(params[:file])
    redirect_to root_url, notice: "追加しました"
  end
end
