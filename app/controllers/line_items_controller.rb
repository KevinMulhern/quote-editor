class LineItemsController < ApplicationController
  before_action :set_quote
  before_action :set_line_item_date
  before_action :set_line_item, only: [:edit, :update, :destroy]


  def new
    @line_item = @line_item_date.line_items.build
  end

  def create
    @line_item = @line_item_date.line_items.build(line_item_params)

    if @line_item.save
      respond_to do |format|
        format.html do
          redirect_to quote_path(@quote), notice: "Item was successfully created."
        end
        format.turbo_stream do
          flash.now[:notice] = "Item was successfully created."
        end
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @line_item.update(line_item_params)
      respond_to do |format|
        format.html do
          redirect_to quote_path(@quote), notice: "Item was successfully updated."
        end
        format.turbo_stream do
          flash.now[:notice] = "Item was successfully updated."
        end
      end
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @line_item.destroy

    respond_to do |format|
      format.html do
        redirect_to quote_path(@quote), notice: "Item was successfully destroyed."
      end
      format.turbo_stream do
        flash.now[:notice] = "Item was successfully destroyed."
      end
    end
  end

  private

  def line_item_params
    params.require(:line_item).permit(:name, :description, :quantity, :unit_price)
  end

  def set_quote
    @quote = current_company.quotes.find(params[:quote_id])
  end

  def set_line_item_date
    @line_item_date = @quote.line_item_dates.find(params[:line_item_date_id])
  end

  def set_line_item
    @line_item = @line_item_date.line_items.find(params[:id])
  end

end
