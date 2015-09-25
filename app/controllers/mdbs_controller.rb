class MdbsController < ApplicationController
  def index
    @mdbs = Mdb.all
  end
end
