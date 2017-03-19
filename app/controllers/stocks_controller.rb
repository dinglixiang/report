class StocksController < ApplicationController
  before_action :search_stocks, only: [:index, :download]

  def index
    @stocks = @stocks.page(params[:page]).per(25)

    respond_to do |format|
      format.html
      format.js
    end
  end

  def import
    Stock.import(params[:file], current_user)
    redirect_to stocks_path
  end

  def truncate
    Stock.where(user_id: current_user.id).delete_all
    redirect_to new_stock_path
  end

  def download
    Spreadsheet.client_encoding = 'UTF-8'
    book = Spreadsheet::Workbook.new
    sheet1 = book.create_worksheet :name => 'Sheet1'
    format = Spreadsheet::Format.new color: :black, weight: :bold, size: 12
    sheet1.row(0).default_format = format

    sheet1.row(0).concat %w{品名 规格 包装单位 厂家 库存数量}
    @stocks.each_with_index do |stock, index|
      sheet1.row(index+1).push(*[stock.name, stock.size, stock.unit, stock.company, format("%.3f", stock.stock_volume)].flatten)
    end
    filepath = Rails.root + "public/exports/#{Date.today}.xls"
    book.write filepath
    send_file filepath
  end

  private
  def search_stocks
    @stocks = params[:search].blank? ? current_user.stocks.none : current_user.stocks.where(search_params)

    @stocks = @stocks.order(:name)
  end

  def search_params
    return download_params unless params[:stock].present?
    params[:stock].permit(name: []).to_unsafe_h.deep_delete_blank
  end

  def download_params
    { name: split_field(params[:name]) }.deep_delete_blank
  end

  def split_field(field)
    field.split(',') unless field.blank? || field.inquiry.null?
  end
end
