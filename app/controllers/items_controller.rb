class ItemsController < ApplicationController
  layout "inventory"

  def create
    @item = Item.create(item_create_params)
    flash[:success] = "#{@item.user}'s #{@item.model} was succesfully added!"
    redirect_to :back
  end
  
  def find
    @items = Item.where(item_find_params)
    respond_to do |format|
      format.html
      format.xml  {render xml:  @items.to_xml}
      format.json {render json: @items.to_json}
    end
  end

  def show
    @item = Item.find(params[:id])
    respond_to do |format|
      format.html
      format.xml  {render xml:  @item.to_xml}
      format.json {render json: @item.to_json}
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_update_params)
      flash[:success] = "#{@item.user}'s #{@item.model} was succesfully updated!"
    else
      flash[:error] = "There was a problem updating #{@item.user}'s #{@item.model}.  Please try again."
    end
    redirect_to :back
  end

  def swap
    @item = Item.find(params[:id])
  end

  private

  def item_find_params
    p = params.dup
    p.delete(:controller)
    p.delete(:action)
    p.delete(:format)
    p
  end

  def item_update_params
    params.require(:item).permit(permitted_item_params)
  end

  def item_create_params
    params.require(:item).permit(permitted_item_params)
  end
  def permitted_item_params
    [:user, :department, :location, :make, :model, :barcode, :serial, :express_service_code, :computer_name, :ip_address, :wireless_mac, :wired_mac, :swap_cycle_number, :swap_cycle_span, :warranty_start, :notes, :received]
  end
end
